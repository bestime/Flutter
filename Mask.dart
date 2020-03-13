import 'package:flutter/material.dart';

class Mask extends StatelessWidget {
  @override
  static show () {
    print('开始');
  }
  Widget build(BuildContext context) {

    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Text('ABC的地方呢喀什觉得开发'),
    );
  }
}