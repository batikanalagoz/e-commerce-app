import 'package:ecommerce/root_page.dart';
import 'package:ecommerce/services/my_app_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSingIn({required BuildContext context})async{
    try{
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();
      if(googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        if(googleAuth.accessToken != null && googleAuth.idToken !=null){
          final authResults = await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
          ));
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp){
        Navigator.pushReplacementNamed(context, RootPage.routName);
      });
    } on FirebaseException catch(error){
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: error.message.toString(),
        fct: (){},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
        onPressed: () async{
        await _googleSingIn(context: context);
        },
        icon: const Icon(Ionicons.logo_google),
        label: const Text("Sing in with Google"),
    );
  }
}
