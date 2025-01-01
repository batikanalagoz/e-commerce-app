import 'package:ecommerce/models/cart_model.dart';
import 'package:ecommerce/pages/cart/quantity_bottom_sheet.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/widgets/product/heart_btn.dart';
import 'package:ecommerce/widgets/subtitle_text.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartModel = Provider.of<CartModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct = productsProvider.findByProId(cartModel.productId);
    return getCurrProduct == null
      ? SizedBox.shrink()
      :FittedBox(
      child: IntrinsicWidth(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: FancyShimmerImage(
                    imageUrl: getCurrProduct.productImage,
                    height: size.height*0.2,
                    width: size.height*0.2,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IntrinsicWidth(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size.width*0.6,
                          child: TitleTextWidget(
                              label: getCurrProduct.productTitle,
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: (){
                                  cartProvider.removeOneItem(productId: getCurrProduct.productId);
                                },
                                icon: const Icon(Icons.clear, color: Colors.red,)
                            ),
                            HeartButtonWidget(productId: getCurrProduct.productId),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SubtitleTextWidget(label: "${getCurrProduct.productPrice} \$" ,color: Colors.blue ,),
                        const Spacer(),
                        OutlinedButton.icon(
                            onPressed: () async{
                              await showModalBottomSheet(
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context){
                                    return QuantityBottomSheetWidget(cartModel: cartModel);
                                  }
                              );
                            },
                            icon: const Icon(IconlyLight.arrow_down_2),
                            label: Text("QTY : ${cartModel.quantity}"),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
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
