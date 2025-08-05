import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String statusMessage = "사진 저장하기";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    statusMessage,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _takePhoto,
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 50,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _takePhoto() async {
    setState(() {
      statusMessage = "카메라 준비중 ...";
    });

    try {
      // 갤러리 접근 권한 확인 요청
      if (await Gal.hasAccess() == false) {
        await Gal.requestAccess();
      }

      // 카메라에서 사진 촬영 요청
      // source - 사진 촬영
      // source - 갤러리에서 이미지 선택
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        print("저장 경로: ${image.path}");

        setState(() {
          statusMessage = "사진을 저장중...";
        });

        // 갤러리(사진첩에 촬영한 사진을 저장한다)
        await Gal.putImage(image.path);

        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            statusMessage = "사진 저장하기";
          });
        });
      }
    } catch (e) {
      print("오류 발생 $e");
      setState(() {
        statusMessage = "오류가 발생했습니다";
      });

      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          statusMessage = "사진 저장하기";
        });
      });
    }
  } // end of takePhoto
} // end of class
