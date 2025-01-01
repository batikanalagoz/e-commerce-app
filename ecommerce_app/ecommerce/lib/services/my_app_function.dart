import 'package:ecommerce/services/assets.dart';
import 'package:ecommerce/widgets/subtitle_text.dart';
import 'package:ecommerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAppFunctions{
  static Future<void> showErrorOrWarningDialog({
    required BuildContext context,
    required String subtitle,
    bool isError = true,
    required Function fct,

})async{
    await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                    isError ? AssetsManager.error : AssetsManager.warning,
                  height: 60,
                  width: 60,
                ),
                const SizedBox(height: 16),
                SubtitleTextWidget(label: subtitle , fontWeight: FontWeight.w600,),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: !isError,
                        child: TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const SubtitleTextWidget(label: "Cancel", color: Colors.greenAccent),
                        ),
                    ),
                    TextButton(
                        onPressed: (){
                          fct();
                          Navigator.pop(context);
                        },
                        child: const SubtitleTextWidget(label: "Yes", color: Colors.red)
                    ),
                  ],
                )
              ],
            ),
          );
        }
    );
  }
  static Future<void> ImagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
})async{
    await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Center(
              child: TitleTextWidget(label: "Choose option"),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                      onPressed: (){
                        cameraFCT();
                        if(Navigator.canPop(context)){
                          Navigator.pop(context);
                        }
                      }, 
                      icon: const Icon(Icons.camera),
                      label: const Text("Camera"),
                  ),
                  TextButton.icon(
                    onPressed: (){
                      galleryFCT();
                      if(Navigator.canPop(context)){
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Gallery"),
                  ),TextButton.icon(
                    onPressed: (){
                      removeFCT();
                      if(Navigator.canPop(context)){
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text("Remove"),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}