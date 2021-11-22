import 'package:android_midterm/models/debt_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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

  //Text Controller
  final _name_field_controller = TextEditingController();
  final _amount_field_controller = TextEditingController();
  final _desc_field_controller = TextEditingController();
  final _phone_field_controller = TextEditingController();
  final _form_key = GlobalKey<FormState>();

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
            "Thêm khoản nợ",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(children: [
                            Text("KHOẢN GHI NGÀY",
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                ))),
                            const SizedBox(height: 10),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: _date_time.day.toString() +
                                      "/" +
                                      _date_time.month.toString() +
                                      "/" +
                                      _date_time.year.toString(),
                                  style: const TextStyle(
                                      color: Colors.blue, fontSize: 25),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2001),
                                              lastDate: DateTime(2222))
                                          .then((date) =>
                                              {_set_date_time(date!)});
                                    },
                                )
                              ]),
                            ),
                          ])),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: [
                            const SizedBox(width: 5),
                            Expanded(
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints.tightFor(height: 50),
                                child: ElevatedButton(
                                  onPressed: _left_button_click,
                                  child: const Text(
                                    'Tôi cho nợ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      backgroundColor: _button_index
                                          ? MaterialStateProperty.all(
                                              Colors.green[400])
                                          : MaterialStateProperty.all(
                                              Colors.grey),
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
                                constraints:
                                    const BoxConstraints.tightFor(height: 50),
                                child: ElevatedButton(
                                  onPressed: _right_button_click,
                                  child: const Text(
                                    "Tôi nợ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      backgroundColor: !_button_index
                                          ? MaterialStateProperty.all(
                                              Colors.red[400])
                                          : MaterialStateProperty.all(
                                              Colors.grey),
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
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          textAlignVertical: const TextAlignVertical(y: 0.5),
                          decoration: InputDecoration(
                              hintText:
                                  _button_index ? "Tên người nợ" : "Tên chủ nợ",
                              prefixIcon: const Icon(Icons.person)),
                        ),
                        TextFormField(
                          textAlignVertical: const TextAlignVertical(y: 0.5),
                          decoration: const InputDecoration(
                              hintText: 'Số tiền',
                              prefixIcon: Icon(Icons.attach_money)),
                        ),
                        const TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textAlignVertical: TextAlignVertical(y: 0.5),
                          decoration: InputDecoration(
                              hintText: 'Mô tả',
                              prefixIcon: Icon(Icons.description)),
                        ),
                        TextFormField(
                          textAlignVertical: const TextAlignVertical(y: 0.5),
                          decoration: const InputDecoration(
                              hintText: 'Số điện thoại',
                              prefixIcon: Icon(Icons.phone)),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 50),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Luu"),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15)))),
                        )),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            flex: 5,
            child: Form(
              key: _form_key,
              child: Column(
                children: [
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui long nhap ten';
                      }
                      return null;
                    },
                    controller: _name_field_controller,
                    textAlignVertical: const TextAlignVertical(y: 0.5),
                    decoration: InputDecoration(
                        hintText: _button_index ? "Ten nguoi no" : "Ten chu no",
                        prefixIcon: const Icon(Icons.person)),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui long nhap so tien';
                      }
                      try {
                        int.parse(value);
                        return null;
                      } catch (error) {
                        return 'Vui long nhap dung dinh dang';
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlignVertical: const TextAlignVertical(y: 0.5),
                    controller: _amount_field_controller,
                    decoration: const InputDecoration(
                        hintText: 'So tien',
                        prefixIcon: Icon(Icons.attach_money)),
                  ),
                  TextFormField(
                    textAlignVertical: const TextAlignVertical(y: 0.5),
                    controller: _desc_field_controller,
                    decoration: const InputDecoration(
                        hintText: 'Mo ta', prefixIcon: Icon(Icons.description)),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui long nhap so dien thoai';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    textAlignVertical: const TextAlignVertical(y: 0.5),
                    controller: _phone_field_controller,
                    decoration: const InputDecoration(
                        hintText: 'So dien thoai',
                        prefixIcon: Icon(Icons.phone)),
                  ),
                ],
              ),
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
                        onPressed: () async {
                          if (_form_key.currentState!.validate()) {
                            var amount =
                                int.parse(_amount_field_controller.text);
                            var name = _name_field_controller.text;
                            var phone = _phone_field_controller.text;
                            var desc = _desc_field_controller.text;
                            if (desc.isEmpty) {
                              desc = "";
                            }
                            var object = DebtModel(
                                amount: amount,
                                dueDate: _date_time,
                                createdAt: DateTime.now(),
                                enable: true,
                                isDebt: !_button_index,
                                name: name,
                                note: desc,
                                phone: phone,
                                createdBy: "db0xxGEch0PWi4iXQ9ax3HnXcV12");
                            await object.createDebt();
                            Navigator.pop(context);
                          }
                        },
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
