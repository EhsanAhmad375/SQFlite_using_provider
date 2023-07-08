import 'package:flutter/material.dart';
class TextFeildCustom extends StatelessWidget {
  TextEditingController? textController;
String?hintText;
   TextFeildCustom({super.key,this.hintText,this.textController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        hintText: '$hintText',
        label: Text('$hintText'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        )

      ),
    );
  }
}