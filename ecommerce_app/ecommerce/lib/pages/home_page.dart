import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce/constants/app_constants.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/providers/theme_provider.dart';
import 'package:ecommerce/services/assets.dart';
import 'package:ecommerce/widgets/app_name_text.dart';
import 'package:ecommerce/widgets/product/category_rounded_widget.dart';
import 'package:ecommerce/widgets/product/product_widget.dart';
import 'package:ecommerce/widgets/product/top_product.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final productsProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(// App Bar
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
              AssetsManager.card
          ),
        ),
        title:  const AppNameTextWidget(fontSize: 20),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
              child : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: size.height*0.25,
                    child: ClipRRect(
                      child: Swiper(
                        itemBuilder: (BuildContext context , int index){
                          return Image.asset(
                            AppConstants.bannerImages[index],
                            fit: BoxFit.fill,
                          );
                        },
                          itemCount: AppConstants.bannerImages.length,
                        pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                            activeColor: Colors.red,
                            color: Colors.green
                          )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Visibility(
                      visible: productsProvider.getProducts.isNotEmpty,
                      child: const TitleTextWidget(label: "Top Products")
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),

                  Visibility(
                    visible: productsProvider.getProducts.isNotEmpty,
                    child: SizedBox(
                      height: size.height*0.2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: productsProvider.getProducts.length < 5 ? productsProvider.getProducts.length : 5,
                          itemBuilder: (context , index){
                          return ChangeNotifierProvider.value(
                            value: productsProvider.getProducts[index],
                            child: const TopProductWidget(),
                          );
                          }
                      ),
                    ),
                  ),
                  const TitleTextWidget(label: "Categories"),
                  const SizedBox(
                    height: 15.0,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                    children:
                      List.generate(AppConstants.categoriesList.length, (index){
                       return CategoryRoundedWidget(
                           image: AppConstants.categoriesList[index].image,
                           name: AppConstants.categoriesList[index].name,
                       );
                      }),
                  ),
                ],
              ),
              ),
      ),
    );
  }
}
