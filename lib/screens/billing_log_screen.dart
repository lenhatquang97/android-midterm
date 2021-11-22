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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Đơn hàng',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ao.AddOrder()));
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add),
                          SizedBox(width: 10),
                          Text('Thêm đơn hàng', style: TextStyle(fontSize: 20)),
                        ],
                      ))),
            )
          ]),
        ),
      ),
    );
  }
}
