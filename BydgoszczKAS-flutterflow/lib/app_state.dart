import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:ff_commons/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  int _isScanned = 0;
  int get isScanned => _isScanned;
  set isScanned(int value) {
    _isScanned = value;
  }

  String _podmiot = '';
  String get podmiot => _podmiot;
  set podmiot(String value) {
    _podmiot = value;
  }

  String _zaklady = '2';
  String get zaklady => _zaklady;
  set zaklady(String value) {
    _zaklady = value;
  }

  String _Link = '';
  String get Link => _Link;
  set Link(String value) {
    _Link = value;
  }

  String _Stawki = '';
  String get Stawki => _Stawki;
  set Stawki(String value) {
    _Stawki = value;
  }

  String _Regulamin = '';
  String get Regulamin => _Regulamin;
  set Regulamin(String value) {
    _Regulamin = value;
  }
}
