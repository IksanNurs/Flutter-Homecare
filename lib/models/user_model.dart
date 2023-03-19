import 'package:flutter_application_2/models/district.dart';
import 'package:flutter_application_2/models/province.dart';
import 'package:flutter_application_2/models/subdistrict.dart';
import 'package:flutter_application_2/models/village.dart';

class UserModel {
  int? id;
  String? phone;
  String? email;
  String? username;
  String? nickname;
  String? urlPhoto;
  String? token;
  String? birthplace;
  String? birthdate;
  int? sex;
  ProvinceModel? province;
  DistricModel? district;
  SubdistrictModel? subdistrict;
  VillagesModel? village;
  String? address;

  UserModel(
      {this.id,
      this.phone,
      this.email,
      this.username,
      this.nickname,
      this.urlPhoto,
      this.token,
      this.birthplace,
      this.birthdate,
      this.sex,
      this.province,
      this.district,
      this.subdistrict,
      this.village,
      this.address});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    username = json['username'];
    nickname = json['nickname'];
    urlPhoto = json['photoUrl'];
    token = json['token'];
    birthplace = json['birthplace'];
    birthdate = json['birthdate'];
    sex = json['sex'];
    province = json['province'] == null
        ? UninitializedProvinceModel()
        : ProvinceModel.fromJson(json['province']);
    // category = CategoryModel.fromJson(json['category']);
    district = json['district'] == null
        ? UninitializedDistrictModel()
        : DistricModel.fromJson(json['district']);
    subdistrict = json['subdistrict'] == null
        ? UninitializedSubdistricModel()
        : SubdistrictModel.fromJson(json['subdistrict']);
    village = json['village'] == null
        ? UninitializedVillagesModel()
        : VillagesModel.fromJson(json['village']);
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['phone'] = phone;
    data['email'] = email;
    data['username'] = username;
    data['nickname'] = nickname;
    data['photoUrl'] = urlPhoto;
    data['token'] = token;
    data['birthplace'] = birthplace;
    data['birthdate'] = birthdate;
    data['sex'] = sex;
    data['province'] =
        province is UninitializedProvinceModel ? {} : province?.toJson();
    data['district'] =
        district is UninitializedDistrictModel ? {} : district?.toJson();
    data['subdistrict'] = subdistrict is UninitializedSubdistricModel
        ? {}
        : subdistrict!.toJson();
    data['village'] =
        village is UninitializedVillagesModel ? {} : village?.toJson();
    data['address'] = address;

    if (id == null) {
      map['id'] = id;
    }
    return map;
  }
}
