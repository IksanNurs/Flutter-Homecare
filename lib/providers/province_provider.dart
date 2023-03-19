import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/province.dart';
import 'package:flutter_application_2/services/province_service.dart';

class ProvinceProvider with ChangeNotifier {
  List<ProvinceModel> _provinces = [];

  List<ProvinceModel> get provinces => _provinces;

  set provinces(List<ProvinceModel> provinces) {
    _provinces = provinces;
    notifyListeners();
  }

  Future<void> getProvinces() async {
    try {
      List<ProvinceModel> provinces = await ProvinceService().getProvinces();
      _provinces = provinces;
    } catch (e) {
      // print(e);
    }
  }
}
