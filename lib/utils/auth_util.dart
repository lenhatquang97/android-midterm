//Firebase sign in with Email and Password

// ignore_for_file: avoid_print

import 'package:android_midterm/utils/user_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auto_route/auto_route.dart';
import 'package:android_midterm/routes/app_router.gr.dart';

class AuthenticationUtils {
  static Future<User?> signUpUsingEmailPassword(
      BuildContext context, String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thành công!!!'),
        ),
      );

      context.router.pushNamed('/signin');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mật khẩu không đủ mạnh'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email đã bị người khác đăng ký!!'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword(
      String email, String password, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await SecureStorage.writeSecureData(SecureStorage.userID, user!.uid);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng nhập thành công!!'),
        ),
      );
      context.router.replaceNamed('/dashboard');
    } on FirebaseAuthException catch (e) {
      print(e.code);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email hoặc mật khẩu chưa đúng!!!'),
        ),
      );
    }
    return user;
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<User?> signInUsingGoogleAccount(BuildContext context) async {
    User? user;
    try {
      UserCredential userCredential = await signInWithGoogle();
      user = userCredential.user;
      await SecureStorage.writeSecureData(SecureStorage.userID, user!.uid);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng nhập với Google thành công!!'),
        ),
      );
      context.router.replaceNamed('/dashboard');
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Có lỗi trong quá trình đăng nhập Google!!'),
        ),
      );
    }
    return user;
  }

  //Sign out in firebase
  static Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await SecureStorage.deleteSecureData(SecureStorage.userID);
    context.router.replaceNamed('/signin');
  }
}
