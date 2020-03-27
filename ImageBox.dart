



import 'package:flutter/material.dart';





class ImageBox extends StatelessWidget {
  final bool netWork = true;
  final String src; // 图片地址
  final List<double> borderRadius; // 圆角
  final List<double> margin;
  final double width;
  final double height;

  ImageBox({
    @required this.src,
    this.borderRadius = const [0, 0, 0, 0],
    this.width,
    this.height,
    this.margin = const [0, 0, 0, 0]
  });

  @override
  Widget build (BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(this.margin[3], this.margin[0], this.margin[1], this.margin[2]),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(this.borderRadius[0]),
          topRight: Radius.circular(this.borderRadius[1]), 
          bottomRight: Radius.circular(this.borderRadius[2]),
          bottomLeft: Radius.circular(this.borderRadius[3]),
        ),
        child: FadeInImage.assetNetwork(
          placeholder: this.src,
          image: this.src,
          fit: BoxFit.fill,
          width: this.width!=null ? this.width : size.width,
          height: this.height
        ),
      ),
    );
  }
}