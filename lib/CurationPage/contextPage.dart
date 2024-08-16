import "package:flutter/material.dart";

import "../components/QuitPopup.dart";
import "Review.dart";

class contextPage extends StatefulWidget {
  final String? context;

  const contextPage({this.context});

  @override
  State<contextPage> createState() => _contextPageState();
}

class _contextPageState extends State<contextPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Review()),
          );},icon: Image.asset("assets/image/left_chev.png"),),
          title: Text("1. IMC 정의"),
        ),
        body:
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 43, 20, 20),
                child:
                  Column(
                    children: [
                      Text(
                        "${widget.context}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 126,
                        height: 60,
                        child: TextButton(
                          onPressed: () { showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomQuitPopup();
                          },
                        );},
                          style:
                          ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFFFF5050)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                            child:
                          Text("복습 그만하기", style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),),
                      )
                    ],
                  )
            ),
          ),
      ),
    );
  }
}
