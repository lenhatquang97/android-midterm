import 'package:android_midterm/screens/billing_log_screen.dart';
import 'package:android_midterm/screens/debt_log_screen.dart';
import 'package:android_midterm/screens/settings/setting_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  List<Widget> screens = [
    const DebtLogScreen(),
    const BillingLogScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontSize: 20),
        unselectedLabelStyle: const TextStyle(fontSize: 20),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Ghi nợ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.text_snippet,
            ),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Thiết lập',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue[600],
        onTap: (index) {
          // ignore: avoid_print
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
