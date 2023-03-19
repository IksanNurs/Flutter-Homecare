import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/checkout_card.dart';
import '../theme.dart';
import '../widgets/loading_button.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });

      if (await transactionProvider.transaction(
        authProvider.userModel.token!,
        cartProvider.cart,
        cartProvider.totalPrice(),
      )) {
        cartProvider.carts = [];
        Navigator.pushNamedAndRemoveUntil(
            context, '/checkout-success', (route) => false);
      }

      setState(() {
        isLoading = false;
      });
    }

    PreferredSizeWidget _header() {
      return AppBar(
        backgroundColor: bgColor1,
        title: Text('Checkout Details',
            style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium)),
        centerTitle: true,
        elevation: 0,
      );
    }

    Widget _detailPayment(String title, String value) {
      return Container(
        margin: EdgeInsets.only(top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: secondaryTextStyle.copyWith(fontSize: 12),
            ),
            Text(
              value,
              style: primaryTextStyle.copyWith(fontWeight: medium),
            ),
          ],
        ),
      );
    }

    Widget _content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          //TITLE & CHECKOUT CARD PART
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Items',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 16,
                  ),
                ),
                Column(
                  children: cartProvider.cart
                      .map((cart) => CheckoutCard(cart))
                      .toList(),
                ),
              ],
            ),
          ),

          //ADDRESS CARD
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: bgColor6,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/icon_store_location.png',
                            width: 40),
                        Image.asset('assets/icon_line.png', height: 30),
                        Image.asset('assets/icon_your_address.png', width: 40),
                      ],
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Store Location',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          'Adidas Core',
                          style: primaryTextStyle.copyWith(fontWeight: medium),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Your Address',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          'Marsemoon',
                          style: primaryTextStyle.copyWith(fontWeight: medium),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //PAYMENT SUMMARY PART
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: bgColor6,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Summary',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(height: 12),
                _detailPayment(
                    'Product Quantity',
                    cartProvider.totalItems() > 1
                        ? '${cartProvider.totalItems()} Items'
                        : '${cartProvider.totalItems()} Item'),
                _detailPayment(
                    'Product Price', '\$${cartProvider.totalPrice()}'),
                _detailPayment('Shipping', 'Free'),
                SizedBox(height: 11),
                Divider(
                  color: subtitleTextColor,
                  thickness: 0.3,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: priceTextStyle.copyWith(fontWeight: medium),
                    ),
                    Text(
                      '\$${cartProvider.totalPrice()}',
                      style: priceTextStyle.copyWith(fontWeight: medium),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //BUTTONS PART
          SizedBox(height: defaultMargin),
          Divider(
            color: subtitleTextColor,
            thickness: 0.3,
          ),
          isLoading
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: defaultMargin),
                  height: 50,
                  child: LoadingButton())
              : Container(
                  margin: EdgeInsets.symmetric(vertical: defaultMargin),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleCheckout,
                    child: Text(
                      'Checkout Now',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                )
        ],
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: _header(),
      body: SafeArea(
        child: _content(),
      ),
    );
  }
}
