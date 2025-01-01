import 'package:ecommerce_admin/pages/editor_upload_product.dart';
import 'package:ecommerce_admin/pages/search_page.dart';
import 'package:ecommerce_admin/services/assets_manager.dart';
import 'package:ecommerce_admin/widget/order/order_page.dart';
import 'package:flutter/material.dart';

class DashboardButtonModel{
  final String text , imagePath;
  final Function onPressed;

  DashboardButtonModel({required this.text,required this.imagePath,required this.onPressed});

  static List<DashboardButtonModel> dashboardBtnList(context) => [
    DashboardButtonModel(
      text: "Add new product",
      imagePath: AssetsManager.bagimg5,
      onPressed: (){
        Navigator.pushNamed(context, EditorUploadProductPage.routName);
      },
    ),
    DashboardButtonModel(
      text: "Add Products",
      imagePath: AssetsManager.bagimages2,
      onPressed: (){
        Navigator.pushNamed(context, SearchPage.routName);
      },
    ),
    DashboardButtonModel(
      text: "View Orders",
      imagePath: AssetsManager.woman,
      onPressed: (){
        Navigator.pushNamed(context, OrderPage.routName);
      },
    ),
  ];
}