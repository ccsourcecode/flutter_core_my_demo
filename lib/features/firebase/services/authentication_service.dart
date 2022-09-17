import '../locator.dart';
import '../models/user.dart' as user;
import '../services/analytics_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  user.User? _currentUser;
  user.User? get currentUser => _currentUser;

  Future loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.toString();
    }
  }

  Future signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    required String role,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = user.User(
        id: authResult.user!.uid,
        email: email,
        fullName: fullName,
        userRole: role,
      );

      await _firestoreService.createUser(_currentUser!);
      await _analyticsService.setUserProperties(
        userId: authResult.user!.uid,
        userRole: _currentUser?.userRole,
      );

      return authResult.user != null;
    } catch (e) {
      return e.toString();
    }
  }

  bool isUserLoggedIn() {
    var currentUser = _firebaseAuth.currentUser;
    _populateCurrentUser(currentUser);
    return currentUser != null;
  }

  Future _populateCurrentUser(User? user) async {
    _currentUser = await _firestoreService.getUser(user?.uid);
    await _analyticsService.setUserProperties(
      userId: user?.uid,
      userRole: _currentUser?.userRole,
    );
  }
}
