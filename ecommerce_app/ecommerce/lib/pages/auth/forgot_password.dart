import 'package:ecommerce/constants/validator.dart';
import 'package:ecommerce/services/assets.dart';
import 'package:ecommerce/widgets/app_name_text.dart';
import 'package:ecommerce/widgets/subtitle_text.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ForgotPassword extends StatefulWidget {
  static const routName = "/ForgotPassword";
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  late final TextEditingController _emailController;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState(){
    _emailController = TextEditingController();
    super.initState();
  }
  @override
  void dispose(){
    if (mounted){
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> _ForgetPassFct() async{
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid){}
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppNameTextWidget(
          fontSize: 20,
        ),
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
              height: 10,
          ),
          Image.asset(
            AssetsManager.forget,
            width: size.width*0.6,
            height: size.width*0.6,
          ),
              const SizedBox(
                height: 10,
              ),
              const TitleTextWidget(
                label: "Forget Password",
              ),
              const SubtitleTextWidget(label: "Please Enter Email Address" , fontSize: 13,),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email Address",
                        prefixIcon: Icon(IconlyLight.message),
                      ),
                      validator: (value){
                        return MyValidators.EmailValidator(value);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )
                        ),
                        onPressed: () async{
                          await _ForgetPassFct();
                        },
                        icon: const Icon(Icons.help),
                        label: const Text("Password Send Email"),
                      ),
                    ),
                  ],
                ),
              )
          ],
          ),
        ),
      ),
    );
  }
}
