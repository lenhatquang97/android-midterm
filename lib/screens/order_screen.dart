// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:android_midterm/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui show PlaceholderAlignment;
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:android_midterm/models/order_model.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:intl/intl.dart';
import 'package:auto_route/auto_route.dart';
import 'add_order.dart' as ao;

DateFormat dateFormat = DateFormat("HH:mm dd-MM-yyyy");
final firestoreInstance = FirebaseFirestore.instance;

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

Future<LatLng?> Permission() async {
  Location location = Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return LatLng(0, 0);
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return LatLng(0, 0);
    }
  }
  _locationData = await location.getLocation();
  return LatLng(_locationData.latitude!, _locationData.longitude!);
}

class OrderScreen extends StatefulWidget {
  final String orderId;
  const OrderScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  _State createState() => _State(orderId);
}

class _State extends State<OrderScreen> {
  final String orderId;
  _State(this.orderId);

  final String uid = FirebaseAuth.instance.currentUser!.uid as String;
  final Set<Marker> markers = new Set();
  OrderModel order = OrderModel();
  GoogleMapController? mapController;
  CameraPosition cp = CameraPosition(
    target: LatLng(0.0, 0.0),
  );

  bool isLoading = true;
  double totalDistance = 0.0;
  LatLng Dest = LatLng(0, 0);
  LatLng Curr = LatLng(0, 0);

// Object for PolylinePoints
  late PolylinePoints polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  Widget productList(List<Product> arr) {
    List<Widget> list = [];
    for (var i = 0; i < arr.length; i++) {
      list.add(SizedBox(height: 10));
      list.add(
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
                      arr[i].name,
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    )),
                Text('${arr[i].qua}')
              ],
            ),
          ),
        ),
      );
    }
    return Column(children: list);
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<double> _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyA7eJkKK0Zp_mziFO_Gb-9OsdK99jYXx-A", // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print('null');
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    return totalDistance;
  }

  @override
  initState() {
    super.initState();
    order.fetchOrder(orderId, uid).then((result) {
      Dest = LatLng(order.location.latitude, order.location.longitude);
      cp = CameraPosition(
        target:
            LatLng(order.location.latitude - 0.001, order.location.longitude),
        zoom: 15,
      );
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(Dest.toString()),
        position: Dest, //position of marker
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      Permission().then((result) {
        Curr = LatLng(result!.latitude, result.longitude);
        // markers.add(Marker(
        //   //add first marker
        //   markerId: MarkerId(Curr.toString()),
        //   position: Curr, //position of marker
        //   icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        // ));
        _createPolylines(
                Curr.latitude, Curr.longitude, Dest.latitude, Dest.longitude)
            .then((res) => {
                  setState(() {
                    isLoading = false;
                  })
                });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            if (isLoading == false)
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  initialCameraPosition: cp,
                  myLocationEnabled: true,
                  polylines: Set<Polyline>.of(polylines.values),
                  markers: markers,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
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
                                  text:
                                      '${totalDistance.toStringAsFixed(2)} km',
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
                    child: Text('${order.address}')),
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
                              'Thời gian giao: ${dateFormat.format(order.dueDate)}',
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
                                          '${order.name}',
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        // ignore: prefer_const_constructors
                                        Text(
                                          'SĐT: ${order.phone}',
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
                        productList(order.products)
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
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            onPressed: !order.enable
                                ? null
                                : () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ao.AddOrder(
                                                  docs_id: orderId,
                                                )));
                                    // order.update(orderId, uid,
                                    //     {"enable": false}).then((result) {
                                    //   setState(() {});
                                    // });
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
                            onPressed: !order.enable
                                ? null
                                : () {
                                    order.update(orderId, uid,
                                        {"enable": false}).then((result) {
                                      setState(() {});
                                    });
                                  },
                            child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  order.enable ? 'Hoàn tất' : 'Đã hoàn tất',
                                  style: defautText(color: 0xFFFFFFFF),
                                  textAlign: TextAlign.center,
                                )))),
                  ]),
                ),
              ],
            ),
            if (isLoading == true)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                ),
                child: Center(child: Text("Loading...")),
              )
          ],
        ),
      ),
    );
  }
}
