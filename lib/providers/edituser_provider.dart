import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:flutter_application_2/services/edituser_service.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';

class EditUserProvider with ChangeNotifier {
  UserModel _userModel = UserModel();
  // UserModel? _userModel1;

  UserModel get userModel => _userModel;

  set userModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  Future<bool> uplaodFoto(ImageSource? photo) async {
    try {
      final pickedFile = await ImagePicker().getImage(source: photo!);
      if (pickedFile != null) {
        await EditUserService().uploadImage(pickedFile.path);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
