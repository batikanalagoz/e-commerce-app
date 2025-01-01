import 'package:flutter/material.dart';

class ViewedModel with ChangeNotifier{
  final String  viewedId;
  final String productId;

  ViewedModel({
    required this. viewedId,
    required this.productId,
  });
}