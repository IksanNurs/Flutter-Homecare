import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/district.dart';
import 'package:flutter_application_2/models/province.dart';
import 'package:flutter_application_2/models/subdistrict.dart';
import 'package:flutter_application_2/services/district_service.dart';
import 'package:flutter_application_2/services/province_service.dart';
import 'package:flutter_application_2/services/subdistrict_service.dart';

class SubdistrictProvider with ChangeNotifier {
  List<SubdistrictModel> _subdistrics = [];

  List<SubdistrictModel> get subdistrics => _subdistrics;

  set subdistrics(List<SubdistrictModel> subdistrics) {
    _subdistrics = subdistrics;
    notifyListeners();
  }

  Future<void> getSubDistrics(String? idsubdistrict) async {
    try {
      List<SubdistrictModel> subdistrics =
          await SubdistricService().getSubDistrics(id: idsubdistrict);
      _subdistrics = subdistrics;
    } catch (e) {
      // print(e);
    }
  }
}
