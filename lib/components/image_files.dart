import 'package:bocket_test/CurationPage/RandomCuration.dart';
import 'package:bocket_test/Notify/test_page.dart';
import 'package:flutter/material.dart';

class ImageFiles extends StatelessWidget {
  final List<String> _imageUrls = [
    'assets/image/KakaoTalk_Photo_2024-07-25-15-34-06 001.jpeg',
    'assets/image/KakaoTalk_Photo_2024-07-25-15-34-08 002.jpeg',
    'assets/image/KakaoTalk_Photo_2024-07-25-15-34-10 003.jpeg'
    //test용 이미지 삽입
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.sizeOf(context).width;
    final double imageWidth=screenWidth/2-25.5;
    return SizedBox(
      height: 400,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing:11,
            mainAxisSpacing: 11,
          ),
          itemCount: 2,
          itemBuilder: (context,index){
            double aspectRatio=index%2==0 ? 10/13 : 1/1;
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>RandomCuration())
                );
              },
              child: Container(
                width: imageWidth,
                child: AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Image.network(
                    _imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
