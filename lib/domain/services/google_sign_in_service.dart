abstract class GoogleSignInService {
  Future<String?> signIn();

  Future<void> signOut();
}
