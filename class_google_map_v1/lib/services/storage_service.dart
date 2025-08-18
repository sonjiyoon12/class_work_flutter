// SharedPreferences 를 가공해서 관리하는 서비스 클래스
import 'dart:convert';

import 'package:class_google_map_v1/models/saved_Marker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // SharedPreferences - 저장 키
  static const String _markerKey = "saved_markers";

  // C R U D
  /// SavedMarker 들의 객체를 저장하는 기능 설계
  Future<bool> saveMarkers(List<SavedMarker> markers) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // [SavedMarker(), SavedMarker(), SavedMarker(), ]
      // "key1" : 1, "key2" : "abc", "key3" : true, (O)/ "key4" : SavedMarker (X)
      // dart 에서 json 형식을 만들 때 map 구조에서 변경하는게 가장 편하다.
      // {'key1' : 1, 'key2' : 'abc'} --> jsonEncode(map) --> {"key1" : 1, "key2" : "abc"}
      // 자료구조에서 map 메서드는 ( 내부 형태를 다른 형태로 바꿀 때 편하게 사용하는 메서드)
      final markersMapList = markers.map((e) => e.toMap()).toList();
      // [{'id' : "1"}, {'id' : "3"}, {'id' : "4"},] --> List<Map<>>

      // List<Map> 형태를 json 형식으로 변환
      final jsonString = jsonEncode(markersMapList);

      return await prefs.setString(_markerKey, jsonString); // true
    } catch (e) {
      return false;
    }
  }

  /// 저장된 마커를 불러오기
  Future<List<SavedMarker>> loadMarkers() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 저장되어 있는 json 형식의 문자열 가져오기
      final markersJson = prefs.getString(_markerKey);

      if (markersJson != null) {
        final List<dynamic> markersList = jsonDecode(markersJson);
        // [{'id' : "1"}, {'id' : "2"}]
        // 내부에 데이터 타입(형태를 변경할 때 쓰는 녀석)
        return markersList.map((e) => SavedMarker.fromMap(e)).toList();
        // [SavedMarker(), SavedMarker()] 변경 됨
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// 모든 SavedMarker 를 삭제하는 기능 추가
  Future<bool> clearAllMarkers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // "saved_markers" :"[{'id' : "1"}, {'id' : "3"}, {'id' : "4"},]"
      return await prefs.remove(_markerKey);
    } catch (e) {
      return false;
    }
  }

  /// 1단계 마커 객체 하나만 추가하는 코드를 작성해 보시오. (중복 체크)
  Future<bool> addMarker(SavedMarker newMarker) async {
    // ...["", 추가]
    try {
      // 1. {...} 데이터를 가져와야 한다.
      // 2. {...} + {..} 기존에 있던 데이터에 새롭게 추가 한다.
      // 3. Shp 에 다시 리스트 통으로 저장하기

      /// List 객체가 새롭게 추가 된 상태
      final List<SavedMarker> markers = await loadMarkers();

      /// 중복 체크 Stream API 를 활용하면 편리하다
      // 자료 구조에 any() 메서드 사용해보기
      /// markers.any() <-- 조건을 만족하는 요소가 하나라도 있으면 true 반환 한다.
      if (markers.any((marker) => marker.id == newMarker.id)) {
        print('이미 존재하는 마커입니다');
        return false;
      }
      // 새 마커를 리스트 자료구조에 추가하는 코드
      markers.add(newMarker);

      // 리스트 객체 통으로 다시 SharedPreferences 에 저장하는 코드
      return await saveMarkers(markers);
    } catch (e) {
      return false;
    }
  }

  /// 특정 id 값으로 마커 객체 하나를 삭제 하는 코드를 만들어 보시오.
  Future<bool> deleteMarker(String markerId) async {
    try {
      final markers = await loadMarkers();
      final updateMarkers =
          // list.where() --> 조건을 만족하는 요소들만 걸러내서 새로운 컬렉션을
          // 만들어 주는 메서드 이다.
          markers.where((marker) => marker.id != markerId).toList();
      return await saveMarkers(updateMarkers);
    } catch (e) {
      print('마커 삭제 오류: $e');
      return false;
    }
  }
}
