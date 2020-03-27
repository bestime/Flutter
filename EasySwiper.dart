import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './setTimeout.dart';
import './YBorderRadiusBox.dart';

typedef IndexCallback = void Function (int index);

class EasySwiper extends StatefulWidget {
  final List<Widget> children;
  final bool showDot; // 是否显示小圆点
  final Color dotStaticColor; // 小圆点静态颜色
  final Color dotActiveColor; // 小圆点高亮颜色
  final IndexCallback onChange; // 切换后回调  
  
  
  EasySwiper({
    @required this.children,
    this.dotActiveColor,
    this.dotStaticColor,
    this.showDot = true,
    this.onChange
  });

  @override
  _EasySwiper createState () {
    return new _EasySwiper();
  } 
}

class _EasySwiper extends State<EasySwiper> {
  PageController _controller = new PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1
  );
  Timer _timer;
  double distence = 0.0;
  int currentPage = 0;
  bool directionInversion = false; // 是否往回播放
  int computedPage = 0;


  @override
  void initState () {
    super.initState();
    _controller.addListener(() {
      _timer?.cancel();
    });

    // autoPlay();
  }


  void moveOnce (int toPage) async {
    await _controller.animateToPage(
      toPage,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease
    );
  }

  void autoPlay () {
    if(directionInversion) {
      computedPage = currentPage - 1;
      if(computedPage < 0) {
        computedPage = 0;
      }
    } else {
      computedPage = currentPage + 1;
      if(computedPage > widget.children.length - 1) {
        computedPage = 0;
      }
    }

    _timer?.cancel();
    _timer = setTimeout((){
      moveOnce(computedPage);
    }, 1000);
  }

  void _onChange (int index) {
    setState(() {
      currentPage = index; 
    });       
    if(index == widget.children.length -1) {
      directionInversion = true;
    } else if(index==0) {
      directionInversion = false;
    }
    autoPlay();
    if(widget.onChange != null) {
      widget.onChange(index);
    }
  }

  

  @override
  Widget build (BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView(
          children: widget.children,
          controller: _controller,
          onPageChanged: _onChange,
        ),
        widget.showDot ? _Dots(widget, widget.children.length, currentPage) : Container()
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int total;
  final int index;
  final dynamic opt;
  _Dots(this.opt, this.total, this.index);
  
  

  
  
  @override
  Widget build (BuildContext context) {
    List<Widget> children = [];
    Color _dotStaticColor;
    Color _dotActiveColor;
    _dotStaticColor = opt.dotStaticColor ?? Color.fromRGBO(0, 0, 0, 0.2);
    _dotActiveColor = opt.dotActiveColor ?? Color.fromRGBO(0, 0, 0, 0.8);
    for(int a=0; a<total; a++) {
      children.add(Padding(
        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: YBorderRadiusBox(
          borderRadius: [10,10,10,10],
          child: Container(
            decoration: BoxDecoration(
              color: index == a ? _dotActiveColor : 
            _dotStaticColor),
            width: 20,
            height: 7
          ),
        ),
      ));
    }
    return Positioned(
      left: 0,
      right: 0,
      bottom: 5,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}