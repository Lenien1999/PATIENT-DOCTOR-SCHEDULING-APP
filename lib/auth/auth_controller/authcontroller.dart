import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/bottombar_navigation.dart';
import '../../screen/splash_screen.dart';
 
import 'authexception.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> fireBaseUser;
  var verificationId = ''.obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onReady() async {
    Future.delayed(const Duration(seconds: 6));

    fireBaseUser = Rx<User?>(_auth.currentUser);
    fireBaseUser.bindStream(_auth.userChanges());
    ever(fireBaseUser, setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const SplashScreen())
        : Get.offAll(() => const BottomNavigation());
  }

  Future<void> registerUser(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (fireBaseUser.value != null) {
        Get.offAll(() => const BottomNavigation());
      } else {
        Get.to(() => const SplashScreen());
      }
    } on FirebaseAuthException catch (e) {
      final error = SignandLoginFailure.code(e.code);
      Get.snackbar("Error", error.failure,
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    } catch (_) {
      const error = SignandLoginFailure();
      Get.snackbar("Success", error.failure,
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.green);
    }
  }

  Future<void> signInUser(
      {required String email, required String password}) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final error = SignandLoginFailure.code(e.code);
      Get.snackbar("Error", error.failure,
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    } catch (_) {
      const error = SignandLoginFailure();
      Get.snackbar("Success", error.failure,
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.green);
    }
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const CircularProgressIndicator());
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", 'Password Reset Email Sent',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.green);
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      Get.back();
    }
  }
 

  Future<void> logout() async {
    await _auth.signOut();
  }
}
