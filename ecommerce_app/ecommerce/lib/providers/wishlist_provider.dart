import 'package:ecommerce/models/wishlist_model.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier{
  final Map<String,WishlistModel> _wishlistItems = {};
  Map<String , WishlistModel> get getWishlist{
    return _wishlistItems;
  }

  void addOrRemoverWishlist({required String productId}){
   if(_wishlistItems.containsKey(productId)){
     _wishlistItems.remove(productId);
   }
   else{
     _wishlistItems.putIfAbsent(productId, () => WishlistModel(
         wishlistId: const Uuid().v4(),
         productId: productId));
   }
   notifyListeners();
   }

   bool isProdingWishlist({required String productId}){
    return _wishlistItems.containsKey(productId);
   }

   void clearWishlist(){
    _wishlistItems.clear();
    notifyListeners();
   }
}