import 'package:bocket_test/WriteContent/ReviewContent.dart';
import 'package:bocket_test/WriteContent/upload_success.dart';
import 'package:bocket_test/login/SignUpPage.dart';
import 'package:bocket_test/onboarding_page/onBoarding2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:firebase_core/firebase_core.dart'; // Add this import
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'home_page/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  // await Firebase.initializeApp();
  var appKey = dotenv.env['nativeAppKey'];
  KakaoSdk.init(javaScriptAppKey: appKey);
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
      home: MainPage(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

