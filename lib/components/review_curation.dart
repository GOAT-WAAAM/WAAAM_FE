import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class RandomImageBox extends StatefulWidget {
  @override
  State<RandomImageBox> createState() => _RandomImageBoxState();
}

class _RandomImageBoxState extends State<RandomImageBox> {
  final List<String> _imageUrls=[
    'https://images.unsplash.com/photo-1495465798138-718f86d1a4bc?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1664110691129-ca0f4fbe8533?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
  ];//Test용 주소 나중에 백엔드에서 받아와야함.
  String? _currentImageUrl;
  Timer? _timer;
  final Random _random=Random();

  @override
  void initState(){
    super.initState();
    _currentImageUrl=_imageUrls[_random.nextInt(_imageUrls.length)];
    _startImageChangeTimer();
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }

  void _startImageChangeTimer(){
    _timer=Timer.periodic(Duration(seconds: 3),(timer){
      setState(() {
        _currentImageUrl=_imageUrls[_random.nextInt(_imageUrls.length)];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*1.0,
      height: MediaQuery.of(context).size.width*0.44,
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(12),
      ),
      child: _currentImageUrl==null?CircularProgressIndicator()
      :ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          _currentImageUrl!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


