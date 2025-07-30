import 'package:class_shoppingcart/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingcartHeader extends StatefulWidget {
  const ShoppingcartHeader({super.key});

  @override
  State<ShoppingcartHeader> createState() => _ShoppingcartHeaderState();
}

class _ShoppingcartHeaderState extends State<ShoppingcartHeader> {
  int selectedId = 0;

  // 변수 assets/p1.jpeg
  List<String> selectPic = [
    'assets/p1.jpeg',
    'assets/p2.jpeg',
    'assets/p3.jpeg',
    'assets/p4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 이미지 영역
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AspectRatio(
            aspectRatio: 5 / 3,
            child: Image.asset(
              selectPic[selectedId],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildHeaderSelectorButton(0, Icons.directions_bike),
              _buildHeaderSelectorButton(1, Icons.motorcycle),
              _buildHeaderSelectorButton(2, CupertinoIcons.car_detailed),
              _buildHeaderSelectorButton(3, CupertinoIcons.airplane),
            ],
          ),
        )
      ],
    );
  }

  // 메서드
  Widget _buildHeaderSelectorButton(int id, IconData mIcon) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: id == selectedId ? kAccentColor : kSecondaryColor,
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            selectedId = id;
          });
        },
        icon: Icon(mIcon),
      ),
    );
  }
}
