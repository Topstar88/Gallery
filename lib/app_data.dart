import 'package:flutter/foundation.dart';

class AppData with ChangeNotifier {
  String _testing = 'This is from AppData';
  String get testing => _testing;

  String _testing2 = 'Testing 2';
  String get testing2 => _testing2;

  set testingString(String newString){
    _testing = newString;
    notifyListeners();
  }

  String _currentPage = 'home';
  String get currentPage => _currentPage;

  set currentPageString(String newString){
    _currentPage = newString;
    notifyListeners();
  }


}