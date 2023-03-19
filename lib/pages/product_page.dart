import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/cart_model.dart';
import 'package:flutter_application_2/models/district.dart';
import 'package:flutter_application_2/models/province.dart';
import 'package:flutter_application_2/models/subdistrict.dart';
import 'package:flutter_application_2/models/village.dart';
import 'package:flutter_application_2/providers/product_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';
import '../pages/detail_chat.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/district_provider.dart';
import '../providers/edituser_provider.dart';
import '../providers/province_provider.dart';
import '../providers/subdistrict_provider.dart';
import '../providers/village_provider.dart';
import '../providers/wishlist_provider.dart';
import '../theme.dart';

const Color firstColor = Color.fromARGB(255, 16, 105, 123);
const Color secondColor = Color(0xff4CAF50);

class ProductPage extends StatefulWidget {
  final ProductModel product;
  ProductPage(this.product);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List images = [
    'assets/animated1.gif',
  ];

  List otherShoes = [
    'assets/image_shoes2.png',
    'assets/image_shoes3.png',
    'assets/image_shoes4.png',
    'assets/image_shoes5.png',
    'assets/image_shoes6.png',
    'assets/image_shoes7.png',
    'assets/image_shoes8.png',
  ];

  // bool isFavorite = false;

  int _currIndex = 0;
  int _currStep = 0;
  static const jekel = <String>['Semuanya', 'Laki-laki', 'Perempuan'];
  String selectedValue = jekel.first;
  static const rate = <String>['>=4', 'semuanya'];
  String selectedRate = rate.first;
  int? isbro = 0;
  int? isbro1 = 0;
  int? isbro2 = 0;
  Color color1 = Colors.white;
  UserModel? userModel;
  List<ProvinceModel>? provinceModel;
  List<DistricModel>? districModel;
  List<SubdistrictModel>? subdistrictModel;
  List<VillagesModel>? villagesModel;
  EditUserProvider? editUserProvider;

  bool isLoading = false;

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
  TextEditingController _catatanController = TextEditingController();

  List<String> _listJenisKelamin = ['Laki-laki', 'Perempuan'];

  @override
  void dispose() {
    // TODO: implement dispose
    _nicknameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _jekelController.dispose();
    _tglLahirController.dispose();
    _provinsiController.dispose();
    _kabupatnController.dispose();
    _kecamatanController.dispose();
    _kelurahanController.dispose();
    _addressController.dispose();
    _catatanController.dispose();
    userModel = null;
    provinceModel = null;
    districModel = null;
    subdistrictModel = null;
    villagesModel = null;
    editUserProvider = null;
    _listJenisKelamin.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    userModel = Provider.of<AuthProvider>(context, listen: false).userModel;
    provinceModel = Provider.of<ProvinceProvider>(context).provinces;
    districModel = Provider.of<DistrictProvider>(context).districs;
    subdistrictModel = Provider.of<SubdistrictProvider>(context).subdistrics;
    villagesModel = Provider.of<VillagesProvider>(context).villages;
    editUserProvider = Provider.of<EditUserProvider>(context);

    final void Function() onIncTap = () {
      if (productProvider.quantity == 10)
        productProvider.quantity = 10;
      else
        productProvider.quantity++;

      Timer(Duration(milliseconds: 200), () {
        if (productProvider.value == 1)
          productProvider.value = 1;
        else
          productProvider.value--;
      });
      print(productProvider.quantity);
      setState(() {});
    };
    final void Function() onDecTap = () {
      if (productProvider.quantity == 1)
        productProvider.quantity = 1;
      else
        productProvider.quantity--;

      Timer(Duration(milliseconds: 200), () {
        if (productProvider.value == 10)
          productProvider.value = 10;
        else
          productProvider.value++;
      });
      print(productProvider.quantity);
      setState(() {});
    };

    List<Step> getSteps() => [
          Step(
            state: _currStep > 0 ? StepState.complete : StepState.editing,
            title: Text('Layanan'),
            content: Column(children: [
              Container(
                margin: EdgeInsets.only(),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name.toString(),
                            style: primaryTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            widget.product.name.toString(),
                            style: secondaryTextStyle.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        wishlistProvider.setProduct(widget.product);
                        if (wishlistProvider.isFavorite(widget.product)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: secondaryColor,
                              content: Text(
                                'Has been added to the wishlist',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: alertColor,
                              content: Text(
                                'Has been removed from the wishlist',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                      child: Image.asset(
                        wishlistProvider.isFavorite(widget.product)
                            ? 'assets/button_wishlist_blue.png'
                            : 'assets/button_wishlist.png',
                        width: 46,
                      ),
                    )
                  ],
                ),
              ),
              TextFormField(
                readOnly: true,
                initialValue: "Harga",
                style: primaryTextStyle,
                decoration: InputDecoration(
                  suffixText: NumberFormat.currency(
                          locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(widget.product.price),
                  hintStyle: primaryTextStyle,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: subtitleTextColor),
                  ),
                ),
              ),
              TextFormField(
                readOnly: true,
                initialValue: "Jumlah(${widget.product.baseunit})",
                // initialValue: (widget.product.baseunit == "tindakan")
                //     ? "Jumlah(tindakan)"
                //     : (widget.product.baseunit == "jam")
                //         ? "Jumlah(jam)"
                //         : "Jumlah(hari)",
                style: primaryTextStyle,
                decoration: InputDecoration(
                  suffix: (widget.product.baseunit != "tindakan")
                      ? Container(
                          width: 140,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: firstColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: onDecTap,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  color: firstColor,
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(productProvider.quantity.toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              GestureDetector(
                                onTap: onIncTap,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  color: firstColor,
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text("1\t\t"),
                  hintStyle: primaryTextStyle,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: subtitleTextColor),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price starts from',
                      style: primaryTextStyle,
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                          .format((productProvider.quantity == 0
                              ? widget.product.price
                              : widget.product.price! *
                                  productProvider.quantity)),
                      style: priceTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
              ),
            ]),
            isActive: _currStep >= 0,
          ),
          Step(
            state: _currStep > 1 ? StepState.complete : StepState.editing,
            title: Text('Pelanggan'),
            content: Column(
              children: [
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
                _catatanInput()
              ],
            ),
            isActive: _currStep >= 1,
          ),
          Step(
            state: _currStep > 2 ? StepState.complete : StepState.editing,
            title: Text('Kriteria \nPerawat'),
            content: Column(children: [
              Text(
                "Jenis Kelamin",
                style: primaryTextStyle,
              ),
              Wrap(
                spacing: -20,
                runSpacing: -20,
                children: jekel.map((value) {
                  final selected = this.selectedValue == value;
                  return Row(children: [
                    Radio(
                        value: value,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() => this.selectedValue = value.toString());
                        }),
                    Text(
                      value.toString(),
                      style: TextStyle(
                          color: (selected) ? Colors.blue : Colors.black,
                          fontWeight: (selected) ? bold : regular),
                    ),
                  ]);
                }).toList(),
              ),
              Text(
                "Rate",
                style: primaryTextStyle,
              ),
              Wrap(
                spacing: -20,
                runSpacing: -20,
                children: rate.map((value) {
                  final selected = this.selectedRate == value;
                  return Row(children: [
                    Radio(
                        value: value,
                        groupValue: selectedRate,
                        onChanged: (value) {
                          setState(() => this.selectedRate = value.toString());
                          print(selectedRate);
                        }),
                    Text(
                      value.toString(),
                      style: TextStyle(
                          color: (selected) ? Colors.blue : Colors.black,
                          fontWeight: (selected) ? bold : regular),
                    ),
                  ]);
                }).toList(),
              ),
              Text(
                "Pengalaman",
                style: primaryTextStyle,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      toolbarOptions: const ToolbarOptions(
                          copy: true, paste: true, selectAll: true),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue)),
                          labelText: "Maximum",
                          labelStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      toolbarOptions: const ToolbarOptions(
                          copy: true, paste: true, selectAll: true),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue)),
                          labelText: "Minimum",
                          labelStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ],
              )
            ]),
            isActive: _currStep >= 2,
          ),
        ];

    Future<void> showSuccessDialog() async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width - (2 * defaultMargin),
              child: AlertDialog(
                backgroundColor: bgColor3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        child: GestureDetector(
                          child: Icon(
                            Icons.close,
                            color: primaryTextColor,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Image.asset('assets/icon_success.png', width: 100),
                      SizedBox(height: 12),
                      Text(
                        'Hurray :)',
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Item added successfully',
                        style: secondaryTextStyle,
                      ),
                      SizedBox(height: 12),
                      Container(
                        width: 154,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed('/cart');
                          },
                          child: Text(
                            'View My Cart',
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    Widget _indicator(int index) {
      return Container(
        width: _currIndex == index ? 16 : 4,
        height: 4,
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _currIndex == index ? primaryColor : Color(0xffC4C4C4),
        ),
      );
    }

    Widget _thumbnailOtherShoes(String img) {
      return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(right: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(img, width: 54),
          ),
        ),
      );
    }

    Widget _header() {
      int _index = -1;
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.chevron_left,
                  ),
                ),
                Icon(
                  Icons.shopping_bag,
                  color: bgColor1,
                )
              ],
            ),
          ),
          CarouselSlider(
            items: images
                .map((img) => Image.asset(
                      img,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
                initialPage: 0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currIndex = index;
                  });
                }),
          ),
          SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.map((images) {
                _index++;
                return _indicator(_index);
              }).toList()),
        ],
      );
    }

    Widget _content() {
      return Container(
        margin: EdgeInsets.only(top: 17),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: bgColor1,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
            ),
            Container(
              margin: EdgeInsets.all(defaultMargin),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/detail-chat');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailChatPage(widget.product),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/button_chat.png',
                      width: 54,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          cartProvider.addToCart(widget.product);
                          showSuccessDialog();
                        },
                        child: Text(
                          'Selanjutnya',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor7,
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  _header(),
                  _content(),
                ],
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.lightGreen,
                  child: Stepper(
                    steps: getSteps(),
                    type: StepperType.horizontal,
                    currentStep: _currStep,
                    onStepContinue: () {
                      final isLastStep = _currStep == getSteps().length - 1;
                      if (isLastStep) {
                        print("complete");
                      } else {
                        setState(() {
                          _currStep++;
                        });
                      }
                    },
                    onStepTapped: (step) {
                      setState(() {
                        _currStep = step;
                      });
                    },
                    controlsBuilder:
                        (BuildContext context, ControlsDetails controls) {
                      final isLastStep = _currStep == getSteps().length - 1;
                      return Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_currStep != 0)
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    side: BorderSide(color: Colors.lightBlue),
                                  ),
                                  onPressed: controls.onStepCancel,
                                  child: Text('Cancel',
                                      style:
                                          TextStyle(color: Colors.lightBlue)),
                                ),
                              ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: controls.onStepContinue,
                                child: Text(isLastStep ? 'Kirim' : 'Next'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onStepCancel: _currStep == 0
                        ? null
                        : () {
                            setState(() {
                              _currStep--;
                            });
                          },
                  ),
                ),
              ),
            ],
          )
        ],
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
                  userModel?.birthdate = DateFormat('yyyy-MM-dd').format(date!);
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
                items: provinceModel?.map((e) {
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
                items: districModel?.map((e) {
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
                items: subdistrictModel?.map((e) {
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
                items: villagesModel?.map((e) {
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

  Widget _catatanInput() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Catatan',
            style: secondaryTextStyle.copyWith(
              fontSize: 13,
              fontWeight: regular,
            ),
          ),
          TextFormField(
            controller: _catatanController,
            style: primaryTextStyle,
            decoration: InputDecoration(
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
}
