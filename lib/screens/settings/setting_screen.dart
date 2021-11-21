// ignore_for_file: must_be_immutable

import 'package:android_midterm/utils/auth_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  String name = FirebaseAuth.instance.currentUser!.email as String;
  String avatarURL = FirebaseAuth.instance.currentUser!.photoURL ?? "none";

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
              avatarURL != "none"
                  ? CircleAvatar(
                      minRadius: 30,
                      maxRadius: 40,
                      backgroundImage: NetworkImage(avatarURL))
                  : CircleAvatar(
                      minRadius: 30,
                      maxRadius: 40,
                      child: Text(
                        name.substring(0, 1),
                        style: const TextStyle(fontSize: 40),
                      )),
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
