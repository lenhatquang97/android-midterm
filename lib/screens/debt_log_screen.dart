// ignore_for_file: non_constant_identifier_names

import 'package:android_midterm/logic/fetch_debt_or_bill.dart';
import 'package:android_midterm/models/debt_model.dart';
import 'package:android_midterm/routes/app_router.gr.dart';
import 'package:android_midterm/widgets/debt_log_card.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

//Create a screen with ListView of DebtLog
//DebtLog contains IsDebt, Person, Money, Date, Description
//IsDebt is a boolean, Person is a string, Money is a double, Date is a string, Description is a string
class DebtLogScreen extends StatelessWidget {
  const DebtLogScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sổ nợ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Tổng cho nợ',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Text('4.899.000đ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.green))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Tổng tôi nợ',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Text('100.000đ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.red))
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder<Map<String, Map<String, dynamic>>>(
              future: fetchData('khoanno'),
              // ignore: avoid_types_as_parameter_names
              builder: (context,
                  AsyncSnapshot<Map<String, Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return Expanded(
                      child: ListView(
                          children: data!.entries
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      context.router
                                          .push(DebtScreen(debtId: e.key));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: DebtLogCard(
                                        model: DebtModel.fromJson(e.value),
                                      ),
                                    ),
                                  ))
                              .toList()));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {},
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add),
                          SizedBox(width: 10),
                          Text('Thêm khách hàng',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ))),
            )
          ]),
        ),
      ),
    );
  }
}
