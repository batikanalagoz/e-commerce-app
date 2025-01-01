
import 'package:ecommerce_admin/services/assets_manager.dart';
import 'package:ecommerce_admin/widget/order/empty_bag.dart';
import 'package:ecommerce_admin/widget/order/order_widget.dart';
import 'package:ecommerce_admin/widget/title_text.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  static const routName = "/OrderScreen";

  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isEmptyOrders =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: (){
                if(Navigator.canPop(context)){
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
            ),
            title: const TitleTextWidget(label: "All Orders")
        ),
        body: isEmptyOrders
            ?
        EmptyBagWidget(
            imagePath: AssetsManager.rounden_map,
            title: "No orders has bee placed",
            subtitle: " ",
            buttonText: "shop now")
            : ListView.separated(
            itemBuilder: (ctx, index){
              return const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 2, vertical:  6),
                child: OrdersWidgetFree(),

              );
            },
            separatorBuilder: (BuildContext context, int index){
              return const Divider(
                color:Colors.black54,
              );
            },
            itemCount: 10)





    );
  }
}
