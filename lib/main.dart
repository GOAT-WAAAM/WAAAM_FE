import 'package:bocket_test/Notify/notify_page.dart';
import 'package:bocket_test/Notify/notify_permission.dart';
import 'package:bocket_test/Provider/token_provider.dart';
import 'package:bocket_test/WriteContent/PreWrite.dart';
import 'package:bocket_test/WriteContent/ReviewContent.dart';
import 'package:bocket_test/login/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:bocket_test/login/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'Provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home_page/main_page.dart';
import 'my_page/MyPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await dotenv.load(fileName: '.env'); // Required by FlutterConfig
  var appKey = dotenv.env['jsAppKey'];
  KakaoSdk.init(javaScriptAppKey: appKey);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>TokenProvider()),
      ChangeNotifierProvider(create: (_)=>UserProvider()),
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
      home: ReviewContent(),

    );
  }
}



// CurationScreen(stories: stories)