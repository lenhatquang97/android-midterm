import 'package:android_midterm/models/order_model.dart';
import 'package:flutter/material.dart';

class BillingLogCard extends StatelessWidget {
  final OrderModel model;
  const BillingLogCard({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String allProductNames = model.products.map((e) => e.name).join(',');
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.products.length} sản phẩm',
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 5),
              Text(allProductNames,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(model.dueDate.toString(),
                  style: const TextStyle(fontSize: 20))
            ],
          ),
        ));
  }
}
