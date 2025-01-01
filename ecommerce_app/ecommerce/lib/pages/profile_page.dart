import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/pages/auth/login.dart';
import 'package:ecommerce/pages/init_pages/viewed_recently.dart';
import 'package:ecommerce/pages/init_pages/wishlist.dart';
import 'package:ecommerce/providers/user_provider.dart';
import 'package:ecommerce/services/assets.dart';
import 'package:ecommerce/services/my_app_function.dart';
import 'package:ecommerce/widgets/app_name_text.dart';
import 'package:ecommerce/widgets/loading_manager.dart';
import 'package:ecommerce/widgets/order/order_page.dart';
import 'package:ecommerce/widgets/subtitle_text.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  bool _isLoading = true;

  Future<void> fetchUserInfo() async{
    final userProvider = Provider.of<UserProvider>(context , listen: false);
    try{
      setState(() {
        _isLoading = true;
      });
      userModel = await userProvider.fetchUserInfo();
    }catch(error){
      await MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: error.toString(),
          fct: (){}
      );
    }
    finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState(){
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // App Bar
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.card),
        ),
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: Column(
          crossAxisAlignment: user == null ? CrossAxisAlignment.center : CrossAxisAlignment.center,
          mainAxisAlignment: user == null ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            // User Login System
             Visibility(
              visible: user == null ? true:false,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: TitleTextWidget(label: "Please login to have unlimited access"),
              ),
            ),
            userModel == null
            ? const SizedBox.shrink()
            :
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.background,
                          width: 3,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            userModel!.userImage,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        TitleTextWidget(label: userModel!.userName),
                        const SizedBox(
                          height: 6,
                        ),
                        SubtitleTextWidget(label: userModel!.userEmail),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            userModel == null
                ? const SizedBox.shrink()
                :
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TitleTextWidget(label: "Information"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.bagImg2,
                    text: "All Orders",
                    function: () {
                      Navigator.pushNamed(context, OrderPage.routName);
                    },
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.bagImg1,
                    text: "favorite",
                    function: () {
                      Navigator.pushNamed(context, WishlistPage.routName);
                    },
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.clock,
                    text: "Viewed Recently",
                    function: () {
                      Navigator.pushNamed(context, ViewedRecentlyPage.routName);
                    },
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.location,
                    text: "Address",
                    function: () {},
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.privacy,
                    text: "Settings",
                    function: () {},
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: Text(themeProvider.getIsDarkTheme
                        ? "Dark Mode"
                        : "Light Mode"),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    },
                  )
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  if(user == null){
                    Navigator.pushNamed(context, LoginPage.routName);
                  }
                  else{
                    await MyAppFunctions.showErrorOrWarningDialog(
                      context: context,
                      subtitle: "are you sure ?",
                      fct: () async{
                        await FirebaseAuth.instance.signOut();
                        if(!mounted)return;
                           Navigator.pushNamed(context, LoginPage.routName);
                      },
                      isError: false,
                    );
                  }
                },
                icon: Icon(user == null ? Icons.login : Icons.logout),
                label:  Text(user == null ? "Login" : "Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });

  final String imagePath, text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubtitleTextWidget(label: text),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: const Icon(CupertinoIcons.right_chevron),
    );
  }
}
