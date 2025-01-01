import 'package:ecommerce_admin/constans/theme_data.dart';
import 'package:ecommerce_admin/firebase_options.dart';
import 'package:ecommerce_admin/pages/dashboard_page.dart';
import 'package:ecommerce_admin/pages/editor_upload_product.dart';
import 'package:ecommerce_admin/pages/search_page.dart';
import 'package:ecommerce_admin/provider/product_provider.dart';
import 'package:ecommerce_admin/provider/theme_provider.dart';
import 'package:ecommerce_admin/widget/order/order_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: SelectableText(snapshot.error.toString()),
              ),
            ),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => ProductProvider()),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Ecommerce App',
                theme: Styles.themeData(
                  isDarkTheme: themeProvider.getIsDarkTheme,
                  context: context,
                ),
                home: const DashboardPage(),
                routes: {
                  OrderPage.routName: (context) => const OrderPage(),
                  SearchPage.routName: (context) => const SearchPage(),
                  EditorUploadProductPage.routName: (context) =>
                  const EditorUploadProductPage(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
