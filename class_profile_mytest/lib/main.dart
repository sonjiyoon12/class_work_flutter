import 'package:class_profile_mytest/components/profile_buttons.dart';
import 'package:class_profile_mytest/components/profile_count_info.dart';
import 'package:class_profile_mytest/components/profile_drawer.dart';
import 'package:class_profile_mytest/components/profile_header.dart';
import 'package:class_profile_mytest/theme.dart';
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
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text('Profile'),
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
          ProfileButtons()
        ],
      ),
    );
  }
}
