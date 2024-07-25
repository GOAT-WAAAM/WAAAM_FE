import 'package:provider/provider.dart';
import 'package:bocket_test/components/QuitPopup.dart';
import 'package:bocket_test/login/LoginPage.dart';
import 'package:bocket_test/login/SignUpPage.dart';
import 'package:bocket_test/onboarding_page/onBoarding2.dart';
import 'package:bocket_test/onboarding_page/onBoardingComplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'home_page/main_page.dart';
import 'my_page/MyPage.dart';
import 'onboarding_page/onBoarding1.dart';
import 'onboarding_page/onBoarding3.dart';
import 'token_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await dotenv.load(fileName: '.env'); // Required by FlutterConfig
  var appKey = dotenv.env['jsAppKey'];
  KakaoSdk.init(javaScriptAppKey: appKey);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>TokenProvider()),
    ],
      child: const MyApp()));
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

    );
  }
}



// CurationScreen(stories: stories)