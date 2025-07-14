import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isLoggedin => user != null;
  User? get user => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<UserCredential> emailSignup(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signout() async {
    await _auth.signOut();
  }

  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> githubLogin() async {
    return await _auth.signInWithProvider(GithubAuthProvider());
  }
}

final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepo());

final authStateProvider = StreamProvider<User?>((ref) {
  final repo = ref.read(authRepoProvider);
  return repo.authStateChanges();
});
