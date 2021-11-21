import 'package:android_midterm/models/debt_model.dart';
import 'package:android_midterm/widgets/debt_log_card.dart';
import 'package:flutter/material.dart';

//Create a screen with ListView of DebtLog
//DebtLog contains IsDebt, Person, Money, Date, Description
//IsDebt is a boolean, Person is a string, Money is a double, Date is a string, Description is a string
class DebtLogScreen extends StatelessWidget {
  //final DebtModel model;
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
            Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: DebtLogCard(
                        model: DebtModel(
                            amount: 110,
                            dueDate: DateTime.now(),
                            createdAt: DateTime.now(),
                            enable: true,
                            isDebt: true,
                            name: 'abc',
                            note: 'xyz',
                            phone: '0123456789',
                            createdBy: '0')),
                  );
                },
              ),
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
