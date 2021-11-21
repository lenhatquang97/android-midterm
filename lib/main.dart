import 'package:android_midterm/provider/order_provider.dart';
import 'package:android_midterm/provider/picker_provider.dart';
import 'package:android_midterm/screens/add_debt.dart';
import 'package:android_midterm/screens/add_order.dart';
import 'package:android_midterm/screens/map_picker_v2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(
          create: (context) => PickerProvider.instance,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddDebt(),
      ),
    );
  }
}
