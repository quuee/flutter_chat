import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat/app/network/model/message_wrapper.dart';
import 'package:get/get.dart' as getx;
import 'package:web_socket_channel/io.dart';

import '/app/data/local/preference/preference_manager.dart';
import '/flavors/build_config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'model/conversation_type.dart';


enum ConnectStatusEnum { connect, connecting, close, closing }

typedef ListenMessageCallback = void Function(String msg);

typedef ErrorCallback = void Function(Exception error);

class WebSocketProvider {
  final logger = BuildConfig.instance.config.logger;
  static final String wsUrl = BuildConfig.instance.config.wsUrl;

  final PreferenceManager _preferenceManager = getx.Get.find(tag: (PreferenceManager).toString());

  // 单例本身
  static final WebSocketProvider _instance = WebSocketProvider._internal();

  factory WebSocketProvider() {
    return _instance;
  }

  // 通用全局单例，第一次使用时初始化
  WebSocketProvider._internal() {}

  //============================websocket======================================

  ConnectStatusEnum _connectStatus = ConnectStatusEnum.close;

  Stream<dynamic>? _webSocketChannelStream;

  final StreamController<ConnectStatusEnum> _socketStatusController = StreamController<ConnectStatusEnum>();

  // Stream<ConnectStatusEnum>? _socketStatusStream;

  static WebSocketChannel? _channel;

  Timer? _heartBeat;
  final int _heartbeatSeconds = 30;

  final int _reconnectMax = 10;
  int _reconnectTimes = 0;
  Timer? _reconnectTimer;

  // Stream<dynamic> getWebSocketChannelStream() {
  //   // 只分配一次 重连后这个_webSocketChannelStream不对劲
  //   _webSocketChannelStream ??= _channel?.stream.asBroadcastStream();
  //   return _webSocketChannelStream!;
  // }

  // Stream<ConnectStatusEnum> getSocketStatusStream() {
  //   //Assign the value only once.
  //   _socketStatusStream ??= _socketStatusController.stream.asBroadcastStream();
  //   return _socketStatusStream!;
  // }

  Future<bool> connect() async {
    if (_connectStatus == ConnectStatusEnum.connect) {
      //Connected, no further processing required.
      return true;
    }
    String token = await _preferenceManager.getString(PreferenceManager.keyToken);
    if (_connectStatus == ConnectStatusEnum.close) {
      //Not connected, initiate the connection.
      _connectStatus = ConnectStatusEnum.connecting;
      _socketStatusController.add(ConnectStatusEnum.connecting);
      var connectUrl = Uri.parse(wsUrl);

      // The Channel needs to be used on the web end, otherwise an error will occur.
      if (kIsWeb) {
        _channel = WebSocketChannel.connect(connectUrl);
      } else {
        _channel = IOWebSocketChannel.connect(
          connectUrl,
          headers: {
            "Authorization": '',
          },
            protocols:[token]
        );
      }
      // login();
      _connectStatus = ConnectStatusEnum.connect;
      _socketStatusController.add(ConnectStatusEnum.connect);
      _webSocketChannelStream = _channel?.stream.asBroadcastStream();
      if (_reconnectTimes == 0) {
        logger.i("First successful socket connection.");
      } else {
        logger.i("Reconnection successful.");
      }
      _reconnectTimes = 0;
      if (_reconnectTimer != null) {
        _reconnectTimer?.cancel();
        _reconnectTimer = null;
      }
      return true;
    } else {
      return false;
    }
  }

  Future disconnect() async {
    if (_connectStatus == ConnectStatusEnum.connect) {
      _connectStatus = ConnectStatusEnum.closing;
      if (!_socketStatusController.isClosed) {
        _socketStatusController.add(ConnectStatusEnum.closing);
      }
      await _channel?.sink
          .close(status.goingAway, "Close the connection actively.");

      _connectStatus = ConnectStatusEnum.close;
      _webSocketChannelStream = null;
      if (!_socketStatusController.isClosed) {
        _socketStatusController.add(ConnectStatusEnum.close);
      }
    }
  }

  void reconnect(String url) async {
    logger.i("----------------------------");
    if (_reconnectTimes < _reconnectMax) {
      _reconnectTimes++;
      logger.i("Reconnecting, this is the $_reconnectTimes reconnection");
      _reconnectTimer =
          Timer.periodic(Duration(seconds: _heartbeatSeconds), (timer) async {
            await disconnect();
            await connect();
          });
    } else {
      if (_reconnectTimer != null) {
        logger.i("The reconnection attempts have exceeded the maximum limit.");
        _reconnectTimer?.cancel();
        _reconnectTimer = null;
        _connectStatus = ConnectStatusEnum.close;
      }
      return;
    }
  }

  void listen(ListenMessageCallback messageCallback, {ErrorCallback? onError}) {
    _webSocketChannelStream?.listen((message) {
      messageCallback.call(message);
    }, onError: (error) {
      //Connection exception
      _connectStatus = ConnectStatusEnum.close;
      _socketStatusController.add(ConnectStatusEnum.close);
      if (onError != null) {
        onError.call(error);
      }
    }, onDone: () {
      // 掉线重连
      reconnect(wsUrl);
    });
  }

  Future<MessageWrapper> sendMsg(MessageWrapper sendInfo) async {
    _channel?.sink.add(sendInfo.toJsonString());
    // 异步需要返回结果使用Completer
    Completer<MessageWrapper> completer = Completer<MessageWrapper>();
    late StreamSubscription<dynamic> subscription;
    if (_connectStatus != ConnectStatusEnum.connect) {
      completer.completeError("Socket not connected.");
      return completer.future;
    }
    try {
      subscription = _webSocketChannelStream!.listen(
            (backMessage) {
          // Message sent successfully
              MessageWrapper data = MessageWrapper.fromJson(json.decode(backMessage));
          completer.complete(data);
          // Stop listening because the desired response has been received
          subscription.cancel();
          logger.i("completer.isCompleted:${completer.isCompleted},MessageWrapper:${data.toJsonString()}");
        },
        onError: (error) {
          logger.i('Failed to send message: ${error.toString()}');
          completer.completeError(error);
        },
        cancelOnError: true,
      );

      // Set the timeout period to 30 seconds
      const timeout = Duration(seconds: 30);
      // Mark the Completer as failed after a timeout
      Future.delayed(timeout, () {
        logger.i("Future.delayed completer.isCompleted:${completer.isCompleted}");
        if (!completer.isCompleted) {
          logger.i('Timeout: No response from the server');
          // completer
          //     .completeError(TimeoutException('No response from the server'));
          subscription.cancel(); // unListen
        }
      });
    } catch (error) {
      logger.i('Failed to send message: ${error.toString()}');
      completer.completeError(error);
      subscription.cancel();
    }
    return completer.future;
  }

  ConnectStatusEnum getCurrentStatus() {
    if (_connectStatus == ConnectStatusEnum.connect) {
      return ConnectStatusEnum.connect;
    } else if (_connectStatus == ConnectStatusEnum.connecting) {
      return ConnectStatusEnum.connecting;
    } else if (_connectStatus == ConnectStatusEnum.close) {
      return ConnectStatusEnum.close;
    } else if (_connectStatus == ConnectStatusEnum.closing) {
      return ConnectStatusEnum.closing;
    }
    return ConnectStatusEnum.closing;
  }


  void startHeartBeat() {
    destroyHeartBeat();

    _heartBeat = Timer.periodic(Duration(seconds: _heartbeatSeconds), (timer) {
      var message = MessageWrapper(conversationType: ConversationType.HEART_BEAT,data: {"msg":"HeartBeat"});
      logger.i('send sentHeart: ${message.toJsonString()}');
      sendMsg(message);
    });
  }


  void destroyHeartBeat() {
    if (_heartBeat != null) {
      _heartBeat?.cancel();
      _heartBeat = null;
    }
  }

  void dispose() {
    //Disconnect the connection.
    disconnect();
    //Close the flow of the connection status.
    _socketStatusController.close();
  }

}
