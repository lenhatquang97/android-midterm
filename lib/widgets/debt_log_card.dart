import 'package:android_midterm/models/debt_model.dart';
import 'package:android_midterm/utils/currency_util.dart';
import 'package:flutter/material.dart';

class DebtLogCard extends StatelessWidget {
  final DebtModel model;
  const DebtLogCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.isDebt == false ? 'Tôi cho nợ' : 'Tôi nợ',
                  style: TextStyle(
                      fontSize: 20,
                      color: model.isDebt == false ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model.name, style: const TextStyle(fontSize: 20)),
                  Text(formatMoney(model.amount),
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            model.isDebt == false ? Colors.green : Colors.red,
                      ))
                ],
              ),
              const SizedBox(height: 5),
              Text(
                  '${model.dueDate.day}/${model.dueDate.month}/${model.dueDate.year}',
                  style: const TextStyle(fontSize: 20))
            ],
          ),
        ));
  }
}
