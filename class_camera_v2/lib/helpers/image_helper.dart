// 이미지 처리와 서버 업로드를 담당하는 헬퍼 클래스(비즈니스 클래스)
// 카메라 촬영, 갤러리 선택, 로컬 저장, 서버 업로드 기능 제공
import 'dart:convert';
import 'dart:io';

import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class ImageHelper {
  // new ImageHelper()
  static const String _baseUrl = 'http://192.168.0.132:8080';
  static const String _uploadEndpoint = '/api/images';

  // 카메라 사진 촬영
  static Future<File?> takePhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );

      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      print('카메라 촬영 오류 : $e');
      return null;
    }
  }

  // 갤러리에 이미지 선택
  static Future<File?> pickFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      print('갤러리 선택 오류 : $e');
      return null;
    }
  }

  // 로컬 갤러리에 이미지 저장 기능
  static Future<bool> saveToGallery(String imagePath) async {
    try {
      // 갤러리 접근 권한 여부 확인
      if (await Gal.hasAccess() == false) {
        await Gal.requestAccess();
      }

      await Gal.putImage(imagePath);
      return true;
    } catch (e) {
      print('갤러리 저장 중 오류 : $e');
      return false;
    }
  }

  // 서버로 이미지 업로드 (Base64 접두사 포함)
  static Future<Map<String, dynamic>> uploadToServer(File imageFile) async {
    try {
      // 1. 파일을 바이트 단위로 읽어준다.
      final List<int> bytes = await imageFile.readAsBytes();

      // 2. 바이트 데이터를 Base64로 인코딩 처리
      final String base64String = base64Encode(bytes);

      // 3. 파일 확장자로 이미지 MIME 타입을 설정
      String extension = path.extension(imageFile.path).toLowerCase();
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
      // 4. Base64 웹 표준 형식
      // 'data:image/png;base64,AFu...
      final String imageDataWithPrefix = 'data:$mimeType;base64,$base64String';

      // 5. fileName 준비 해야 함 (서버측 약속)
      final String fileName = path.basename(imageFile.path);

      // 6. 서버측 으로 보낼 데이터 형식 준비
      // data --> json 어떻게 만들어 던질까? Map 구조로 만들어서 처리 한다.
      final Map<String, dynamic> requestData = {
        'fileName': fileName,
        'imageData': imageDataWithPrefix
      };

      // 7. http post 통신 요청
      final http.Response response = await http.post(
        Uri.parse('$_baseUrl$_uploadEndpoint'),
        headers: <String, String>{
          'Content-type': 'application/json;charset=utf-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // 성공 시 응답 본문을 JSON을 Map 구조로 파싱 처리
        // response.body ---> 단순히 문자열 {"fileName", "a.png"}
        Map<String, dynamic> responseData = jsonDecode(response.body);
        // print(responseData['fileName']); --> fromMap(Map) --> object
        return <String, dynamic>{
          'success': true,
          'message': '이미지가 성공적으로 업로드 되었습니다',
          'data': responseData
        };
      } else {
        return <String, dynamic>{
          'success': false,
          'message': '서버 오류 ${response.statusCode}',
          'data': response.body
        };
      }
    } catch (e) {
      print('서버 업로드 오류 발생 : ${e}');
      return <String, dynamic>{
        'success': false,
        'message': '서버 오류',
        'data': e.toString()
      };
    }
  }

  // 서버에서 전체 이미지 리스트 조회 기능
  static Future<Map<String, dynamic>> getImageList() async {
    try {
      http.Response response = await http.get(
          Uri.parse('$_baseUrl$_uploadEndpoint'),
          headers: {'Content-Type': 'application/json;charset=utf-8'});
      if (response.statusCode == 200) {
        final List<dynamic> imageList = jsonDecode(response.body);
        return {
          'success': true,
          'data': imageList,
        };
      } else {
        return {
          'success': false,
          'message': '목록 조회 실패',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': '목록 조회 실패',
      };
    }
  }

  // 서버에 특정 한개 이미지 조회 기능
  static Future<Map<String, dynamic>> getImageDetail(int imageId) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$_baseUrl$_uploadEndpoint/$imageId'),
          headers: {'Content-Type': 'application/json;charset=utf-8'});

      if (response.statusCode == 200) {
        final imageData = jsonDecode(response.body);
        return {
          'success': true,
          'data': imageData,
        };
      } else {
        return {
          'success': false,
          'message': '목록 조회 실패',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': '목록 조회 실패',
      };
    }
  }
}
