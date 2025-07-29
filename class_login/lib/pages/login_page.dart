import 'package:class_login/components/custom_form.dart';
import 'package:class_login/components/logo.dart';
import 'package:class_login/size.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: xlarge_gap),
            Logo('Login'),
            SizedBox(height: large_gap),
            // form 태그(이메일, pwd)
            CustomForm(),
          ],
        ),
      ),
    );
  }
}
