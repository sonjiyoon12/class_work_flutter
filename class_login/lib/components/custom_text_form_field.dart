import 'package:class_login/size.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  const CustomTextFormField(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: small_gap),
        TextFormField(
          validator: (value) =>
              value!.isEmpty ? "Please enter some text" : null,
          obscureText: text == "Password" ? true : false,
          decoration: InputDecoration(
            hintText: "Enter ${text}",
            // 1. 기본 형태의 디자인
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            // 2. 손가락 터치시 디자인
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            // 3. 에러 발생시 디자인
            errorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            // 4. 에러가 발생한 후 손가락 터치시 디자인
            focusedErrorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }
}
