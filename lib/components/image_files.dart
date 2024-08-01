import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bocket_test/Notify/notify_page.dart';
import 'package:provider/provider.dart';
import 'package:bocket_test/Provider/token_provider.dart';

class ImageFiles extends StatefulWidget {
  @override
  _ImageFilesState createState() => _ImageFilesState();
}

class _ImageFilesState extends State<ImageFiles> {
  List<HomeResponseItem> _images = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    const String url = 'http://43.202.27.170/goat/home';
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    final accessToken = tokenProvider.accessToken;

    if (accessToken == null) {
      print('Access token is missing');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final homeResponse = HomeResponse.fromJson(data);
        setState(() {
          _images = homeResponse.results.homeResponseList;
          _isLoading = false;
        });
      } else {
        print('Failed to load images: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageWidth = screenWidth / 2 - 25.5;

    return SizedBox(
      height: 400,
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 11,
          mainAxisSpacing: 11,
        ),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          final image = _images[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotifyPage()),
              );
            },
            child: Container(
              width: imageWidth,
              child: AspectRatio(
                aspectRatio: 1, // 비율을 1로 설정하여 원본 비율 유지
                child: Image.network(
                  image.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeResponse {
  final bool isSuccess;
  final String code;
  final String message;
  final Results results;

  HomeResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.results,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
      results: Results.fromJson(json['results']),
    );
  }
}

class Results {
  final List<HomeResponseItem> homeResponseList;

  Results({
    required this.homeResponseList,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    var list = json['homeResponseList'] as List;
    List<HomeResponseItem> homeResponseList = list.map((i) => HomeResponseItem.fromJson(i)).toList();
    return Results(homeResponseList: homeResponseList);
  }
}

class HomeResponseItem {
  final int reviewId;
  final String imageUrl;

  HomeResponseItem({
    required this.reviewId,
    required this.imageUrl,
  });

  factory HomeResponseItem.fromJson(Map<String, dynamic> json) {
    return HomeResponseItem(
      reviewId: json['reviewId'],
      imageUrl: json['imageUrl'],
    );
  }
}
