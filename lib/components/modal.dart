import 'package:flutter/material.dart';

class ModalComponent extends StatelessWidget {
  final VoidCallback cameraPage;
  final VoidCallback albumPage;
  final VoidCallback writePage;

  const ModalComponent({
    Key? key,
    required this.cameraPage,
    required this.albumPage,
    required this.writePage,
}) :super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 33,right: 33,top: 20,bottom: 20),
      child: Container(
        height: 156,
        width: 212,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('촬영하기'),
              onTap: cameraPage,
            ),
            ListTile(
              leading: Icon(Icons.add_photo_alternate_outlined),
              title: Text('앨범에서 불러오기'),
              onTap: albumPage,
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('직접 작성하기'),
              onTap: writePage,
            ),
          ],
        ),
      ),
    );
  }
}
