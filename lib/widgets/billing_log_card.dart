import 'package:android_midterm/models/order_model.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("HH:mm dd-MM-yyyy");

class BillingLogCard extends StatelessWidget {
  final OrderModel model;
  const BillingLogCard({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String allProductNames = model.products.map((e) => e.name).join(', ');
    return Card(
        color: model.enable ? Colors.white : Colors.grey[200],
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}',
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text('${model.address}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('${model.products.length} sản phẩm: ' + allProductNames,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(dateFormat.format(model.dueDate),
                  style: const TextStyle(fontSize: 20, color: Colors.blue))
            ],
          ),
        ));
  }
}
