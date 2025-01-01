import 'package:ecommerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppNameTextWidget extends StatelessWidget {
  const AppNameTextWidget({
    super.key,
    this.fontSize=30
  });

  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: const Duration(seconds: 22) ,
        baseColor: Colors.orange.shade800,
        highlightColor: Colors.yellow.shade600,
        child: TitleTextWidget(
          label: "AlagoEs Shop",
          fontSize: fontSize
        ),
    );
  }
}
