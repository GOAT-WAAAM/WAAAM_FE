import 'package:bocket_test/upload_page/wirte_ornot.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _image;

  @override
  void initState() {
    super.initState();
    _pickImage();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    } else {
      Navigator.pop(context); // Close the screen if no image was selected
    }
  }

  Future<void> uploadImage(File image) async {
    final uri = Uri.parse('YOUR_SERVER_URL'); // Replace with your server URL
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', image.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Image upload failed');
    }
  }

  void _navigateToNextPage() {
    if (_image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WriteOrnot(image: _image!), // Correctly pass the image
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Optional: Remove shadow for a cleaner look
        title: Center(
          child: Text(
            '사진 선택',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Pretendard',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _navigateToNextPage, // Call the navigation function
            child: Text(
              '다음',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Pretendard',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: _image != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(
              _image!,
            ),
            SizedBox(height: 20),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
