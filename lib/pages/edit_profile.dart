import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/district.dart';
import 'package:flutter_application_2/models/province.dart';
import 'package:flutter_application_2/models/subdistrict.dart';
import 'package:flutter_application_2/models/village.dart';
import 'package:flutter_application_2/providers/district_provider.dart';
import 'package:flutter_application_2/providers/edituser_provider.dart';
import 'package:flutter_application_2/providers/province_provider.dart';
import 'package:flutter_application_2/providers/subdistrict_provider.dart';
import 'package:flutter_application_2/providers/village_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../theme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  int? isbro = 0;
  int? isbro1 = 0;
  int? isbro2 = 0;
  Color color1 = Colors.white;
  UserModel? userModel;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProvinceProvider provinceProvider = Provider.of<ProvinceProvider>(context);
    List<ProvinceModel> provinceModel = provinceProvider.provinces;
    DistrictProvider districtProvider = Provider.of<DistrictProvider>(context);
    List<DistricModel> districtModel = districtProvider.districs;
    SubdistrictProvider subdistrictProvider =
        Provider.of<SubdistrictProvider>(context);
    List<SubdistrictModel> subdistrictModel = subdistrictProvider.subdistrics;
    VillagesProvider villageProvider = Provider.of<VillagesProvider>(context);
    List<VillagesModel> villagesModel = villageProvider.villages;
    TextEditingController _nicknameController = TextEditingController();
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _jekelController = TextEditingController();
    TextEditingController _tglLahirController = TextEditingController();
    TextEditingController _provinsiController = TextEditingController();
    TextEditingController _kabupatnController = TextEditingController();
    TextEditingController _kecamatanController = TextEditingController();
    TextEditingController _kelurahanController = TextEditingController();
    TextEditingController _addressController = TextEditingController();
    userModel = Provider.of<AuthProvider>(context, listen: false).userModel;
    EditUserProvider editUserProvider = Provider.of<EditUserProvider>(context);
    List<String> _listJenisKelamin = ['Laki-laki', 'Perempuan'];

    PreferredSizeWidget _header() {
      return AppBar(
        backgroundColor: bgColor1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Profile',
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.check,
                color: primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
        ],
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
      );
    }

    Widget _nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nick Name',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
                fontWeight: regular,
              ),
            ),
            TextFormField(
              controller: _nicknameController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: userModel?.nickname,
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: subtitleTextColor),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _usernameInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
                fontWeight: regular,
              ),
            ),
            TextFormField(
              controller: _usernameController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: '@${userModel?.username}',
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: subtitleTextColor),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
                fontWeight: regular,
              ),
            ),
            TextFormField(
              controller: _emailController,
              style: primaryTextStyle,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: userModel?.email,
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: subtitleTextColor),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _jekelDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis Kelamin',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
                fontWeight: regular,
              ),
            ),
            DropdownButton(
              dropdownColor: Colors.grey,
              isExpanded: true,
              value: userModel?.sex,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              items: _listJenisKelamin.map((String value) {
                return DropdownMenuItem(
                  value: value.toString() == "Laki-laki" ? 1 : 2,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  userModel?.sex = int.parse(value.toString());
                });
              },
            )
          ],
        ),
      );
    }

    Widget _tanggallahirInput() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanggal Lahir',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
                fontWeight: regular,
              ),
            ),
            TextFormField(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1800),
                        lastDate: DateTime(2023))
                    .then((date) {
                  setState(() {
                    userModel?.birthdate =
                        DateFormat('yyyy-MM-dd').format(date!);
                    _tglLahirController.text = date.toString();
                  });
                });
              },
              showCursor: false,
              readOnly: true,
              controller: _tglLahirController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: userModel?.birthdate,
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: subtitleTextColor),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _provinsiDropDown() {
      return GestureDetector(
        onTap: () async {
          await Provider.of<ProvinceProvider>(context, listen: false)
              .getProvinces();
          setState(() {});
          if (userModel?.province?.id == null) {
            Fluttertoast.showToast(
                msg: "Silahkan isi provinsi",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Provinsi',
                style: secondaryTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: regular,
                ),
              ),
              DropdownButton(
                  dropdownColor: Colors.grey,
                  isExpanded: true,
                  style: TextStyle(color: color1, fontSize: 18),
                  value: userModel?.province?.id,
                  hint: Text(
                    userModel?.province?.name == null
                        ? ''
                        : userModel!.province!.name.toString(),
                    style: TextStyle(fontSize: 18, color: color1),
                  ),
                  items: provinceModel.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.name!),
                      value: e.id,
                    );
                  }).toList(),
                  onChanged: (val) async {
                    setState(() {
                      color1 = Colors.blue;
                      userModel?.province?.id = null;
                    });
                    await Provider.of<DistrictProvider>(context, listen: false)
                        .getDistrics(val.toString());
                    setState(() {
                      userModel?.province?.id = val.toString();
                      isbro = 1;
                    });
                  })
            ],
          ),
        ),
      );
    }

    Widget _kabDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kabupaten/Kota',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
                fontWeight: regular,
              ),
            ),
            GestureDetector(
              onTap: () {
                (isbro == 0 || userModel?.district?.id == null)
                    ? Fluttertoast.showToast(
                        msg: "Isi dulu Provinsi!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0)
                    : '';
              },
              child: DropdownButton(
                  dropdownColor: Colors.grey,
                  isExpanded: true,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                  value: userModel?.district?.id,
                  hint: Text(
                    userModel?.province?.name == null
                        ? ''
                        : userModel!.district!.name.toString(),
                    style: const TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  items: districtModel.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.name!),
                      value: e.id,
                    );
                  }).toList(),
                  onChanged: (isbro == 1 || userModel?.district?.id != null)
                      ? (val) async {
                          setState(() {
                            userModel?.district?.id = null;
                          });

                          await Provider.of<SubdistrictProvider>(context,
                                  listen: false)
                              .getSubDistrics(val.toString());
                          setState(() {
                            userModel?.district!.id = val.toString();
                            isbro1 = 1;
                          });
                        }
                      : null),
            )
          ],
        ),
      );
    }

    Widget _kecDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kecamatan',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
                fontWeight: regular,
              ),
            ),
            GestureDetector(
              onTap: () {
                (isbro1 == 0 || userModel?.subdistrict?.id == null)
                    ? Fluttertoast.showToast(
                        msg: "Isi dulu Kabupaten/Kota!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0)
                    : '';
              },
              child: DropdownButton(
                  dropdownColor: Colors.grey,
                  isExpanded: true,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                  value: userModel?.subdistrict?.id,
                  hint: Text(
                    userModel?.subdistrict?.name == null
                        ? ''
                        : userModel!.subdistrict!.name.toString(),
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  items: subdistrictModel.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.name!),
                      value: e.id,
                    );
                  }).toList(),
                  onChanged: (isbro1 == 1 || userModel?.subdistrict?.id != null)
                      ? (val) async {
                          setState(() {
                            userModel?.village!.id = null;
                          });

                          await Provider.of<VillagesProvider>(context,
                                  listen: false)
                              .getVillages(val.toString());
                          setState(() {
                            userModel?.subdistrict!.id = val.toString();
                            isbro2 = 1;
                          });
                        }
                      : null),
            )
          ],
        ),
      );
    }

    Widget _kelDropDown() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kelurahan',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
                fontWeight: regular,
              ),
            ),
            GestureDetector(
              onTap: () {
                (isbro2 == 0 || userModel?.village?.id == null)
                    ? Fluttertoast.showToast(
                        msg: "Isi dulu Kecamatan!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0)
                    : '';
              },
              child: DropdownButton(
                  dropdownColor: Colors.grey,
                  isExpanded: true,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  value: userModel?.village?.id,
                  hint: Text(
                    userModel?.village?.name == null
                        ? ''
                        : userModel!.village!.name.toString(),
                    style: const TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  items: villagesModel.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.name!),
                      value: e.id,
                    );
                  }).toList(),
                  onChanged: (isbro2 == 1 || userModel?.village?.id != null)
                      ? (val) {
                          setState(() {
                            userModel?.village!.id = val.toString();
                          });
                        }
                      : null),
            )
          ],
        ),
      );
    }

    Widget _alamatInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
                fontWeight: regular,
              ),
            ),
            TextFormField(
              controller: _addressController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: userModel?.address,
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: subtitleTextColor),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _content() {
      return SafeArea(
        bottom: false,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (isLoading)
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: Colors.white.withOpacity(0.5),
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: defaultMargin),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  userModel!.urlPhoto.toString(),
                                  headers: {
                                    'Authorization': userModel!.token.toString()
                                  }),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Plih Foto'),
                                      actions: <Widget>[
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(16.0),
                                                      topRight: Radius.circular(
                                                          16.0)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    editUserProvider.uplaodFoto(
                                                        ImageSource.camera);
                                                    setState(() {
                                                      isLoading = true;
                                                    });

                                                    Timer(Duration(seconds: 2),
                                                        () {});

                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.camera,
                                                    size: 40,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    editUserProvider.uplaodFoto(
                                                        ImageSource.gallery);
                                                  },
                                                  child: Icon(
                                                    Icons.image,
                                                    size: 40,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    );
                                  });
                            },
                            child: const Align(
                              alignment: Alignment(0, 1.3),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                  _nameInput(),
                  _usernameInput(),
                  _emailInput(),
                  _jekelDropDown(),
                  _tanggallahirInput(),
                  _provinsiDropDown(),
                  _kabDropDown(),
                  _kecDropDown(),
                  _kelDropDown(),
                  _alamatInput(),
                ],
              ),
            )),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor3,
      appBar: _header(),
      body: SafeArea(child: _content()),
    );
  }
}
