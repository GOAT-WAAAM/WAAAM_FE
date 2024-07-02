import 'package:bocket_test/LoginPage.dart';
import 'package:bocket_test/home_page/main_page.dart';
import 'package:bocket_test/kakao_login.dart';
import 'package:bocket_test/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env'); // Required by FlutterConfig
  var appKey = dotenv.env['nativeAppKey'];
  KakaoSdk.init(nativeAppKey: appKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waaam',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: MyHomePage(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

