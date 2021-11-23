import 'dart:convert';

import 'package:android_midterm/models/debt_model.dart';
import 'package:android_midterm/provider/page_num_provider.dart';
import 'package:android_midterm/utils/user_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

class AddDebt extends StatefulWidget {
  const AddDebt({Key? key, this.doc_id}) : super(key: key);

  final String? doc_id;

  @override
  _AddDebtState createState() => _AddDebtState();
}

class _AddDebtState extends State<AddDebt> {
  // ignore: unused_field, non_constant_identifier_names
  DateTime _date_time = DateTime.now();
  // ignore: non_constant_identifier_names
  bool _button_index = true; //true == left false == right
  final _name_controller = TextEditingController();
  final _amount_controller = TextEditingController();
  final _desc_controller = TextEditingController();
  final _phone_controller = TextEditingController();
  final _object = DebtModel(
      amount: 0,
      dueDate: DateTime.now(),
      createdAt: DateTime.now(),
      enable: true,
      isDebt: true,
      name: "",
      note: "",
      phone: "",
      createdBy: "");

  Future<void> _loadData() async {
    String uid = await SecureStorage.readSecureData(SecureStorage.userID);
    await _object.fetchDebt(widget.doc_id, uid);
  }

  Future<void> _initState() async {
    String uid = await SecureStorage.readSecureData(SecureStorage.userID);
  }

  @override
  void initState() {
    super.initState();
    if (widget.doc_id != null) {
      _loadData().then((value) {
        _button_index = !_object.isDebt;
        _name_controller.text = _object.name;
        _amount_controller.text = _object.amount.toString();
        _desc_controller.text = _object.note;
        _phone_controller.text = _object.phone;
        setState(() {
          _date_time = _object.dueDate;
        });
      });
    }
    // } else {
    //   _initState().then((value) {
    //     setState(() {});
    //   });
    // }
  }

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
    final pageNumModel = Provider.of<PageNumProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Đơn nợ",
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
                          controller: _name_controller,
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
                          controller: _amount_controller,
                          keyboardType: TextInputType.number,
                          textAlignVertical: const TextAlignVertical(y: 0.5),
                          decoration: const InputDecoration(
                              hintText: 'Số tiền',
                              prefixIcon: Icon(Icons.attach_money)),
                        ),
                        TextField(
                          controller: _desc_controller,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textAlignVertical: const TextAlignVertical(y: 0.5),
                          decoration: const InputDecoration(
                              hintText: 'Mô tả',
                              prefixIcon: Icon(Icons.description)),
                        ),
                        TextFormField(
                          controller: _phone_controller,
                          keyboardType: TextInputType.phone,
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
              GestureDetector(
                  onTap: () async {
                    String uid = await SecureStorage.readSecureData(
                        SecureStorage.userID);
                    var name = _name_controller.text;
                    var amount = int.parse(_amount_controller.text);
                    var note = _desc_controller.text;
                    var phone = _phone_controller.text;
                    if (note.isEmpty) {
                      note = "";
                    }
                    var object = DebtModel(
                        amount: amount,
                        dueDate: _date_time,
                        createdAt: DateTime.now(),
                        enable: true,
                        isDebt: !_button_index,
                        name: name,
                        note: note,
                        phone: phone,
                        createdBy: uid);
                    await object.CreateDebt();
                    pageNumModel.pageNum = 0;
                    context.router.pushNamed('/dashboard');
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10.0),
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
                              Text('Lưu',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ],
                          )))),
            ],
          ),
        ));
  }
}
