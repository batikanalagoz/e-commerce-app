import 'package:ecommerce/models/viewed_product.dart';
import 'package:ecommerce/models/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ViewedProductProvider with ChangeNotifier{
  final Map<String,ViewedModel> _viewedProdItems = {};
  Map<String , ViewedModel> get getViewedProduct{
    return _viewedProdItems;
  }

  void addViewProduct({required String productId}){
    _viewedProdItems.putIfAbsent(productId, () => ViewedModel(
        viewedId : const Uuid().v4(), productId : productId

    ));


    notifyListeners();
  }
}