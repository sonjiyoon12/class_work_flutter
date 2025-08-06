import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          ? () {}
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
}
