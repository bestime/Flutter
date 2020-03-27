import 'package:flutter/cupertino.dart';

class YBorderRadiusBox extends StatelessWidget {
  final Widget child;
  final List<double> borderRadius;
  YBorderRadiusBox({
    @required this.child,
    this.borderRadius = const [0,0,0,0]
  });
  @override
  Widget build (BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
      topLeft: Radius.circular(this.borderRadius[0]),
      topRight: Radius.circular(this.borderRadius[1]), 
      bottomRight: Radius.circular(this.borderRadius[2]),
      bottomLeft: Radius.circular(this.borderRadius[3]),
    ),
      child: this.child,
    );
  }
}