import 'dart:developer';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/pages/cart/cart_widget.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/services/assets.dart';
import 'package:ecommerce/widgets/app_name_text.dart';
import 'package:ecommerce/widgets/product/product_widget.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const routName = "/SearchPage";
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  late TextEditingController searchTextController;
  @override
  void initState(){
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    String? passedCategory =
      ModalRoute.of(context)!.settings.arguments as String?;
    List<ProductModel>productList = passedCategory == null
        ?productsProvider.products
        :productsProvider.findByCategory(categoryName: passedCategory);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
                AssetsManager.card
            ),
          ),
          title:   TitleTextWidget(label: passedCategory ?? "Search products"),
        ),
        body: productList.isEmpty
          ? const Center(child: TitleTextWidget(label: "No product"),)
        :Padding(
            padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      //setState(() {
                        FocusScope.of(context).unfocus();
                        searchTextController.clear();
                     // });
                    },
                    child: const Icon(Icons.clear, color: Colors.red),
                  ),
                ),
                onChanged: (value){
                  // log("value of text is $value");
                },
                onSubmitted: (value){
                  setState(() {
                    productListSearch = productsProvider.searchQuery(
                      passedList: productList,
                        searchText: searchTextController.text
                    );
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),

              if(searchTextController.text.isNotEmpty && productListSearch.isEmpty)...[
                const Center(
                  child:  TitleTextWidget(label: "No products found"),
                )
              ],

              Expanded(
                  child: DynamicHeightGridView(
                      mainAxisSpacing: 12,
                      itemCount: searchTextController.text.isNotEmpty
                          ?productListSearch.length
                      : productList.length,
                      crossAxisCount: 2,
                    crossAxisSpacing: 12,
                      builder: (context , index){
                        return  ProductWidget(
                            productId: searchTextController.text.isNotEmpty
                                ? productListSearch[index].productId
                                : productList[index].productId,
                        );
              },
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
