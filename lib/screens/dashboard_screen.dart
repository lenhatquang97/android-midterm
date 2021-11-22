import 'package:android_midterm/provider/page_num_provider.dart';
import 'package:android_midterm/screens/billing_log_screen.dart';
import 'package:android_midterm/screens/debt_log_screen.dart';
import 'package:android_midterm/screens/settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  List<Widget> screens = [
    const DebtLogScreen(),
    const BillingLogScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final pageNumModel = Provider.of<PageNumProvider>(context);
    return Scaffold(
      body: screens[pageNumModel.pageNum],
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
        currentIndex: pageNumModel.pageNum,
        selectedItemColor: Colors.blue[600],
        onTap: (index) {
          // ignore: avoid_print
          pageNumModel.pageNum = index;
        },
      ),
    );
  }
}
