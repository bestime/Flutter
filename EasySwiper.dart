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
  final bool autoPlay; // 是否自动轮播
  final int autoPlayFrequency; // 自动轮播频率（毫秒）
  final int autoPlayDuration; // 自动轮播过渡时间（毫秒）
  final Curve curve; // 过渡动画效果
  final double scale; // 缩放 （0-1）

  
  
  EasySwiper({
    @required this.children,
    this.dotActiveColor,
    this.dotStaticColor,
    this.showDot = true,
    this.onChange,
    this.autoPlay = true,
    this.autoPlayFrequency = 2000,
    this.autoPlayDuration = 700,
    this.curve = Curves.ease,
    this.scale = 1.0
  });

  @override
  _EasySwiper createState () {
    return new _EasySwiper();
  } 
}

class _EasySwiper extends State<EasySwiper> {
  PageController _controller;
  Timer _timer;
  double distence = 0.0;
  int currentPage = 0;
  bool directionInversion = false; // 是否往回播放
  int computedPage = 0;
  bool _autoScrolled = false;// 是否已经开始自动轮播，初始化的时候没有数据，导致不触发changed从而自动轮播失效


  @override
  void initState () {
    super.initState();
    _controller = new PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: widget.scale
    );
  }


  void moveOnce (int toPage) async {
    await _controller.animateToPage(
      toPage,
      duration: Duration(milliseconds: widget.autoPlayDuration),
      curve: widget.curve
    );
  }

  void comminAutoPlay () {
    if(!widget.autoPlay) return null;
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
    }, widget.autoPlayFrequency);
  }

  void _onChange (int index) async {
    if(index==0) {
      directionInversion = false;
    } else if(index < currentPage || index == widget.children.length -1) {
      directionInversion = true;
    } 
    setState(() {
      currentPage = index; 
    });
    comminAutoPlay();    
    if(widget.onChange != null) {
      widget.onChange(index);
    }
  }
  

  @override
  Widget build (BuildContext context) {
    if(!_autoScrolled && widget.children.length > 0) {
      _autoScrolled = true;
      comminAutoPlay();
    }
    return Listener(
      onPointerDown: (ev) {
        _timer?.cancel();
      },
      onPointerUp: (ev) {
        comminAutoPlay();
      },
      child: Stack(
        children: <Widget>[
          PageView(
            children: widget.children,
            controller: _controller,
            onPageChanged: _onChange,
          ),
          widget.showDot ? _Dots(widget, widget.children.length, currentPage) : Container()
        ],
      ),
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
            width: 10,
            height: 2
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