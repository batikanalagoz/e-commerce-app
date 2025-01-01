import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecommerce/providers/viewed_recently_provider.dart';
import 'package:ecommerce/services/assets.dart';
import 'package:ecommerce/pages/cart/cart_widget.dart';
import 'package:ecommerce/pages/cart/empty_bag.dart';
import 'package:ecommerce/widgets/product/product_widget.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewedRecentlyPage extends StatelessWidget {
  static const routName = "/ViewedRecentlyPage";
  const ViewedRecentlyPage({super.key});
  final bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    final viewProductProvider = Provider.of<ViewedProductProvider>(context);
    return viewProductProvider.getViewedProduct.isEmpty ?
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
        title: const TitleTextWidget(label: "Viewed Recently"),
      ),
      body: EmptyBagWidget(
        imagePath: AssetsManager.search,
        title: "Your Viewed Recently is Empty",
        subTitle: "Like Your Viewed Recently is empty",
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
        title: TitleTextWidget(label: "Viewed Recently ${viewProductProvider.getViewedProduct.length}"),
      ),
        body: DynamicHeightGridView(
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemCount: viewProductProvider.getViewedProduct.length,
        crossAxisCount: 2,
        builder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ProductWidget(
              productId: viewProductProvider.getViewedProduct.values.toList()[index].productId,
            ),
          );
        },
      ),
    );
  }
}
