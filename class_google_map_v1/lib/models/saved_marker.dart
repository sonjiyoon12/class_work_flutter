// 저장 시킬 마커 정보를 담는 클래스 (추후 확장 가능)

class SavedMarker {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  // GPS 좌표 정보...

  // 생성자에는 ?? if 리턴키워드가 없다

  // 생성자 언더바 _ <--- private <--- 외부에서 생성자 호출 방법이 없다
  SavedMarker._internal({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  // 1. static 저장소(캐시) 준비
  static final Map<String, SavedMarker> _cache = <String, SavedMarker>{};

  // 팩토링 생성자
  factory SavedMarker.fromMap(Map<String, dynamic> map) {
    String id = map["id"] as String;

    if (_cache.containsKey(id)) {
      print("캐시에 저장된 객체 리턴 및 활용");
      // map 구조에 있는 객체를 반환
      return _cache[id]!;
    }

    final newMarker = SavedMarker._internal(
      id: id,
      name: map['name'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
    _cache[id] = newMarker;

    return newMarker;
  }

  // SavedMarker 를 SharedPreferences 에 저장할 형태로 사용 하기 위해 설계
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Map<String, dynamic> map =  SavedMarker().toMap();
}
