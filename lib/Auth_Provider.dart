import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}
