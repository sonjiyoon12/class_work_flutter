import 'package:class_google_map_v1/models/saved_Marker.dart';
import 'package:class_google_map_v1/services/storage_service.dart';
import 'package:flutter/material.dart';

class MarkerListScreen extends StatefulWidget {
  const MarkerListScreen({super.key});

  @override
  State<MarkerListScreen> createState() => _MarkerListScreenState();
}

class _MarkerListScreenState extends State<MarkerListScreen> {
  // 데이터가 필요
  List<SavedMarker> _markers = [];
  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    // 저장된 마커 불러 오기
    _loadMarkers();
  }

  // 1.
  Future<void> _loadMarkers() async {
    final markers = await _storageService.loadMarkers();
    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('저장된 장소 ${_markers.length} 개'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        // [SavedMarker(), SavedMarker() ]_markers
        itemCount: _markers.length,
        itemBuilder: (context, index) {
          final marker = _markers[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: Icon(Icons.place, color: Colors.blue),
              // 장소의 이름
              title: Text(marker.name),
              subtitle: Text('위도:${marker.latitude}\n경도:${marker.longitude}'),
              trailing: IconButton(
                onPressed: () async {
                  print('삭제 이벤트 확인');
                  final success = await _storageService.deleteMarker(marker.id);
                  if (success) {
                    _loadMarkers();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${marker.id} 가 삭제 되었습니다'),
                      ),
                    );
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                print("선택된 마커로 자동 이동처리");
                // 화면에 스택 구조가 구글맵에서 -> 저장된 마커 리스트가 올라온 상태
                // 화면을 제거하고 선택된 마커 값을 뒤 화면에 전달 시키는 기능
                Navigator.of(context).pop(marker);
              },
            ),
          );
        },
      ),
    );
  }
}
