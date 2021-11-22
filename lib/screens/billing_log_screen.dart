import 'package:android_midterm/logic/fetch_debt_or_bill.dart';
import 'package:android_midterm/models/debt_model.dart';
import 'package:android_midterm/models/order_model.dart';
import 'package:android_midterm/routes/app_router.gr.dart';
import 'package:android_midterm/screens/add_order.dart' as ao;
import 'package:android_midterm/widgets/billing_log_card.dart';
import 'package:android_midterm/widgets/debt_log_card.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

class BillingLogScreen extends StatefulWidget {
  const BillingLogScreen({Key? key}) : super(key: key);

  @override
  State<BillingLogScreen> createState() => _BillingLogScreenState();
}

class _BillingLogScreenState extends State<BillingLogScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff0f0f5),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: const Text(
                'Đơn hàng',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<Map<String, Map<String, dynamic>>>(
              future: fetchData('donhang'),
              builder: (context,
                  AsyncSnapshot<Map<String, Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return Expanded(
                      child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: data!.entries
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      context.router
                                          .push(OrderScreen(orderId: e.key));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: BillingLogCard(
                                        model: OrderModel.fromJson(e.value),
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
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ao.AddOrder()));
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
                            Text('Thêm đơn hàng',
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
