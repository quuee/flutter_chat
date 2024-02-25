import 'package:flutter/material.dart';
import 'package:flutter_chat/app/data/local/sqf/my_sqlite.dart';

import 'app/my_app.dart';
import 'flavors/build_config.dart';
import 'flavors/env_config.dart';
import 'flavors/environment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EnvConfig devConfig = EnvConfig(
    appName: "Flutter GetX Chat Dev",
    baseUrl: "http://192.168.1.100:41000",
    wsUrl: "ws://192.168.1.100:41001/im",
    shouldCollectCrashLog: true,
  );

  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: devConfig,
  );

  await MySqlite.forFeature();


  runApp(const MyApp());
}