
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/audio_player.dart';
import 'package:flutter_chat/app/core/values/app_colors.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class ChatItemVoice extends StatefulWidget {
  const ChatItemVoice({super.key, this.soundLocalPath, this.soundUrl, this.duration});

  final String? soundLocalPath;
  final String? soundUrl;
  final int? duration;

  @override
  State<ChatItemVoice> createState() => _ChatItemVoiceState();
}

class _ChatItemVoiceState extends State<ChatItemVoice> {

  bool _isPlaying = false;
  final _audioPlayer = AudioPlayUtil(); // 应该提取出单例


  @override
  void initState() {
    _initAudioPlayerListen();

    super.initState();
  }

  _initAudioPlayerListen(){
    _audioPlayer.listen((state) {
      switch (state.processingState) {
        case ProcessingState.idle:
        case ProcessingState.loading:
        case ProcessingState.buffering:
        case ProcessingState.ready:
          break;
        case ProcessingState.completed:
        // 重置 使可以点击重复播放
          _audioPlayer.seekPlay(const Duration(seconds: 0));
          _audioPlayer.stop();
          _isPlaying=false;
          break;
      }
    });

  }

  _initPlay() async {
    String? path = widget.soundLocalPath;
    String? url = widget.soundUrl;
    if(path != null && path.trim().isNotEmpty){
      if(File(path).existsSync()){
        _audioPlayer.setPath(path);
        _audioPlayer.play();
        return;
      }
    }

    // 如果本地不存在 则存入本地再播放
    String? savePath;
    var last = url!.split('/').last;
    last = last.split('?').first;
    if(savePath==null || savePath.trim().isEmpty){
      final dir = await getExternalStorageDirectory();
      savePath = "${dir?.path}/voices/$last";
    }

    if(!File(savePath).existsSync()){
      // dio 有baseUrl 每次下载都失败，只能重新创建dio
      Dio().download(url, savePath,onReceiveProgress: (int count,int total){
        if(count/total == 1){
          // 存在本地在播放
          bool existsSync = File(savePath!).existsSync();
          if(existsSync){
            _audioPlayer.setPath(savePath);
            _audioPlayer.play();
          }
          print('下载完成');
        }
      });
    }else{
      _audioPlayer.setPath(savePath);
      _audioPlayer.play();
    }


    // 可能网络功能打开不够彻底，在androidManifest.xml application android:usesCleartextTraffic="true"配置
    // await _audioPlayer.setUrl(url!);

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      // constraints: BoxConstraints(maxWidth: 0.7),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.colorPrimary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.duration ?? 0}',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(
              width: (widget.duration ?? 0) * 5,
            ),
          ],
        ),
        onTap: (){
          if(!_isPlaying){
            _initPlay();
            _isPlaying=true;
          }else{
            _audioPlayer.pause();
            _isPlaying=false;
          }

        },
      )
    );
  }
}


