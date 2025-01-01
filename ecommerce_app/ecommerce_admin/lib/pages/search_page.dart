import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecommerce_admin/models/product_model.dart';
import 'package:ecommerce_admin/provider/product_provider.dart';
import 'package:ecommerce_admin/services/assets_manager.dart';
import 'package:ecommerce_admin/widget/product_widget.dart';
import 'package:ecommerce_admin/widget/title_text.dart';
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
    String? passedCategory = ModalRoute.of(context)!.settings.arguments as String?;

    // Firebase'den veri çekmek için provider'dan products'ı alıyoruz
    productsProvider.fetchProducts(); // Ürünleri veritabanından çekiyoruz.

    List<ProductModel> productList = passedCategory == null
        ? productsProvider.getProducts
        : productsProvider.findByCategory(categoryName: passedCategory);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          title: TitleTextWidget(label: passedCategory ?? "Search products"),
        ),
        body: productList.isEmpty
            ? const Center(child: TitleTextWidget(label: "No product"))
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 15.0),
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      searchTextController.clear();
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    productListSearch = productsProvider.searchQuery(
                        searchText: value, passedList: productList);
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    productListSearch = productsProvider.searchQuery(
                        searchText: searchTextController.text,
                        passedList: productList);
                  });
                },
              ),
              const SizedBox(height: 15.0),
              if (searchTextController.text.isNotEmpty && productListSearch.isEmpty)
                const Center(child: TitleTextWidget(label: "No products found")),
              Expanded(
                child: DynamicHeightGridView(
                  mainAxisSpacing: 12,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  itemCount: searchTextController.text.isNotEmpty
                      ? productListSearch.length
                      : productList.length,
                  builder: (context, index) {
                    return ProductWidget(
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
