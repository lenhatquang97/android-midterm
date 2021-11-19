import 'package:flutter/material.dart';

class BillingLogCard extends StatelessWidget {
  const BillingLogCard({Key? key}) : super(key: key);

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
            children: const [
              Text('8 sản phẩm', style: TextStyle(fontSize: 20)),
              SizedBox(height: 5),
              Text('Cơm, mực, cá, cua, nghêu, sò, hến, tôm',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text('24/10/2021', style: TextStyle(fontSize: 20))
            ],
          ),
        ));
  }
}
