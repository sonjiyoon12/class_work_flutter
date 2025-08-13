import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // 구글맵 사용해 보기 sdk 버전
  // 1 단계 - 지도를 조작하기 위한 리모컨이 필요하다.
  GoogleMapController? _controller;

  // 특정 위치로 부드럽게 이동 처리
  // 현재 줌(확대, 축소) 레벨 조정 1~20
  // 1 - 전세계 지도, 15 - 도시 레벨
  // 화면에 중심 좌표 가져오기

  // 2. 중심 좌표 객체 생성
  static const LatLng _initCenter = LatLng(35.162439, 129.062293);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        foregroundColor: Colors.orange,
        title: Text('처음 만나는 구글 맵'),
        actions: [
          IconButton(
            onPressed: _showMarkerList,
            icon: Icon(Icons.list),
          )
        ],
      ),
      // 3단계 - GoogleMap 위젯 사용
      // GoogleMap - 지도의 모든 것을 담을 수 있는 그릇
      body: GoogleMap(
        onMapCreated: (controller) {
          // controller <-- 새롭게 생성된 지도 안에 생성한 GoogleController
          // 내 코드에서 이 녀석을 사용하기 위해 멤버 변수로 선언을 해뒀음
          // 주소 값을 연결 시켜 두었다.
          _controller = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _initCenter,
          zoom: 15,
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.blue[200],
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '마커된 장소 0 개',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // 마커 목록 화면 표시 메서드
  void _showMarkerList() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('목록 화면은 단계에서 구현할 예정'),
      ),
    );
  }
}
