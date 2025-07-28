import 'package:class_profile_v2/components/profile_buttons.dart';
import 'package:class_profile_v2/components/profile_count_info.dart';
import 'package:class_profile_v2/components/profile_drawer.dart';
import 'package:class_profile_v2/components/profile_header.dart';
import 'package:class_profile_v2/components/profile_tab.dart';
import 'package:class_profile_v2/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mTheme(),
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
} // end of class MyApp

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios),
          title: Text("Profile"),
          centerTitle: true,
        ),
        endDrawer: ProfileDrawer(),
        body: Column(
          children: [
            const SizedBox(height: 20),
            ProfileHeader(),
            const SizedBox(height: 20),
            ProfileCountInfo(),
            const SizedBox(height: 20),
            ProfileButtons(),
            Expanded(child: ProfileTab())
          ],
        ),
      ),
    );
  }
}
