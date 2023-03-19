import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../providers/cart_provider.dart';
import '../theme.dart';

class CartCard extends StatelessWidget {
  final CartModel cartModel;
  CartCard(this.cartModel);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Container(
      margin: EdgeInsets.only(top: defaultMargin),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor6,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  cartModel.product!.icon.toString(),
                  width: 60,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartModel.product!.name.toString(),
                      style: primaryTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    Text('\$${cartModel.product!.price}',
                        style: priceTextStyle),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      cartProvider.addQty(cartModel.id!);
                    },
                    child: Image.asset(
                      'assets/button_add.png',
                      width: 16,
                    ),
                  ),
                  Text(cartModel.quantity.toString(),
                      style: primaryTextStyle.copyWith(fontWeight: medium)),
                  GestureDetector(
                    onTap: () {
                      cartProvider.reduceQty(cartModel.id!);
                    },
                    child: Image.asset(
                      'assets/button_min.png',
                      width: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              cartProvider.removeCart(cartModel.id!);
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icon_remove.png',
                  width: 10,
                  height: 12,
                ),
                SizedBox(width: 4),
                Text('Remove',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: light,
                      color: alertColor,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
