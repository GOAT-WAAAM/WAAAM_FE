import 'package:bocket_test/social_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;
  final String baseUrl = 'http://192.168.49.17:8080';
  final String provider = 'KAKAO';

  MainViewModel(this._socialLogin);

  Future<void> login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await UserApi.instance.me();
      print("로그인 성공. 유저 정보는 = ${user!.kakaoAccount}");

      // 액세스 토큰 출력 및 서버로 전송
      String? accessToken = await _socialLogin.getAccessToken();
      print("Access Token: $accessToken");

      if (accessToken != null) {
        await sendTokenToServer(accessToken);
      }
    }
  }

  Future<void> logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }

  Future<void> sendTokenToServer(String accessToken) async {
    final url = Uri.parse('$baseUrl/goat/auth/login/$provider');
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        print('Request was successful!');
        print('Response data: ${json.decode(response.body)}');
      } else {
        print('Request failed with status code ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
