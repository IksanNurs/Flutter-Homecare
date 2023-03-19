import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product_model.dart';
import '../theme.dart';

class BubbleChat extends StatelessWidget {
  final String message;
  final bool isMe;
  final ProductModel? product;

  BubbleChat({this.message = '', this.isMe = false, this.product});

  @override
  Widget build(BuildContext context) {
    Widget _productPreview() {
      return Container(
        width: 231,
        // height: 155,
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? bgColor5 : bgColor6,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isMe ? 12 : 0),
            topRight: Radius.circular(isMe ? 12 : 0),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product!.icon.toString(),
                    width: 70,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product!.name!,
                        style: primaryTextStyle,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${product!.price!.toString()}',
                        style: priceTextStyle.copyWith(fontWeight: medium),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    'Add To Cart',
                    style: hyperLinkStyle,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    side: BorderSide(
                      color: primaryColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Buy Now',
                      style: GoogleFonts.poppins(
                        color: bgColor5,
                        fontWeight: medium,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          product is UninitializedProductModel ? SizedBox() : _productPreview(),
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isMe ? bgColor5 : bgColor6,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isMe == true ? 12 : 0),
                      topRight: Radius.circular(isMe == true ? 0 : 12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    message,
                    style: primaryTextStyle,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
