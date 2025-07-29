import 'package:class_login/components/custom_text_form_field.dart';
import 'package:class_login/size.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  // 1. Form 태그에서 사용하는 키 값을 설정해야 한다
  final _formKey = GlobalKey<FormState>(); // 1. 글로벌 key

  CustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      // 2. key 라는 속성에 연결해 주어야 한다.
      // 글로벌 key를 form 태그에 연결하면  key로 form의 상태를 관리할 수 있다.
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField("Email"),
          SizedBox(height: medium_gap),
          CustomTextFormField("Password"),
          SizedBox(height: large_gap),
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // 앱에 화면을 전환 시키는 방법
                  // 비동기 방식으로 통신 요청 --> 응답 --> 화면 이동(잘못된 비번.. 아이디)
                  Navigator.pushNamed(context, "/home");
                }
              },
              child: Text("Login")),
        ],
      ),
    );
  }
}
