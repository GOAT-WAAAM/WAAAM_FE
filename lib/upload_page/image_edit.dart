import 'dart:io';
import 'package:bocket_test/WriteContent/PreWrite.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('이미지 확인'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.file(_imageFile),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreWrite(),
                        ),
                      );
                    },
                    child: const Text("다음으로"),
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
