import 'dart:math';

import 'package:ecommerce/constants/app_constants.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/widgets/app_name_text.dart';
import 'package:ecommerce/widgets/product/heart_btn.dart';
import 'package:ecommerce/widgets/subtitle_text.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routName = "/ProductDetailsPage";
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductProvider>(context);
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrProduct = productsProvider.findByProId(productId!);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
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
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: getCurrProduct == null
      ? const SizedBox.shrink()
      :SingleChildScrollView(
        child: Column(
          children: [
            FancyShimmerImage(
                imageUrl: getCurrProduct.productImage,
                height: size.height*0.35,
                width: double.infinity,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          getCurrProduct.productTitle,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                       SubtitleTextWidget(
                          label: "${getCurrProduct.productPrice} \$",
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 30),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       HeartButtonWidget(
                         productId: getCurrProduct.productId,
                         bkgColor: Colors.pink.shade700,
                       ),
                       const SizedBox(width: 20,),
                       Expanded(
                         child: SizedBox(
                           height: kBottomNavigationBarHeight -10,
                           child: ElevatedButton.icon(
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.red,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(30.0)
                               ),
                             ),
                               onPressed: (){
                                 if(cartProvider.isProdinCart(productId: getCurrProduct.productId)){
                                   return;
                                 }
                                 cartProvider.addProductCart(productId: getCurrProduct.productId);


                               },
                               icon:  Icon(
                                   cartProvider.isProdinCart(
                                       productId: getCurrProduct.productId
                                   )
                                       ? Icons.check
                                       :Icons.shopping_cart
                               ),
                               label:  Text(
                                   cartProvider.isProdinCart(
                                       productId: getCurrProduct.productId
                                   )
                                       ? "In cart"
                                       : "Add to cart"

                               ),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitleTextWidget(label: "About this item"),
                      SubtitleTextWidget(label: "In ${getCurrProduct.productCategory}")
                    ],
                  ),
                  const SizedBox(height: 15),
                  SubtitleTextWidget(label: getCurrProduct.productDescription)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
