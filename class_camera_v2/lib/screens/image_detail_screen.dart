import 'dart:convert';

import 'package:class_camera_v2/helpers/image_helper.dart';
import 'package:flutter/material.dart';

class ImageDetailScreen extends StatefulWidget {
  const ImageDetailScreen({super.key});

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  late Future<dynamic> _imageDetailFuture;
  int? _imageId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _imageId = ModalRoute.of(context)?.settings.arguments as int?;
    print("imageId : $_imageId");
    // id 값이 있어야 통신 호출 가능 하다.
    if (_imageId != null) {
      _imageDetailFuture = ImageHelper.getImageDetail(_imageId!);
    }
  }

  // 리스트에서 넘겨준 데이터를 받는 코드를 작성하고 즉, id 값으로
  // 다시 http.get 요청으로 상세보기 데이터를 받아서 화면을 그려 주면 된다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 상세보기'),
      ),
      body: FutureBuilder(
        future: _imageDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("이미지를 불러오는데 실패"));
          } else {
            // 서버에서 넘어온 base64 다루는 방법
            final imageData = snapshot.data!['data'];
            // Map<String, int> test = {"a": 1, "b": 2};
            // int? a = test["ac"];
            final String base64String = imageData['imageData'];
            // 접두사 제거
            final cleanBase64 = base64String.split(',').last;
            final bytes = base64Decode(cleanBase64);

            return Container(
              child: Image.memory(bytes, fit: BoxFit.cover),
            );
          }
        },
      ),
    );
  }
}
