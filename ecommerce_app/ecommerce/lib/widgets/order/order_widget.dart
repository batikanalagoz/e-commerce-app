import 'package:ecommerce/constants/app_constants.dart';
import 'package:ecommerce/widgets/subtitle_text.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
                height: size.width*0.25,
                width: size.width*0.25,
                imageUrl: AppConstants.imageUrl
            ),
          ),
          Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: const TitleTextWidget(label: "Product Title" , fontSize: 15,),
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.clear , color: Colors.red,)
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TitleTextWidget(label: "Price"),
                        const SizedBox(width: 15),
                        Flexible(child: SubtitleTextWidget(label: "11\$"))
                      ],
                    ),
                    const SizedBox(height: 7),
                    const SubtitleTextWidget(label: "qty : 20" , fontSize: 13,)
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
