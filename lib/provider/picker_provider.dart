import 'dart:async';

import 'package:android_midterm/models/location.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class PickerProvider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  StreamController<Location> location_controller =
      StreamController<Location>.broadcast();
  // ignore: non_constant_identifier_names
  Location current_location =
      Location(name: "", formattedAddress: "", lat: 10.85636, lng: 106.6543);
  // ignore: constant_identifier_names
  static const map_key = 'AIzaSyA7eJkKK0Zp_mziFO_Gb-9OsdK99jYXx-A';
  // ignore: avoid_init_to_null
  static PickerProvider _instance = PickerProvider._();

  PickerProvider._();

  // ignore: non_constant_identifier_names
  static PickerProvider get instance => _instance;

  Future<List<Location>> search(String query) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$map_key";
    Response response = await Dio().get(url);
    return Location.parseLocationList(response.data);
  }

  void locationSelected(Location location) {
    location_controller.sink.add(location);
  }

  void init() {
    current_location =
        Location(name: "", formattedAddress: "", lat: 10.85636, lng: 106.6543);
    // notifyListeners();
  }

  void load_location(Location location) {
    current_location = location;
    notifyListeners();
  }

  void setLocationByMovingMap(Location location) {
    current_location = location;
    notifyListeners();
  }

  @override
  // ignore: must_call_super
  void dispose() {
    location_controller.close();
  }
}
