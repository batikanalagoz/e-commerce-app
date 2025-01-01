import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickerImageWidget extends StatelessWidget {
  const PickerImageWidget({
    super.key,
    this.pickedImage,
    required this.function
  });

  final XFile? pickedImage;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
              child: pickedImage ==null
                  ? Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(25)
                ),
              ):Image.file(
                File(pickedImage!.path),
                fit: BoxFit.fill,
              ),
          ),
        ),
        Positioned(
          top: 0,
            right: 0,
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue,
              child:  InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: (){
                  function();
                },
                splashColor: Colors.red,
                child: const Padding(
                    padding: EdgeInsets.all(6),
                  child: Icon(Icons.image , size: 15,),
                ),
              ),
            )
        ),
      ],
    );
  }
}
