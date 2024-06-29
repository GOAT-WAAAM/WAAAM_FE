import 'package:flutter/material.dart';
import '../components/image_files.dart';
import '../components/review_curation.dart';

class MainPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '뭘 복습할지 모르겠다면?',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111111),
              ),
            ),
            SizedBox(height: 20),
            RandomImageBox(),
            SizedBox(height: 49),
            Text(
              '최근 이미지',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111111),
              ),
            ),
            SizedBox(height: 22),
            ImageFiles(),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../components/image_files.dart';
// import '../components/review_curation.dart';
//
// class MainPageContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '뭘 복습할지 모르겠다면?',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontStyle: FontStyle.normal,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF111111),
//               ),
//             ),
//             SizedBox(height: 20),
//             RandomImageBox(),
//             SizedBox(height: 49),
//             Text(
//               '최근 이미지',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontStyle: FontStyle.normal,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF111111),
//               ),
//             ),
//             SizedBox(height: 22),
//             ImageFiles(),
//           ],
//         ),
//       ),
//     );
//   }
// }