import 'dart:math';

import 'package:ecommerce/pages/cart/cart_page.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/pages/profile_page.dart';
import 'package:ecommerce/pages/search_page.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  static const routName = "/RootPage";
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late List<Widget> pages;
  int currentPage = 0;
  late PageController controller;
  bool isLoadingProd = true;

  @override
  void initState(){
    super.initState();
    pages = const[
      HomePage(),
      SearchPage(),
      CartPage(),
      ProfilePage(),
    ];
    controller = PageController(initialPage: currentPage);
  }

  Future<void> fetchFctProd() async{
    final productsProvider = Provider.of<ProductProvider>(context , listen: false);

    try{
      Future.wait({
        productsProvider.fetchProducts(),
      });
    }catch(error){
      print(error.toString());
    }
  }
  @override
  void didChangeDependencies(){
    if(isLoadingProd){
      fetchFctProd();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPage,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index){
          setState(() {
            currentPage = index;
          });
          controller.jumpToPage(currentPage);
        },
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.home),
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          const NavigationDestination(
              selectedIcon: Icon(CupertinoIcons.search),
              icon: Icon(CupertinoIcons.search),
            label: "Search",
          ),
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.bag),
            icon: Badge(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              label: Text(cartProvider.getCartItem.length.toString()),
              child: Icon(IconlyLight.bag_2),
            ),
            label: "Cart",
          ),
          const NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.person),
            icon: Icon(CupertinoIcons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
