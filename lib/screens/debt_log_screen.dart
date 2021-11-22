// ignore_for_file: non_constant_identifier_names

import 'package:android_midterm/logic/fetch_debt_or_bill.dart';
import 'package:android_midterm/models/debt_model.dart';
import 'package:android_midterm/routes/app_router.gr.dart';
import 'package:android_midterm/utils/currency_util.dart';
import 'package:android_midterm/screens/add_debt.dart' as ad;
import 'package:android_midterm/widgets/debt_log_card.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:styled_widget/styled_widget.dart';
import 'dart:collection';

//Create a screen with ListView of DebtLog
//DebtLog contains IsDebt, Person, Money, Date, Description
//IsDebt is a boolean, Person is a string, Money is a double, Date is a string, Description is a string
int convertBool(bool value) {
  return value ? 1 : 0;
}

class DebtLogScreen extends StatelessWidget {
  const DebtLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff0f0f5),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              // Column: (chilren:[,
              Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sổ nợ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 50),
                          ),
                          const SizedBox(height: 5),
                          const SizedBox(height: 10),
                          FutureBuilder<List<int>>(
                            future: Future.wait([
                              calculateTotal(false),
                              calculateTotal(true),
                            ]),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Tổng cho nợ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(formatMoney(snapshot.data![0]),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                color: Colors.green))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Tổng tôi nợ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(formatMoney(snapshot.data![1]),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                color: Colors.red))
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<Map<String, Map<String, dynamic>>>(
                      future: fetchData('khoanno'),
                      // ignore: avoid_types_as_parameter_names
                      builder: (context,
                          AsyncSnapshot<Map<String, Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data;
                          final sortedKeys = data!.keys.toList()
                            ..sort((a, b) => convertBool(data[b]!['enable'])
                                .compareTo(convertBool(data[a]!['enable'])));
                          final sorted = LinkedHashMap.fromIterable(sortedKeys,
                              key: (k) => k, value: (k) => data[k]!);
                          return ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: sorted.entries
                                  .map((e) => GestureDetector(
                                        onTap: () {
                                          context.router.push(DebtScreen(
                                              debtId: e.key as String));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          child: DebtLogCard(
                                            model: DebtModel.fromJson(e.value),
                                          ),
                                        ),
                                      ))
                                  .toList());
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ad.AddDebt()));
                },
                child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.blue[200]!,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Thêm khách hàng',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ],
                        )))),
          ]),
        ),
      ),
    );
  }
}
