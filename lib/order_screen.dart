// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui show PlaceholderAlignment;
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MyApp());
}

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PageEntryPoint(),
    );
  }
}

class PageEntryPoint extends StatefulWidget {
  const PageEntryPoint({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PageEntryPoint> {
  final datasets = <String, dynamic>{};
  final Set<Marker> markers = new Set();
  static const LatLng showLocation = const LatLng(27.7089427, 85.3086209);

  @override
  Widget build(BuildContext context) {
    GoogleMapController mapController;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(27.7089427, 85.3086209),
                zoom: 15,
              ),
              markers: getmarkers(),
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {},
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, top: 10.0),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xFFFFFFFF),
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
                              WidgetSpan(
                                alignment: ui.PlaceholderAlignment.middle,
                                child: new Icon(Icons.arrow_back),
                              ),
                              TextSpan(
                                text: " Quay về",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, top: 10.0),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xFFFFFFFF),
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
                              WidgetSpan(
                                alignment: ui.PlaceholderAlignment.middle,
                                child: new Icon(Icons.directions_walk),
                              ),
                              TextSpan(
                                text: " 12 km",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: 100,
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xFFFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10, // changes position of shadow
                      ),
                    ],
                  ),
                  child:
                      Text("07 Đống Đa, P. Thắng Lợi, TP. Kon Tum, Kon Tum")),
              Container(
                padding:
                    const EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 5 / 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 70,
                      offset: Offset(0, -15), // changes position of shadow
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  // <-- wrap this around
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, //Center Row contents horizontally,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Kết thúc: 21/11/2021',
                            style: defautText(color: 0xFF6886C5),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () => launch("tel://0123456789"),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.brown.shade800,
                                  child: const Text('NK'),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: <Widget>[
                                      // ignore: prefer_const_constructors
                                      Text(
                                        "Nguyên Khoa",
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      // ignore: prefer_const_constructors
                                      Text(
                                        'SĐT: ${"0123456789"}',
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
                                  color: Color(0xFF6886C5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${"Sản phẩm 1"}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.0),
                                  )),
                              Text("12"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${"Sản phẩm 1"}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.0),
                                  )),
                              Text("12"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                ),
                child: Row(children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            // Respond to button press
                          },
                          child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                'Chỉnh sửa',
                                style: defautText(color: 0xFFFFFFFF),
                                textAlign: TextAlign.center,
                              )))),
                  SizedBox(width: 15),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            // Respond to button press
                          },
                          child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                'Hoàn tất',
                                style: defautText(color: 0xFFFFFFFF),
                                textAlign: TextAlign.center,
                              )))),
                ]),
              ),
            ],
          )
        ],
      ),
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(showLocation.toString()),
        position: showLocation, //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Marker Title First ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add second marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(27.7099116, 85.3132343), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Marker Title Second ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add third marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(27.7137735, 85.315626), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Marker Title Third ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }
}
