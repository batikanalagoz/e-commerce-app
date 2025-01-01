import 'package:ecommerce/pages/cart/bottom_checkout.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/services/assets.dart';
import 'package:ecommerce/pages/cart/cart_widget.dart';
import 'package:ecommerce/pages/cart/empty_bag.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  final bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItem.isEmpty ?
    Scaffold(
      body: EmptyBagWidget(
          imagePath: AssetsManager.card2,
          title: "Your Cart is Empty",
          subTitle: "Like Your cart is empty",
          buttonText: "shop now",
      ),
    )
        :Scaffold(
        bottomSheet: CartBottomSheetWidget(),
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                  AssetsManager.bagImg2
              ),
            ),
            title: TitleTextWidget(label: "Cart (${cartProvider.getCartItem.length})"),
            actions: [
              IconButton(
                  onPressed: (){
                    cartProvider.clearCart();
                  },
                  icon: const Icon(Icons.delete_forever_rounded , color: Colors.red),
              ),
            ],
          ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.getCartItem.length,
                  itemBuilder: (context , index){
                    return ChangeNotifierProvider.value(
                        value: cartProvider.getCartItem.values.toList()[index],
                      child: const CartWidget(),
                    );
                  }
                ),
            ),
          ],
        ),
    );
  }
}
