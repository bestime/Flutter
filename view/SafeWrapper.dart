

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 自动撑开顶部导航栏的容器
class SafeWrapper extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  

  
  const SafeWrapper({
    @required this.child,
    this.backgroundColor = Colors.white
  });

  

  @override
  Widget build (BuildContext context) {
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // 
      child: Container(
        decoration: BoxDecoration(
          color: this.backgroundColor
        ),
        padding: EdgeInsets.fromLTRB(0, _statusBarHeight, 0, 0),
        child: this.child,
      ),
    );
  }
}