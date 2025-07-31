import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('드래그 기능 만들어 보기')),
        body: DraggableBox(),
      ),
    );
  }
}

class DraggableBox extends StatefulWidget {
  const DraggableBox({super.key});

  @override
  State<DraggableBox> createState() => _DraggableBoxState();
}

class _DraggableBoxState extends State<DraggableBox> {
  double _xOffset = 0.0; // x축 이동 값
  double _yOffset = 0.0; // y축 이동 값

  // 객체가 생성될 때 단 한번만 호출 되어 지는 메서드
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 드래그가 업데이트 될 때 호출 되는 콜백
      onPanUpdate: (details) {
        print('details 1 : ${details.runtimeType}');
        print('details 2 : ${details.toString()}');
        setState(() {
          _xOffset += details.delta.dx;
          _yOffset += details.delta.dy;
        });
      },
      child: Stack(
        children: [
          Positioned(
            left: _xOffset,
            top: _yOffset,
            child: Container(
              color: Colors.redAccent,
              width: 150,
              height: 150,
              child: Text('드래그 해보세요!'),
            ),
          )
        ],
      ),
    );
  }

  // initState()
  // State 객체가 생성된 후 호출되며, 위젯 상태를 초기화 하는데
  // 보통 사용됨. 전체 생명 주기 중, 한번만 호출됨.
  // build()
  // initState() 호출 후, 동작을 하고 개발자가 setState() 메서드를
  // 호출하게 되면 build() 메서드가 재 호출됨.
  // dispose()
  // 위젯 트리에서 제거될 때 호출 되며, State 객체가 영구적으로 제거되고
  // 사용했던 자원들도 해제 시킬 수 있다. (해제)

  // 메모리에 내려갈 때
  @override
  void dispose() {
    // 자원 해제가 필요한 부분을 여기서 설정 한다.
    super.dispose();
  }
}
