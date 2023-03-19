import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/district.dart';
import 'package:flutter_application_2/models/province.dart';
import 'package:flutter_application_2/models/subdistrict.dart';
import 'package:flutter_application_2/models/village.dart';
import 'package:flutter_application_2/services/district_service.dart';
import 'package:flutter_application_2/services/province_service.dart';
import 'package:flutter_application_2/services/subdistrict_service.dart';
import 'package:flutter_application_2/services/village_service.dart';

class VillagesProvider with ChangeNotifier {
  List<VillagesModel> _villages = [];

  List<VillagesModel> get villages => _villages;

  set villages(List<VillagesModel> villages) {
    _villages = villages;
    notifyListeners();
  }

  Future<void> getVillages(String? idvillages) async {
    try {
      List<VillagesModel> villages =
          await VillageService().getVillages(id: idvillages);
      _villages = villages;
    } catch (e) {
      // print(e);
    }
  }
}
