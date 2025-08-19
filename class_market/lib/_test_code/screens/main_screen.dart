import 'package:class_market/_test_code/screens/home/home_screen_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chatting/chatting_screen.dart';
import 'home/home_screen_test.dart';
import 'my_carrot/my_carrot_screen.dart';
import 'near_me/near_me_screen.dart';
import 'neighborhood_life/neighborhood_life_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    print('main02->mainScreen() build() 함수 호출 됨');
    return Scaffold(
      // IndexedStack --> 모든 화면이 다 로딩 된다.
      // index 번호로 접근 및 조작할 수 있다.
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreenTest(),
          NeighborhoodLifeScreen(),
          NearMeScreen(),
          ChattingScreen(),
          MyCarrotScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // BottomNavigationBarItem 이 화면에 전부 표시가 안될때
        // 설정 하면 보여 주는 속성
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value) {
          // 화면 재갱신 요청
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: '홈',
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            label: '동네생활',
            icon: Icon(CupertinoIcons.square_arrow_down),
          ),
          BottomNavigationBarItem(
            label: '내 근처',
            icon: Icon(CupertinoIcons.placemark),
          ),
          BottomNavigationBarItem(
            label: '채팅',
            icon: Icon(CupertinoIcons.chat_bubble_text),
          ),
          BottomNavigationBarItem(
            label: '나의 당근',
            icon: Icon(CupertinoIcons.person),
          ),
        ],
      ),
    );
  }
}
