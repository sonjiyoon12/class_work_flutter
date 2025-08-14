import 'package:class_google_map_v1/models/saved_Marker.dart';
import 'package:class_google_map_v1/services/storage_service.dart';
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

  Set<Marker> _markerSet = {};
  final StorageService _storageService = StorageService();

  // 쉐어드프리퍼런스에 저장되어 있던 데이터를 담을 자료 구조
  List<SavedMarker> _savedMarkers = [];

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  /// 저장된 마커들을 불러오기
  Future<void> _loadMarkers() async {
    try {
      final List<SavedMarker> loadedMarkers =
          await _storageService.loadMarkers();

      setState(() {
        _savedMarkers = loadedMarkers;
        _markerSet.clear(); // 기존에 있던 마커를 다 제거

        for (SavedMarker m in loadedMarkers) {
          _markerSet.add(
            Marker(
              markerId: MarkerId(m.id),
              position: LatLng(m.latitude, m.longitude),
              infoWindow: InfoWindow(
                title: m.name,
                snippet: "나의 장소",
              ),
            ),
          );
        }
      });
    } catch (e) {
      _showMessage('마커를 불러 오는 데 실패');
    }
  }

  // 스낵바 메세지 만들어 보기
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // 지도에 탭 이벤트 처리
  void _onMapTapped(LatLng position) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('새 장소 추가'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: '장소 이름',
                  hintText: '장소 이름을 입력하세요',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _addMarker(position, nameController.text);
              },
              child: Text('추가'),
            ),
          ],
        );
      },
    );
  }

  void _addMarker(LatLng position, String name) {
    // 고유 ID 생성
    final markerId = DateTime.now().millisecond.toString();

    // 새로운 SavedMarker 객체 생성
    final newMarker = SavedMarker.fromMap(
      {
        'id': markerId,
        'name': name,
        'latitude': position.latitude,
        'longitude': position.longitude,
      },
    );

    setState(() {
      // 새롭게 생성한 객체를 마커 List 자료구조에 넣기
      _savedMarkers.add(newMarker);

      // 지도에 마커 추가
      _markerSet.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          infoWindow: InfoWindow(
            title: name,
            snippet: '저장된 장소',
          ),
        ),
      );
    });
    // 로컬에 저장
    _saveMarkers();
  }

  Future<void> _saveMarkers() async {
    try {
      final success = await _storageService.saveMarkers(_savedMarkers);
      if (success) {
        _showMessage("마커 저장 완료");
      } else {
        _showMessage("마커 저장 실패");
      }
    } catch (e) {
      _showMessage("마커 저장 실패");
    }
  }

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
          ),
          IconButton(
            onPressed: () async {
              await StorageService().clearAllMarkers();
              setState(() {
                _markerSet = {};
                _savedMarkers = [];
              });
            },
            icon: Icon(Icons.delete_forever),
          ),
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
        markers: _markerSet,
        onTap: _onMapTapped,
      ),
      bottomNavigationBar: Container(
        color: Colors.blue[200],
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '마커된 장소 ${_savedMarkers.length} 개',
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
