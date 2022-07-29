import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_health_project/firebase/firestore_model.dart';
import 'package:smart_health_project/functions/show_snackbar.dart';
import 'package:smart_health_project/models/user_model.dart';
import 'package:smart_health_project/screens/home_screen.dart';
import 'package:smart_health_project/screens/splash_screen.dart';

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  //create account using email and pass
  Future<void> createAccount(
      UserModel userModel, String password, BuildContext context) async {
    // print("reached");
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);
      var newUserModel = userModel.copyWith(uid: cred.user!.uid);
      await FirestoreMethods().addUserModel(newUserModel);
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const HomeScreen()),
          (route) => false);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  // login user
  Future<void> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const HomeScreen()),
          (route) => false);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<void> logoutUser(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => const SplashScreen()),
        (route) => false);
  }
}
