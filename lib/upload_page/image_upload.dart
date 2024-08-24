import 'dart:io'; // 파일 작업을 위한 라이브러리
import 'package:bocket_test/WriteContent/PreWrite.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_edit.dart'; // ImageEdit 페이지 경로를 지정하세요.

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _pickImage(); // 페이지가 초기화되자마자 갤러리 열기
  }

  Future<void> _pickImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PreWrite())
      );
    } else {
      // 만약 사용자가 이미지를 선택하지 않았으면 이전 페이지로 돌아가거나 다른 작업을 수행할 수 있습니다.
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // 로딩 인디케이터를 페이지의 body에 표시
      ),
    );
  }
}
