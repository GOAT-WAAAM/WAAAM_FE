import 'package:bocket_test/social_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KakaoLogin implements SocialLogin {
  final FlutterSecureStorage _storage = FlutterSecureStorage(); // _storage 초기화

  @override
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token; //Token Object
      if(isInstalled) {
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      if(token != null){
        await _storage.write(key: "accessToken", value: token.accessToken);
        return true;
      }
      return false; // token이 null이면 false 반환
    } catch (error) {
      print("Error logging in: $error");
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      await _storage.delete(key: "accessToken"); // 로그아웃 시 토큰 제거
      return true;
    } catch (error) {
      print("Error logging out: $error");
      return false;
    }
  }
}
