import 'package:flutter/material.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildFollowButton(),
        _buildMessageButton(),
      ],
    );
  }

  Widget _buildFollowButton() {
    return InkWell(
      onTap: () {
        print("Follow 버튼 클릭 됨");
      },
      child: Container(
        alignment: Alignment.center,
        // color 속성과 decoration 속성은 전쟁중(같이 쓸 수 없다)
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 150,
        height: 45,
        child: Text("Follow", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildMessageButton() {
    return InkWell(
      onTap: () {
        print("Message 버튼 클릭 됨");
      },
      child: Container(
        alignment: Alignment.center,
        // color 속성과 decoration 속성은 전쟁중(같이 쓸 수 없다)
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
        ),
        width: 150,
        height: 45,
        child: Text("Follow", style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
