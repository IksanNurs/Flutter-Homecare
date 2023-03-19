import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/district_provider.dart';
import 'package:flutter_application_2/providers/province_provider.dart';
import 'package:flutter_application_2/providers/subdistrict_provider.dart';
import 'package:flutter_application_2/providers/village_provider.dart';
import 'package:provider/provider.dart';
import '../../models/district.dart';
import '../../models/subdistrict.dart';
import '../../models/user_model.dart';
import '../../models/village.dart';
import '../../providers/auth_provider.dart';
import '../../services/session_manager.dart';
import '../../theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    userModel = Provider.of<AuthProvider>(context, listen: false).userModel;
    DistrictProvider districtProvider = Provider.of<DistrictProvider>(context);
    List<DistricModel> districtModel = districtProvider.districs;
    SubdistrictProvider subdistrictProvider =
        Provider.of<SubdistrictProvider>(context);
    List<SubdistrictModel> subdistrictModel = subdistrictProvider.subdistrics;
    VillagesProvider villageProvider = Provider.of<VillagesProvider>(context);
    List<VillagesModel> villagesModel = villageProvider.villages;

    Widget _header() {
      return AppBar(
        backgroundColor: bgColor1,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(defaultMargin),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            userModel!.urlPhoto.toString(),
                            headers: {
                              'Authorization': userModel!.token.toString()
                            },
                          ),
                          fit: BoxFit.cover)),

                  // NetworkImage(
                  //   userModel.urlPhoto.toString(),
                  //   width: 64,
                  // ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${userModel!.username}',
                        style: primaryTextStyle.copyWith(
                            fontSize: 24, fontWeight: bold),
                      ),
                      Text(
                        '@${userModel!.username}',
                        style: subtitleTextStyle.copyWith(
                            fontSize: 16, fontWeight: regular),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () async {
                      await session.clearSession();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/signin', (Route<dynamic> route) => false);
                    },
                    child: Image.asset('assets/button_exit.png', width: 20)),
              ],
            ),
          ),
        ),
      );
    }

    Widget _menuItem(String text) {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
                fontWeight: regular,
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 16,
              color: primaryTextColor,
            ),
          ],
        ),
      );
    }

    Widget _content() {
      return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          width: double.infinity,
          decoration: BoxDecoration(color: bgColor3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Account',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    districtModel.clear();
                    subdistrictModel.clear();
                    villagesModel.clear();
                    userModel = null;
                  });

                  await Provider.of<AuthProvider>(context, listen: false)
                      .loginToken();

                  Navigator.of(context)
                      .pushNamed('/edit-profile')
                      .then((value) {
                    setState(() {
                      districtModel.clear();
                      subdistrictModel.clear();
                      villagesModel.clear();
                      userModel = null;
                    });
                  });
                },
                child: _menuItem('Edit Profile'),
              ),
              _menuItem('Your Orders'),
              _menuItem('Help'),
              SizedBox(height: 30),
              Text(
                'General',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              _menuItem('Privacy & Policy'),
              _menuItem('Term of Service'),
              _menuItem('Rate App'),
            ],
          ),
        ),
      );
    }

    return Center(
        child: Column(
      children: [
        _header(),
        _content(),
      ],
    ));
  }
}
