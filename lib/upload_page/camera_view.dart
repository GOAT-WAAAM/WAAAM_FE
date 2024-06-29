import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  final ImagePicker picker = ImagePicker();

  XFile? _imageFile;//갤러리 이미지 저장

  CroppedFile? _croppedFile;//편집된 이미지 저장

  // get image
  Future<void> getImage(ImageSource imageSource) async {
    try {
      final XFile? imageFile = await picker.pickImage(source: imageSource);

      if (imageFile != null) {
        _imageFile = imageFile;
        cropImage();
      }
    } catch (e) {
      print("이미지 호출 에러 : $e");
    }
  }

  Future<void> cropImage() async {
    if (_imageFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _imageFile!.path, //이미지 경로
        compressFormat: ImageCompressFormat.jpg, //이미지 확장자
        compressQuality: 100,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: '자르기',
              toolbarColor: Color(0xFFBABFCA),
              toolbarWidgetColor: Colors.white,//글자색
              initAspectRatio:CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 100,
                child: _buildPhotoArea(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 카메라 선택 버튼
                  ElevatedButton(
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    child: const Text("카메라"),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  // 앨범 선택 버튼
                  ElevatedButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: const Text("앨범"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
//이미지 출력 위젯
  Widget _buildPhotoArea() {
    return _imageFile != null
        ? Center(
      child: Image.file(
        File(_croppedFile!.path),
      ),
    )
        : const Center(
      child: Text("불러온 이미지가 없습니다."),
    );
  }
}
