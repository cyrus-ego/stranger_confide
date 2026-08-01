import '../models/facebook_login_token.dart';

abstract class FacebookSignInService {
  /// Trả về null khi người dùng chủ động hủy màn hình Facebook Login.
  Future<FacebookLoginToken?> signIn();

  Future<void> signOut();
}
