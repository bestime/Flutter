import 'package:flutter/cupertino.dart';

/// 系统状态栏高度占位容器
class StatusBarPlaceholder extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    double _height = MediaQuery.of(context).padding.top;
    return Container(
      height: _height,
    );
  }
}