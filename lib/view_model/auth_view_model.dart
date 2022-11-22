import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:zartek_machine/data/services/google_sign.dart';
import 'package:zartek_machine/data/services/sign_out.dart';

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;
  String error = '';
  UserCredential? userCredential;
  Future<void> signWithGoogle() async {
    error = '';
    isLoading = true;
    notifyListeners();
    try {
      userCredential = await GoogleSign().sign();
    } catch (e) {
      log(e.toString());
      error = 'Something went wrong !';
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> signOut() async {
    
    return SignOut().signOut();
  }
}
