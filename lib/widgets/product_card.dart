import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product_model.dart';
import '../pages/product_page.dart';
import '../theme.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductPage(product)));
      },
      child: Column(children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                product.icon.toString(),
              ),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
            color: primaryTextColor,
            border: Border.all(color: secondColor, width: 3),
          ),
          child: Icon(Icons.star, color: Colors.amber),

          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 20),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         product.name.toString(),
          //         overflow: TextOverflow.ellipsis,
          //         maxLines: 2,
          //         style: secondaryTextStyle.copyWith(
          //           fontSize: 12,
          //           fontWeight: regular,
          //         ),
          //       ),
          //       // SizedBox(height: 6),
          //       // Text(
          //       //   product.name.toString(),
          //       //   style: productCardTextStyle.copyWith(
          //       //     fontSize: 18,
          //       //     fontWeight: semiBold,
          //       //   ),
          //       //   overflow: TextOverflow.ellipsis,
          //       //   maxLines: 1,
          //       // ),
          //       SizedBox(height: 6),
          //       Text(
          //         NumberFormat.currency(
          //                 locale: 'id', symbol: 'Rp ', decimalDigits: 0)
          //             .format(product.price),
          //         style: priceTextStyle.copyWith(
          //           fontWeight: semiBold,
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ),
        SizedBox(height: 10),
        Container(
          width: 66,
          height: 60,
          child: Text(
            product.name.toString(),
            maxLines: 3,
            style: secondaryTextStyle.copyWith(
              fontSize: 12,
              color: Colors.white,
              fontWeight: regular,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    );
  }
}
