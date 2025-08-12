import 'dart:io';
import 'package:class_camera_v2/helpers/image_helper.dart';
import 'package:class_camera_v2/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _selectedImage;
  String statusMessage = "사진을 선택하거나 촬영하세요";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('카메라 앱'),
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
                                ),
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
                      onPressed: _isLoading ? null : _pickFromGallery,
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
                      onPressed: (_selectedImage != null && !_isLoading)
                          ? _saveFromGallery
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

  Future<void> _takePhoto() async {
    setState(() {
      _isLoading = false;
      statusMessage = AppStyles.cameraLoading;
    });
    final File? image = await ImageHelper.takePhoto();

    setState(() {
      _isLoading = false;
      if (image != null) {
        _selectedImage = image;
        statusMessage = "카메라로 사진 촬영 완료";
      } else {
        statusMessage = "사진 촬영이 취소";
      }
      _restMessageAfterDelay();
    });
  }

  Future<void> _pickFromGallery() async {
    setState(() {
      _isLoading = false;
      statusMessage = AppStyles.galleryLoading;
    });
    final File? image = await ImageHelper.pickFromGallery();

    setState(() {
      _isLoading = false;
      if (image != null) {
        _selectedImage = image;
        statusMessage = "갤러리에서 이미지 선택 완료";
      } else {
        statusMessage = "이미지 선택이 취소";
      }
      _restMessageAfterDelay();
    });
  }

  void _saveFromGallery() async {
    setState(() {
      _isLoading = false;
      statusMessage = AppStyles.saveLoading;
    });
    await ImageHelper.saveToGallery(_selectedImage!.path);

    _restMessageAfterDelay();
  }

  Future<void> _uploadToServer() async {
    // 방어적 코드
    if (_selectedImage == null) return;
    setState(() {
      _isLoading = true;
      statusMessage = '서버에 업로드 중...';
    });

    // Map<String, dynamic> 구조로 담아짐
    final result = await ImageHelper.uploadToServer(_selectedImage!);

    setState(() {
      _isLoading = false;
      if (result['success'] == true) {
        statusMessage = result['message'];
      } else {
        statusMessage = result['message'];
      }
      _restMessageAfterDelay();
    });
  }

  // 일정 시간 후 상태 메세지를 기본 값으로 돌리는 기능
  void _restMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      // mounted 는 Flutter 의 State 클래스에서 제공하는 bool 타입 변수이다.
      // 현재 위젯이 화면에 아직 존재하는(활성 상태)를 확인 하는 변수
      if (mounted) {
        setState(() {
          statusMessage = AppStyles.defaultMessage;
        });
      }
    });
  }
} // end of class
