// ignore_for_file: must_be_immutable

import 'package:android_midterm/utils/auth_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  String xx = FirebaseAuth.instance.currentUser!.photoURL as String;
  String name = FirebaseAuth.instance.currentUser!.email as String;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  minRadius: 50,
                  maxRadius: 70,
                  backgroundImage: NetworkImage(xx)),
              const SizedBox(
                height: 10,
              ),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () async {
              await AuthenticationUtils.signOut(context);
            },
            child: Row(
              children: const [
                Icon(
                  Icons.logout,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Đăng xuất',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}
