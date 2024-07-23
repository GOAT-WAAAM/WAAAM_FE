import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'wirte_ornot.dart';

class ImageEdit extends StatefulWidget {
  final File imageFile;

  const ImageEdit({Key? key, required this.imageFile}) : super(key: key);

  @override
  _ImageEditState createState() => _ImageEditState();
}

class _ImageEditState extends State<ImageEdit> {
  late File _imageFile;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
  }

  Future<void> _cropImage(CropAspectRatioPreset aspectRatio) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '자르기',
          toolbarColor: Colors.white,
          toolbarWidgetColor: Colors.white,
        )
      ],
      aspectRatioPresets: [aspectRatio],
    );
    if (croppedFile != null) {
      setState(() {
        _imageFile = File(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333333),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(54),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 17),
              child: Text(
                '자르기',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // 이미지 표시
          Padding(
            padding: const EdgeInsets.only(top: 29, right: 33, left: 33),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6, // 최대 높이를 화면 높이의 60%로 설정
              ),
              child: Center(
                child: _imageFile.existsSync()
                    ? Image.file(
                  _imageFile,
                  fit: BoxFit.contain, // 이미지가 컨테이너에 맞게 비율을 유지하며 조정됨
                )
                    : const Text('Error: Image file does not exist.'),
              ),
            ),
          ),
          SizedBox(height: 20),
          // 비율 버튼 영역
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _cropImage(CropAspectRatioPreset.ratio4x3);
                },
                child: const Text(
                  '4:3',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(37, 23),
                  backgroundColor: Colors.black,
                  side: BorderSide(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(width: 19),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(37, 23),
                  backgroundColor: Color(0xFF333333),
                  side: BorderSide(color: Colors.white),
                ),
                onPressed: () {
                  _cropImage(CropAspectRatioPreset.square); // 정방형 비율에서 크롭
                },
                child: const Text(
                  '정방형',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Spacer(), // Spacer를 사용하여 비율 버튼과 하단 버튼을 분리
          // 하단 버튼 영역
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 다시 찍기 버튼 동작
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '다시 찍기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF333333)),
                    elevation: 0,
                    backgroundColor: Color(0xFF333333), // 버튼 색상
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 다음 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WriteOrnot(
                          image: _imageFile,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    '다음',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF02B6B4),
                    minimumSize: Size(113, 35),
                    side: BorderSide(
                      color: Color(0xFF02B6B4),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
