abstract class SocialLogin{
  Future<bool> login();
  Future<bool> logout();
  Future<String?> getAccessToken(); // Access 토큰을 가져오는 메서드
}