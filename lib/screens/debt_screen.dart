import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui show PlaceholderAlignment;
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:android_midterm/models/debt_model.dart';

DateFormat dateFormat = DateFormat("HH:mm dd-MM-yyyy");

TextStyle defautText({int color = 0xFF000000}) {
  return GoogleFonts.nunito(
      textStyle: TextStyle(
    color: Color(color),
    fontWeight: FontWeight.w400,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    decoration: TextDecoration.none,
  ));
}

class DebtScreen extends StatefulWidget {
  final String debtId;
  const DebtScreen({Key? key, required this.debtId}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _State createState() => _State(debtId);
}

class _State extends State<DebtScreen> {
  final String debtId;
  _State(this.debtId);

  final datasets = <String, dynamic>{};
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  DebtModel debt = DebtModel.empty();
  @override
  initState() {
    super.initState();
    debt.fetchDebt(debtId, uid).then((result) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat('#,##0.00', 'ID');
    if (identical(debt, DebtModel.empty())) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              // <-- wrap this around
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => context.router.pop(),
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, top: 10.0),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: const Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 10, // changes position of shadow
                            ),
                          ],
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                alignment: ui.PlaceholderAlignment.middle,
                                child: Icon(Icons.arrow_back),
                              ),
                              TextSpan(
                                text: " Quay về",
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(30),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: const Color(0xFFFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              debt.isDebt ? 'Tôi nợ' : 'Tôi cho nợ',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color:
                                      debt.isDebt ? Colors.red : Colors.green,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 50,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              (debt.isDebt ? '-' : '') +
                                  '${formatCurrency.format(debt.amount)} đ',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color:
                                      debt.isDebt ? Colors.red : Colors.green,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Kết thúc: ${dateFormat.format(debt.dueDate)}',
                                style: defautText(color: 0xFF6886C5),
                                textAlign: TextAlign.left,
                                maxLines: 1,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                      color: const Color(0xFFFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 70,
                          offset: const Offset(
                              0, -15), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => launch("tel://${debt.phone}"),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.brown.shade800,
                                    child: Text(debt.name.isNotEmpty
                                        ? debt.name.substring(0, 1)
                                        : ""),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                        // ignore: prefer_const_constructors
                                        Text(
                                          debt.name,
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        // ignore: prefer_const_constructors
                                        Text(
                                          'SĐT: ${debt.phone}',
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0),
                                        )
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    MdiIcons.fromString('phone'),
                                    color: const Color(0xFF6886C5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              MdiIcons.fromString('calendar-clock'),
                              size: 24,
                              color: const Color(0xFF6886C5),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Tạo lúc:',
                              style: defautText(color: 0xFF6886C5),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              dateFormat.format(debt.dueDate),
                              style: defautText(color: 0xFF000000),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              MdiIcons.fromString('note'),
                              size: 24,
                              color: const Color(0xFF6886C5),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Ghi chú: ',
                              style: defautText(color: 0xFF6886C5),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            ),
                            const SizedBox(width: 15),
                            Flexible(
                              child: Text(
                                debt.note,
                                style: defautText(color: 0xFF000000),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(30),
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                      ),
                      child: const SizedBox(height: 5)),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: double.maxFinite,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: Color(0xFFFFFFFF),
            ),
            child: Row(children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: !debt.enable
                          ? null
                          : () {
                              debt.update(debtId, uid, {"enable": false}).then(
                                  (result) {
                                setState(() {});
                              });
                            },
                      child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'Chỉnh sửa',
                            style: defautText(color: 0xFFFFFFFF),
                            textAlign: TextAlign.center,
                          )))),
              const SizedBox(width: 15),
              Expanded(
                  child: ElevatedButton(
                      onPressed: !debt.enable
                          ? null
                          : () {
                              debt.update(debtId, uid, {"enable": false}).then(
                                  (result) {
                                setState(() {});
                                context.router.pushNamed('/dashboard');
                              });
                            },
                      child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            debt.enable ? 'Hoàn tất' : 'Đã hoàn tất',
                            style: defautText(color: 0xFFFFFFFF),
                            textAlign: TextAlign.center,
                          )))),
            ]),
          ),
        ],
      ),
    );
  }
}
