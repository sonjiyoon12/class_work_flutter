import 'dart:convert';

import 'package:class_camera_v2/helpers/image_helper.dart';
import 'package:class_camera_v2/styles/app_styles.dart';
import 'package:flutter/material.dart';

class ImageListScreen extends StatefulWidget {
  const ImageListScreen({super.key});

  @override
  State<ImageListScreen> createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  late Future<List<dynamic>> _imageListFuture;

  @override
  void initState() {
    super.initState();
    // 단 한번만 호출할 수 있도록 보장
    _imageListFuture = _fetchImageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('서버 이미지 목록'),
        backgroundColor: AppStyles.primaryColor,
        foregroundColor: Colors.white,
      ),
      //
      body: FutureBuilder<List<dynamic>>(
        future: _imageListFuture,
        builder: (context, snapshot) {
          // 1. 로딩 중 상태
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. 오류 발생 상태
          else if (snapshot.hasError) {
            return Center(
              child: Text(
                '데이터를 불러 오는데 실패',
                textAlign: TextAlign.center,
              ),
            );
          }
          // 3. 데이터가 없는 경우
          else if (snapshot.hasData == false || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('서버에 아직 저장된 이미지가 없습니다'),
            );
          }
          // 4. 데이터가 있는 경우
          else {
            final List<dynamic> imageList = snapshot.data!;
            return ListView.builder(
              itemCount: imageList.length, // 길이 만큼 반복
              itemBuilder: (context, index) {
                final image = imageList[index];
                return _buildImageList(image);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildImageList(dynamic image) {
    final id = image['id'] as int;
    final fileName = image['fileName'] as String;
    final base64String = image['imageData'] as String;
    // 'data:image/png;base64, 접두사 까지 넘어옴
    final cleanBase64 = base64String.split(',').last;
    final bytes = base64Decode(cleanBase64);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      elevation: 2,
      child: ListTile(
        leading: Image.memory(
          bytes,
          fit: BoxFit.contain,
        ),
        title: Text(fileName),
        onTap: () {
          // 상세보기 화면으로 이동 하는 처리
          // 화면 이동하면 추가적으로 통신 요청 한번 더 -> 왜?
          // 화면 이동시 데이터를 전달할 수 있다.
          Navigator.pushNamed(context, "/detail", arguments: id);
        },
      ),
    );
  }

  // 서버에서 이미지 목록 가져 오는 함수
  Future<List<dynamic>> _fetchImageList() async {
    final result = await ImageHelper.getImageList();
    if (result['success'] == true) {
      return result['data'] as List<dynamic>;
    } else {
      throw Exception(result['message']);
    }
  }
}
