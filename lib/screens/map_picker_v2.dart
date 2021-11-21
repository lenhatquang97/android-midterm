// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:android_midterm/models/location.dart';
import 'package:android_midterm/provider/picker_provider.dart';
import 'package:android_midterm/screens/search_box.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    var _picker_provider = Provider.of<PickerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                MapPicker(),
                SearchBox(),
              ],
            ),
          ),
          Container(
              height: 90,
              width: double.infinity,
              color: Colors.transparent,
              child: FractionallySizedBox(
                widthFactor: 0.7,
                heightFactor: 0.5,
                child: MaterialButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    print(_picker_provider.current_location.name);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Select",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class MapPicker extends StatefulWidget {
  MapPicker({Key? key}) : super(key: key);

  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _target = LatLng(
    10.85636,
    106.6543,
  );
  // var _picker_provider = Provider.of<PickerProvider>(context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // ignore: non_constant_identifier_names
      var _picker_provider =
          Provider.of<PickerProvider>(context, listen: false);

      _picker_provider.location_controller.stream.listen((location) async {
        // ignore: non_constant_identifier_names
        GoogleMapController map_controller = await _controller.future;
        map_controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(location.lat, location.lng), zoom: 15),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    var _picker_provider = Provider.of<PickerProvider>(context);
    return Stack(
      children: [
        GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (CameraPosition newPosition) async {
              _picker_provider.setLocationByMovingMap(Location(
                  name: "",
                  formattedAddress: "",
                  lat: newPosition.target.latitude,
                  lng: newPosition.target.longitude));
            },
            initialCameraPosition: CameraPosition(target: _target, zoom: 15)),
        Center(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
            size: 36,
          ),
        )
      ],
    );
  }
}
