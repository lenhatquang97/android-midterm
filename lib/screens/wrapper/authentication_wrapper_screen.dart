import 'package:android_midterm/screens/dashboard_screen.dart';
import 'package:android_midterm/screens/authentication/sign_in_screen.dart';
import 'package:android_midterm/utils/user_storage.dart';
import 'package:flutter/material.dart';

class AuthenticationWrapperScreen extends StatelessWidget {
  const AuthenticationWrapperScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SecureStorage.readSecureData(SecureStorage.userID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const SignInScreen();
            }
            return DashboardScreen();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
