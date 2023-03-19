import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../theme.dart';

class CheckoutCard extends StatelessWidget {
  final CartModel cartModel;
  CheckoutCard(this.cartModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: bgColor6,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
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
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$${cartModel.product!.price}',
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          Text(
              cartModel.quantity > 1
                  ? '${cartModel.quantity} Items'
                  : '${cartModel.quantity} Item',
              style: secondaryTextStyle.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
