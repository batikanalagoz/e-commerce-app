import 'package:ecommerce_admin/services/assets_manager.dart';
import 'package:ecommerce_admin/widget/dashboard_btn_model.dart';
import 'package:ecommerce_admin/widget/dashboard_btns_widget.dart';
import 'package:ecommerce_admin/widget/title_text.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            AssetsManager.card,
          ),
        ),
        title: const TitleTextWidget(label: "Dashboard Page"),
      ),
      body: GridView.count(
          crossAxisCount: 2,
        children: List.generate(DashboardButtonModel.dashboardBtnList(context).length, (index) =>
            DashboardButtonWidget(
                text: DashboardButtonModel.dashboardBtnList(context)[index].text,
                imagePath:  DashboardButtonModel.dashboardBtnList(context)[index].imagePath,
                onPressed:  DashboardButtonModel.dashboardBtnList(context)[index].onPressed,
            )),
      ),
    );
  }
}
