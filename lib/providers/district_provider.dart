import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/district.dart';
import 'package:flutter_application_2/services/district_service.dart';

class DistrictProvider with ChangeNotifier {
  List<DistricModel> _districs = [];

  List<DistricModel> get districs => _districs;

  set districs(List<DistricModel> districs) {
    _districs = districs;
    notifyListeners();
  }

  Future<void> getDistrics(String? iddistrict) async {
    try {
      List<DistricModel> districs =
          await DistricsService().getDistrics(id: iddistrict);
      _districs = districs;
    } catch (e) {
      // print(e);
    }
  }
}
