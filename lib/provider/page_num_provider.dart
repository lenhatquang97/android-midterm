import 'package:flutter/material.dart';

class PageNumProvider with ChangeNotifier {
  int _pageNum = 0;
  int get pageNum => _pageNum;
  set pageNum(int pageNum) {
    _pageNum = pageNum;
    notifyListeners();
  }
}
