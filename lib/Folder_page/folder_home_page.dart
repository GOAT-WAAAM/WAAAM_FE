import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../CurationPage/RandomCuration.dart';
import '../components/add_subject_popup.dart';

class FolderMainPage extends StatefulWidget {
  @override
  State<FolderMainPage> createState() => _FolderState();
}

class _FolderState extends State<FolderMainPage> {
  List<String> classes = ["경영과학", "중급회계", "공급사슬관리", "보험과 리스크"];
  void _addClass(String newClass) {
    setState(() {
      classes.add(newClass);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 214,
          height: 30,
          decoration: BoxDecoration(
              color: Color(0xFFEEEEEF), borderRadius: BorderRadius.circular(12)),
          child: TextField(
            decoration: InputDecoration(
              hintText: '복습내용 검색하기',
              hintStyle: TextStyle(
                  color: Color(0xFFBABFCA),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
              prefixIcon: Icon(
                Icons.search,
                size: 24,
                color: Color(0xFFA2A9B5),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 즐겨찾기 Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('즐겨찾기',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('더보기',
                    style: TextStyle(color: Color(0xFFA2A9B5), fontSize: 14)),
              ],
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(4, (index) {
                  return FavoriteItem();
                }),
              ),
            ),
            SizedBox(height: 32),
            // 전체 과목 Section
            Expanded(
              child: ListView(
                children: [
                  Text('전체 과목',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  ...classes.map((cls) => CustomListTile(title: cls, onTap: () {
                    if (cls == "경영과학") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ManagementScienceScreen()),
                      );
                    }
                  })).toList(),
                  NewClass(onAddClass: _addClass),
                  ReviewBox(),
                  TrashBin(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteItem extends StatefulWidget {
  const FavoriteItem({super.key});

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: Offset(0, 4),
            blurRadius: 9.1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 75 / 148,
              child: Image.asset(
                'assets/image/FolderIMG.png',
                width: 148,
                height: 148,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 148,
            height: 73,
            margin: EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('디지털 마케팅 이론',
                    style:
                    TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    Text(
                      '1강 IMC',
                      style: TextStyle(
                          fontSize: 12.6, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/image/favorite.png',
                      width: 28,
                      height: 28,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatefulWidget {
  final String? title;
  final VoidCallback? onTap;

  const CustomListTile({Key? key, this.title, this.onTap}) : super(key: key);

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 335,
        height: 51,
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xffF7F7F7), width: 1),
        ),
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Image.asset('assets/image/subject.png', width: 26, height: 26),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "${widget.title ?? ''}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}


class ReviewBox extends StatefulWidget {
  const ReviewBox({super.key});

  @override
  State<ReviewBox> createState() => _ReviewBoxState();
}

class _ReviewBoxState extends State<ReviewBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 51,
      decoration: BoxDecoration(
          color: Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(8), border: Border.all(color: Color(0xffF7F7F7),width: 1 )
      ),
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text("복습창고",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class TrashBin extends StatefulWidget {
  const TrashBin({super.key});

  @override
  State<TrashBin> createState() => _TrashBinState();
}

class _TrashBinState extends State<TrashBin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 51,
      decoration: BoxDecoration(
          color: Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(8), border: Border.all(color: Color(0xffF7F7F7),width: 1 )
      ),
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SvgPicture.asset('assets/svg/trash_bin.svg'),
          SizedBox(width: 8),
          Expanded(
            child: Text("휴지통",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class NewClass extends StatefulWidget {
  final Function(String) onAddClass;
  const NewClass({super.key, required this.onAddClass});

  @override
  State<NewClass> createState() => _NewClassState();
}

class _NewClassState extends State<NewClass> {
  void _showAddClassDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSubjectPopup(
          onAddClass: widget.onAddClass,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showAddClassDialog,
      child: Container(
        width: 335,
        height: 51,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), border: Border.all(color: Color(0xFFD5D8DD), width: 1,)
        ),
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            SvgPicture.asset('assets/svg/plus.svg'),
            SizedBox(width: 8),
            Expanded(
              child: Text("새 과목", style: TextStyle(color: Color(0xFFD5D8DD), fontSize: 16, fontWeight: FontWeight.w500)),),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class ManagementScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('경영과학'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options button press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FolderMainPage()),
                  );
                },
                child: Text('최근 복습순'),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  if (index < 3) {
                    return NoteCard();
                  } else {
                    return FolderCard();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RandomCuration()),
              );
            },
            child: Container(
              height: 140, // 이미지 컨테이너 높이 설정
              child: Image.asset(
                'assets/image/KakaoTalk_Photo_2024-07-25-15-34-13 005.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('0424 필기\n12회 복습'),
          ),
        ],
      ),
    );
  }
}

class FolderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder,
            size: 100,
            color: Colors.blue,
          ),
          SizedBox(height: 8.0),
          Text('새 폴더명'),
        ],
      ),
    );
  }
}
