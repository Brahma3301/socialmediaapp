import 'package:flutter/material.dart';
import 'package:socialapp/models/user.dart';
import 'package:socialapp/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

  User? get getUser => _user;
}
