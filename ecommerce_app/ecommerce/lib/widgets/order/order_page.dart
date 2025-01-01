import 'package:ecommerce/pages/cart/empty_bag.dart';
import 'package:ecommerce/pages/init_pages/wishlist.dart';
import 'package:ecommerce/services/assets.dart';
import 'package:ecommerce/widgets/order/order_widget.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  static const routName = "/OrderPage";
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

   bool isEmptyOrders = false;
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
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const TitleTextWidget(label: "All Orders"),
      ),
      body: isEmptyOrders ?
          EmptyBagWidget(
              imagePath: AssetsManager.roundedMap,
              title: "No orders has bee placed",
              subTitle: " ",
              buttonText: "shop now"
          ):ListView.separated(
          itemBuilder: (ctx , index){
          return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2,vertical: 6),
          child: OrdersWidget(),
          );
          } ,
          separatorBuilder: (BuildContext context , int index){
          return const Divider(
            color: Colors.black54,
          );
        },
        itemCount: 10,
      ),
    );
  }
}
