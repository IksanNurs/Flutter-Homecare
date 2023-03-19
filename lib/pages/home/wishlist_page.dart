import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/page_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../widgets/wishlist_card.dart';
import '../../theme.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget _header() {
      return AppBar(
        backgroundColor: bgColor1,
        centerTitle: true,
        title: Text(
          'Favorite Shoes',
          style: primaryTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 18,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      );
    }

    Widget _noWishlist() {
      return Expanded(
        child: Container(
          color: bgColor3,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image_wishlist.png',
                width: 80,
              ),
              SizedBox(height: 20),
              Text(
                'You don\'t have dream shoes?',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Let\'s find your favorite shoes',
                style: secondaryTextStyle.copyWith(
                  fontWeight: regular,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    pageProvider.currentIndex = 0;
                  },
                  child: Text(
                    'Explore Store',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _contentWishlist() {
      return Expanded(
        child: Container(
          color: bgColor3,
          width: double.infinity,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            children: wishlistProvider.itemsWishlist
                .map((product) => WishlistCard(product))
                .toList(),
          ),
        ),
      );
    }

    return Column(
      children: [
        _header(),
        // _noWishlist(),
        wishlistProvider.itemsWishlist.length == 0
            ? _noWishlist()
            : _contentWishlist()
      ],
    );
  }
}
