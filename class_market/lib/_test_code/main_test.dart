import 'screens/main_screen.dart'; // 상대 경로
import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(CarrotMarketUI());
}

class CarrotMarketUI extends StatelessWidget {
  const CarrotMarketUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'carrot',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      theme: mTheme(),
    );
  }
}
