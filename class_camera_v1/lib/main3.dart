import 'dart:convert';
import 'dart:io';

import 'package:class_camera_v1/helper/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
// path 패키지는 파일 경로를 다루는 유틸리티 패키지 입니다.

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 변수 - 기본 값 소문자, 참조 (주소 값) - 대문자
  File? _selectedImage;
  String statusMessage = " 사진을 선택하거나 촬영하세요";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("카메라 앱"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.grey[300],
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  statusMessage,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "이미지가 없습니다",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 12.0,
                  runSpacing: 8.0,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _takePhoto,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('카메라'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _pickImageFromGallery,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('갤러리'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      // _isLoading
                      onPressed: (_selectedImage != null && !_isLoading)
                          ? _saveImageToGallery
                          : null,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('저장'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      // _isLoading
                      onPressed: (_selectedImage != null && !_isLoading)
                          ? _uploadToServer
                          : null,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('서버로 전송'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 카메라로 사진 촬영
  void _takePhoto() async {
    setState(() {
      _isLoading = true;
      statusMessage = "카메라를 준비중...";
    });

    try {
      // 갤러리 접근 권한 확인 요청
      if (await Gal.hasAccess() == false) {
        Gal.requestAccess();
      }

      // 권한이 있다면 카메라에서 사진 촬영 요청
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          statusMessage = "카메라로 사진 촬영을 했습니다";
          _isLoading = false;
          _selectedImage = new File(image.path);
          print("촬영된 사진 임시 경로 : ${image.path}");
        });
      } else {
        setState(() {
          statusMessage = "사진 촬영이 취소되었습니다";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        statusMessage = "카메라 사용중 오류가 발생했습니다";
        _isLoading = false;
        print("카메라 오류 발생 : ${e}");
      });
    }
  }

  // 갤러리에서 이미지 선택
  void _pickImageFromGallery() async {
    setState(() {
      _isLoading = true;
      statusMessage = "갤러리 여는 중...";
    });

    try {
      // 갤러리 접근 권한 확인 요청
      if (await Gal.hasAccess() == false) {
        await Gal.requestAccess();
      }

      // gallery 갤러리에 접근 요청
      XFile? pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
          statusMessage = "갤러리에서 이미지를 선택했습니다";
          _isLoading = false;
        });
      } else {
        setState(() {
          statusMessage = "이미지 선택이 취소되었습니다";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        statusMessage = "갤러리 접근중 오류 발생";
        _isLoading = false;
      });
      print("갤러리 열기 오류 확인 : ${e}");
    }
  }

  void _saveImageToGallery() async {
    if (_selectedImage == null) return;
    setState(() {
      _isLoading = true;
      statusMessage = "이미지를 갤러리에 저장중...";
    });

    try {
      // 갤러리 접근 권한 확인 요청
      if (await Gal.hasAccess() == false) {
        await Gal.requestAccess();
      }

      // 갤러리에 저장
      Gal.putImage(_selectedImage!.path);
      setState(() {
        _isLoading = false;
        statusMessage = "갤러리에 저장 완료";
      });

      // 3초 후에 원래 메세지로 복원
      Future.delayed(const Duration(seconds: 3), () {
        // 위젯이 여전히 마운트되어 있는지 확인
        if (mounted) {
          // 이 속성은 위젯 트리에 여전히 연결이 되어 있는지 확인
          // 이유는 dispose 호출 된 이후에 개발자가
          // setState() 메서드 호출하면 오류 발생함
          setState(() {
            statusMessage = "사진을 선택하거나 촬영하세요";
          });
        }
      });
    } catch (e) {
      setState(() {
        statusMessage = "이미지 저장중 오류 발생";
        _isLoading = false;
      });
    }
  }

  // 서버로 이미지 전송
  Future<void> _uploadToServer() async {
    // 방어적 코드 작성
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
      statusMessage = '서버로 업로드 중 ...';
    });

    // 서버측으로 통신하는 코드
    final result = ImageHelper.uploadToServer(_selectedImage!);

    setState(() {
      _isLoading = false;
      statusMessage = '사진 업로드 완료 ...';
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 자원 연결 해제 코드 일반적으로 작성해 준다.
  }
} //end of class
