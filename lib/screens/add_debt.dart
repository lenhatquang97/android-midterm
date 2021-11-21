import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddDebt extends StatefulWidget {
  const AddDebt({Key? key}) : super(key: key);

  @override
  _AddDebtState createState() => _AddDebtState();
}

class _AddDebtState extends State<AddDebt> {
  // ignore: unused_field, non_constant_identifier_names
  DateTime _date_time = DateTime.now();
  // ignore: non_constant_identifier_names
  bool _button_index = true; //true == left false == right

  // ignore: non_constant_identifier_names
  void _set_date_time(DateTime a) {
    setState(() {
      _date_time = a;
    });
  }

  // ignore: non_constant_identifier_names
  void _left_button_click() {
    setState(() {
      _button_index = true;
    });
  }

  // ignore: non_constant_identifier_names
  void _right_button_click() {
    setState(() {
      _button_index = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Debt Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: const IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: null,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        const TextSpan(
                            text: "Khoan ghi ngay ",
                            style: TextStyle(fontSize: 20)),
                        TextSpan(
                          text: _date_time.day.toString() +
                              "/" +
                              _date_time.month.toString() +
                              "/" +
                              _date_time.year.toString(),
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2222))
                                  .then((date) => {_set_date_time(date!)});
                            },
                        )
                      ]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                height: 60,
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 50),
                        child: ElevatedButton(
                          onPressed: _left_button_click,
                          child: const Text(
                            'Toi cho no',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              backgroundColor: _button_index
                                  ? MaterialStateProperty.all(Colors.green[400])
                                  : MaterialStateProperty.all(Colors.grey),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ))),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 50),
                        child: ElevatedButton(
                          onPressed: _right_button_click,
                          child: const Text(
                            "Toi no",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              backgroundColor: !_button_index
                                  ? MaterialStateProperty.all(Colors.red[400])
                                  : MaterialStateProperty.all(Colors.grey),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ))),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5)
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  textAlignVertical: const TextAlignVertical(y: 0.5),
                  decoration: InputDecoration(
                      hintText: _button_index ? "Ten nguoi no" : "Ten chu no",
                      prefixIcon: const Icon(Icons.person)),
                ),
                TextFormField(
                  textAlignVertical: const TextAlignVertical(y: 0.5),
                  decoration: const InputDecoration(
                      hintText: 'So tien',
                      prefixIcon: Icon(Icons.attach_money)),
                ),
                TextFormField(
                  textAlignVertical: const TextAlignVertical(y: 0.5),
                  decoration: const InputDecoration(
                      hintText: 'Mo ta', prefixIcon: Icon(Icons.description)),
                ),
                TextFormField(
                  textAlignVertical: const TextAlignVertical(y: 0.5),
                  decoration: const InputDecoration(
                      hintText: 'So dien thoai', prefixIcon: Icon(Icons.phone)),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(height: 50),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Luu"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                      )),
                ),
                const SizedBox(width: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
