import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageEdit extends StatefulWidget {
  final File imageFile;
  const ImageEdit({Key? key, required this.imageFile}) : super(key: key);

  @override
  _ImageEditState createState() => _ImageEditState();
}

class _ImageEditState extends State<ImageEdit> {
  late File _imageFile;
  CroppedFile? _croppedFile;
  CropAspectRatioPreset _currentAspectRatio = CropAspectRatioPreset.original;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
  }

  Future<void> cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _imageFile.path,
      aspectRatioPresets: [_currentAspectRatio],
      compressFormat: ImageCompressFormat.png,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '자르기',
          toolbarColor: Colors.white,
          toolbarWidgetColor: Colors.black,
          initAspectRatio: _currentAspectRatio,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: '자르기',
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _croppedFile = croppedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('이미지 자르기'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                if (_croppedFile != null) {
                  Navigator.pop(context, File(_croppedFile!.path));
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: _croppedFile != null
                    ? Image.file(File(_croppedFile!.path))
                    : Image.file(_imageFile),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentAspectRatio = CropAspectRatioPreset.square;
                      });
                      cropImage();
                    },
                    child: const Text("정방형 (1:1)"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentAspectRatio = CropAspectRatioPreset.ratio4x3;
                      });
                      cropImage();
                    },
                    child: const Text("4:3"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentAspectRatio = CropAspectRatioPreset.ratio16x9;
                      });
                      cropImage();
                    },
                    child: const Text("16:9"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'wirte_ornot.dart';
//
// class ImageEdit extends StatefulWidget {
//   final File imageFile;
//
//   const ImageEdit({Key? key, required this.imageFile}) : super(key: key);
//
//   @override
//   _ImageEditState createState() => _ImageEditState();
// }
//
// class _ImageEditState extends State<ImageEdit> {
//   late File _imageFile;
//   CropAspectRatioPreset _currentAspectRatio = CropAspectRatioPreset.original;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.imageFile.existsSync()) {
//       _imageFile = widget.imageFile;
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('이미지 파일이 존재하지 않습니다.')),
//       );
//       Navigator.pop(context); // Navigate back if file is invalid
//     }
//   }
//
//   Future<void> _cropImage(CropAspectRatioPreset aspectRatio) async {
//     try {
//       final croppedFile = await ImageCropper().cropImage(
//         sourcePath: _imageFile.path,
//         aspectRatioPresets: [aspectRatio],
//         uiSettings: [
//           AndroidUiSettings(
//             toolbarTitle: '자르기',
//             toolbarColor: Colors.white,
//             toolbarWidgetColor: Colors.black,
//             hideBottomControls: true,
//             initAspectRatio: aspectRatio,
//             lockAspectRatio: false,
//           ),
//           IOSUiSettings(
//             minimumAspectRatio: 1.0,
//             title: '자르기',
//           ),
//         ],
//       );
//
//       if (croppedFile != null) {
//         setState(() {
//           _imageFile = File(croppedFile.path);
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('크롭이 실패했습니다.')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('오류가 발생했습니다: $e')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF333333),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(54),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           title: const Center(
//             child: Padding(
//               padding: EdgeInsets.only(top: 17),
//               child: Text(
//                 '자르기',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Pretendard',
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//           backgroundColor: Colors.white,
//           elevation: 0,
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 29, right: 33, left: 33),
//             child: Container(
//               constraints: BoxConstraints(
//                 maxHeight: MediaQuery.of(context).size.height * 0.6,
//               ),
//               child: Center(
//                 child: _imageFile.existsSync()
//                     ? Image.file(
//                   _imageFile,
//                   fit: BoxFit.contain,
//                 )
//                     : const Text('Error: Image file does not exist.'),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _currentAspectRatio = CropAspectRatioPreset.ratio4x3;
//                   });
//                   _cropImage(CropAspectRatioPreset.ratio4x3);
//                 },
//                 child: const Text(
//                   '4:3',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Pretendard',
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(37, 23),
//                   backgroundColor: Colors.black,
//                   side: const BorderSide(color: Colors.white),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 19),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(37, 23),
//                   backgroundColor: const Color(0xFF333333),
//                   side: const BorderSide(color: Colors.white),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _currentAspectRatio = CropAspectRatioPreset.square;
//                   });
//                   _cropImage(CropAspectRatioPreset.square);
//                 },
//                 child: const Text(
//                   '정방형',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Pretendard',
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.only(right: 20, left: 20, bottom: 28),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text(
//                     '다시 찍기',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       fontFamily: 'Pretendard',
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     side: const BorderSide(color: Color(0xFF333333)),
//                     elevation: 0,
//                     backgroundColor: const Color(0xFF333333),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => WriteOrnot(
//                           image: _imageFile,
//                         ),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     '다음',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       fontFamily: 'Pretendard',
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF02B6B4),
//                     minimumSize: const Size(113, 35),
//                     side: const BorderSide(
//                       color: Color(0xFF02B6B4),
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
