import 'package:flutter/material.dart';
import 'package:store_app/main.dart';

void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StorePage1(),
    );
  }
}

class StorePage1 extends StatelessWidget {
  const StorePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Text("woman", style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("kids", style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("shoes", style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("bag", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
                child:
                    Image.asset("assets/images/bag.jpeg", fit: BoxFit.cover)),
            const SizedBox(height: 2),
            Expanded(
                child:
                    Image.asset("assets/images/cloth.jpeg", fit: BoxFit.cover)),
          ],
        ),
      ),
    );
  }
}
