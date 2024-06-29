import 'package:bocket_test/test_page.dart';
import 'package:flutter/material.dart';

class ImageFiles extends StatelessWidget {
  final List<String> _imageUrls = [
    'https://images.unsplash.com/photo-1532153955177-f59af40d6472?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzZ8fCVFQSVCMyVCNSVFQiVCNiU4MHxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1558021211-6d1403321394?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fCVFQSVCMyVCNSVFQiVCNiU4MHxlbnwwfHwwfHx8MA%3D%3D',
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
                  MaterialPageRoute(builder: (context)=>TestPage())
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
}//이미지 비율 조절 필요.
