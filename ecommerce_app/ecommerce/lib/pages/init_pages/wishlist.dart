import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecommerce/pages/cart/bottom_checkout.dart';
import 'package:ecommerce/providers/wishlist_provider.dart';
import 'package:ecommerce/services/assets.dart';
import 'package:ecommerce/pages/cart/cart_widget.dart';
import 'package:ecommerce/pages/cart/empty_bag.dart';
import 'package:ecommerce/widgets/app_name_text.dart';
import 'package:ecommerce/widgets/product/product_widget.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  static const routName = "/WishlistPage";
  const WishlistPage({super.key});
  final bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return wishlistProvider.getWishlist.isEmpty ?
    Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const TitleTextWidget(label: "Wishlist"),
      ),
      body: EmptyBagWidget(
        imagePath: AssetsManager.bagImg7,
        title: "Your Wishlist is Empty",
        subTitle: "Like Your Wishlist is empty",
        buttonText: "shop now",
      ),
    )
        :Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: (){
                if(Navigator.canPop(context)){
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: TitleTextWidget(label: "Wishlist ${wishlistProvider.getWishlist.length}"),
      ),
          body: DynamicHeightGridView(
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemCount: wishlistProvider.getWishlist.length,
              crossAxisCount: 2,
              builder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ProductWidget(
                    productId: wishlistProvider.getWishlist.values.toList()[index].productId,
                  ),
                );
              },
          ),
    );
  }
}
