import 'dart:developer';
import 'package:ecommerce/constants/app_constants.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/viewed_recently_provider.dart';
import 'package:ecommerce/widgets/product/heart_btn.dart';
import 'package:ecommerce/widgets/product/product_details.dart';
import 'package:ecommerce/widgets/subtitle_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TopProductWidget extends StatelessWidget {
  const TopProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productModel = Provider.of<ProductModel>(context);
    final viewedProvider = Provider.of<ViewedProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async{
          viewedProvider.addViewProduct(productId: productModel.productId);
          await Navigator.pushNamed(context, ProductDetailsPage.routName , arguments: productModel.productId);
        },
        child: SizedBox(
          width: size.width*0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: FancyShimmerImage(
                        imageUrl: productModel.productImage,
                      height: size.width*0.24,
                      width: size.width*0.32,
                    ),
                  ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      productModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          HeartButtonWidget(productId: productModel.productId),
                          IconButton(
                            onPressed: (){
                              if(cartProvider.isProdinCart(productId: productModel.productId)){
                                return;
                              }
                              cartProvider.addProductCart(productId: productModel.productId);
                            },
                            icon: Icon(
                                cartProvider.isProdinCart(
                                    productId: productModel.productId
                                )
                                    ? Icons.check
                                    :Icons.add_shopping_cart_outlined),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SubtitleTextWidget(
                          label: "${productModel.productPrice}\$", fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
