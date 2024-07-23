import 'dart:io';
import 'package:bocket_test/upload_page/image_edit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Get the list of available cameras
      _cameras = await availableCameras();

      // Initialize the camera controller
      _controller = CameraController(
        _cameras[0],
        ResolutionPreset.high,
      );

      // Initialize the camera controller
      await _controller.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print("Error initializing camera: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error initializing camera: $e")),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    // 촬영 중인지 확인
    if (!_controller.value.isTakingPicture) {
      try {
        // 사진 찍기
        final XFile photo = await _controller.takePicture();

        // 찍은 사진을 ImageEdit 페이지로 넘기기
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageEdit(imageFile: File(photo.path)),
          ),
        );
      } catch (e) {
        // 에러 처리
        print("Error taking picture: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("사진 촬영 중 오류가 발생했습니다."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // 이미 사진을 찍고 있는 경우 사용자에게 알림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("사진 촬영 중입니다. 잠시 후 시도해 주세요."),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(54),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Padding(
            padding: const EdgeInsets.only(top: 17),
            child: const Text('촬영하기',style: TextStyle(color: Colors.black,fontFamily: 'Pretendard',fontWeight: FontWeight.w600,fontSize: 18),),
          )),
          backgroundColor: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CameraPreview(_controller),
            ),
            ElevatedButton(
              onPressed: _takePicture,
              child: const Icon(Icons.photo_camera, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
