import 'package:ecommerce/constants/theme_data.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/pages/auth/forgot_password.dart';
import 'package:ecommerce/pages/auth/login.dart';
import 'package:ecommerce/pages/auth/register.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/pages/init_pages/viewed_recently.dart';
import 'package:ecommerce/pages/init_pages/wishlist.dart';
import 'package:ecommerce/pages/search_page.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/providers/theme_provider.dart';
import 'package:ecommerce/providers/user_provider.dart';
import 'package:ecommerce/providers/viewed_recently_provider.dart';
import 'package:ecommerce/providers/wishlist_provider.dart';
import 'package:ecommerce/root_page.dart';
import 'package:ecommerce/widgets/order/order_page.dart';
import 'package:ecommerce/widgets/product/product_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform
        ),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          else if(snapshot.hasError){
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: SelectableText(snapshot.error.toString()),
                ),
              ),
            );
          }



    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_){
        return ThemeProvider();
      }),
      ChangeNotifierProvider(create: (_){
        return ProductProvider();
      }),
      ChangeNotifierProvider(create: (_){
        return CartProvider();
      }),
      ChangeNotifierProvider(create: (_){
        return WishlistProvider();
      }),
      ChangeNotifierProvider(create: (_){
        return ViewedProductProvider();
      }),
      ChangeNotifierProvider(create: (_){
        return UserProvider();
      }),
    ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ecommerce App ',
          theme: Styles.themeData(isDarkTheme: themeProvider.getIsDarkTheme, context: context),
            home:const LoginPage(),
           //home:const RootPage(),
          routes: {
            ProductDetailsPage.routName : (context)=> const ProductDetailsPage(),
            WishlistPage.routName : (context)=> const WishlistPage(),
            ViewedRecentlyPage.routName : (context)=> const ViewedRecentlyPage(),
            RegisterPage.routName : (context)=> const RegisterPage(),
            OrderPage.routName : (context)=> const OrderPage(),
            ForgotPassword.routName : (context)=> const ForgotPassword(),
            SearchPage.routName : (context)=> const SearchPage(),
            RootPage.routName : (context)=> const RootPage(),
            LoginPage.routName : (context)=> const LoginPage(),
          },
        );


      }),

    );
        }
    );
  }
}
