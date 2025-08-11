// 서비스와 비슷

import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
// 파일의 경로를 쉽게 다루게 하는 유틸리티 클래스

class ImageHelper {
  // 서버 측 URL 설정 (개발 환경 IP 주소 관리)
  static const String _baseUrl = "http://192.168.0.187:8080";
  static const String _uploadEndpoint = '/api/images';

  // 카메라로 사진 촬영
  static Future<File?> _takePhoto() async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('카메라 촬영 오류 $e');
      return null;
    }
  }

  // 서버측으로 이미지 업로드 기능
  static Future<Map<String, dynamic>> uploadToServer(File imageFile) async {
    // 1. 파일을 바이트로 변환해서 읽어야 함 (비동기 함수)
    // await 필수
    final bytes = await imageFile.readAsBytes();

    // 2. Base64 인코딩 처리
    final base64String = base64Encode(bytes as List<int>);

    // 3. 파일 확장자 추출 abc.png, a.jpeg <-- .png, .jpeg만 추출
    final extension =
        path.extension(imageFile.path).toLowerCase(); // .toLowerCase() 소문자
    // Base64 -> data:image/png;base64,SFRGRrey...

    String mimeType = 'image/jpeg';
    switch (extension) {
      case '.png':
        mimeType = 'image/png';
        break;
      case '.jpg':
      case '.jpeg':
        mimeType = 'image/jpeg';
        break;
      case '.gif':
        mimeType = 'image/gif';
        break;
      default:
        mimeType = 'image/jpeg';
    }
    // Base64 데이터에 접두사 추가 (웹 표준 형식)
    final imageDataWithPrefix = 'data:${mimeType};base64,$base64String';

    // 파일명 추출 (path.basename - 기본 설정된 파일명을 추출해 준다.)
    final fileName = path.basename(imageFile.path);

    // 서버에 요청할 데이터 구성
    final requestData = {
      'fileName': fileName,
      'imageData': imageDataWithPrefix,
    };

    // http post 요청
    final response = await http.post(
      Uri.parse('$_baseUrl$_uploadEndpoint'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(requestData),
    );
    //로깅 처리
    print('응답 상태 코드 : ${response.statusCode}');
    print('응답 본문 : ${response.body}');

    // 응답 처리
    if (response.statusCode == 200) {
      // 모델링 처리를 하지 않고 바로 Map 구조로 활용 하기로 함
      // jsonDecode --> Map 구조 데이터 타입 변환
      final responseData = jsonDecode(response.body);
      return {
        'success': true,
        'message': '이미지가 성공적으로 업로드 됨',
        'data': responseData,
      };
    } else {
      return {
        'success': false,
        'message': '서버 오류 발생',
        'data': response.body,
      };
    }
  }
}
