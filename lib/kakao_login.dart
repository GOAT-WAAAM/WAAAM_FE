import 'package:bocket_test/social_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KakaoLogin implements SocialLogin {
  final FlutterSecureStorage _storage = FlutterSecureStorage(); // _storage 초기화

  @override
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token; // Token Object

      if (isInstalled) {
        try {
          token = await UserApi.instance.loginWithKakaoTalk();
        } catch (e) {
          print("Failed to login with KakaoTalk: $e");
          return false;
        }
      } else {
        try {
          token = await UserApi.instance.loginWithKakaoAccount();
        } catch (e) {
          print("Failed to login with KakaoAccount: $e");
          return false;
        }
      }

      if (token != null) {
        await _storage.write(key: "accessToken", value: token.accessToken);
        await _storage.write(key: "refreshToken", value: token.refreshToken);
        print("Access token saved: ${token.accessToken}");
        print("Refresh token saved: ${token.refreshToken}");
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("Error logging in: $error");
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      // await _storage.delete(key: "accessToken"); // Delete token on logout
      // await _storage.delete(key: "refreshToken");
      // print("Access token deleted");
      return true;
    } catch (error) {
      print("Error logging out: $error");
      return false;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: "accessToken");
  }
}

