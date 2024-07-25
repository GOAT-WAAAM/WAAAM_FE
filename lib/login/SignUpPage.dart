import 'package:flutter/material.dart';
import '../home_page/main_page.dart';
import '../onboarding_page/onBoarding1.dart';
import 'kakao_login.dart';
import 'main_view_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:bocket_test/Provider/token_provider.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final viewModel = MainViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "떠먹여 주는 복습",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 4),
            Image.asset('assets/image/logo.png', width: 141, height: 28),
            Image.asset('assets/image/login.png', width: 359,height: 359,),
            SizedBox(height: 16),
            Text("SNS 계정으로 시작하기", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
            SizedBox(height: 33,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
              children: [
                GestureDetector(
                  onTap: () async {
                    await viewModel.login();
                    setState(() {
                      if (viewModel.isLogined) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      }
                    });
                  },
                  child: Image.asset(
                    'assets/image/kakao.png',
                    width: 58,
                    height: 58,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            TextButton(
                onPressed: () async{
              final url='http://43.202.27.170/goat/auth/signup';
              final response=await http.get(Uri.parse(url));

              if(response.statusCode==200){
                final Map<String,dynamic> responseBody = json.decode(response.body);
                if(responseBody['isSuccess']){
                  final accessToken=responseBody['results']['accessToken'];
                  Provider.of<TokenProvider>(context, listen:false).setAccessToken(accessToken);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context)=>onBoard1()),
                  );
                } else{
                  print('Signup failed: ${responseBody['message']}');
                }
              }else{
                print('Error:${response.statusCode}');
              }
            }, child: Text("회원가입", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF888888), decoration: TextDecoration.underline, decorationColor: Color(0xFF888888)))),
          ],
        ),
      ),
    );
  }
}