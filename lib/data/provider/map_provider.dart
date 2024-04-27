import 'package:energise_test/data/model/ip_model.dart';
import 'package:flutter/material.dart';

class MapProvider extends ChangeNotifier {
  IpCallModel _ipCallModel = IpCallModel();
  final List<dynamic> _items = [];

  IpCallModel get ipCallModel => _ipCallModel;
  List<dynamic> get listItems => _items;

  void fillModel(IpCallModel model) {
    _ipCallModel = model;
    modelToList();
    notifyListeners();
  }

  void modelToList() {
    _items.clear();
    var data = ipCallModel.toJson();
    data.forEach((key, value) => _items.add('$key : $value'));
  }
}
