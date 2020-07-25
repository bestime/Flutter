import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './tool/ColorTool.dart';
import './sleep.dart';

final Color _defaultBackgroundColor = ColorTool.transparent;


// 无缝滚动 支持（上、下、左、右）
// 尺寸小于一屏不滚动
// 大于一屏补齐两屏
// 按下状态会停止滚动

class InfiniteScroll extends StatefulWidget {
  final Axis direction; // 滚动方向
  final Widget child; // 滚动内容
  final double size; // 横向滚动表示高度 垂直滚动表示宽度
  final int period; // 滚动周期，多久滚动一次单位（毫秒）
  final double speed; // 滚动速度，每(周期 period)位移值
  final bool reverse; // 反向滚动
  final String maskLeft; // 左侧渐变蒙版，十六进制颜色 例：（#000000）
  final String maskRight; // 右侧渐变蒙版，十六进制颜色 例：（#000000）
  final Color backgroundColor; // 容器背景色

  InfiniteScroll({
    @required this.child,
    @required this.size,
    this.speed = 100,
    this.period = 1000,
    this.reverse = false,
    this.direction = Axis.horizontal,
    this.maskLeft,
    this.maskRight,
    this.backgroundColor
  });
  
  @override
  _InfiniteScroll createState () {
    return new _InfiniteScroll();
  }
}

class _InfiniteScroll extends State<InfiniteScroll> {
  ScrollController _scrollController = new ScrollController(); // 滚动控制器
  double position = 0; // 当前滚动位置
  double wrapperSize = 0; // 父容器宽度
  double maxScrollSize = 0; // 最大滚动宽度
  double _itemSize = 0; // 滚动子容器长度
  List<Widget> childList = []; // 如果达到滚动条件，需要复制一个进行无缝滚动
  double _partSize;
  double _duration;
  final GlobalKey globalKey = GlobalKey();
  bool _lock = false; // 暂时禁用滚动，用于按下时停止不能动
  bool _scrolling = false;

  void _startScroll () async {
    await sleep(30);
    _scrollOnce();
  }

  // 水平滚动
  void _scrollOnce () async {
    if(_lock || _scrolling) return null;
    _scrolling = true;
    try {
      maxScrollSize = _scrollController.position.maxScrollExtent;
    } catch (e) {
      return null;
    }

    if(wrapperSize==0 || maxScrollSize <= 0) return null;
    
    if(_itemSize==0) {
      _itemSize = maxScrollSize;
    }

    if(childList.length != 2) {
      setState(() {
        childList = [
          _ScrollItem(widget.child),
          _ScrollItem(widget.child),
        ];
      });
    }

    position = _scrollController.position.pixels;
    _partSize = _itemSize + wrapperSize;
    if(position == _partSize) {
      _scrollController.jumpTo(0);
      _scrolling = false;
      _scrollOnce(); 
    } else {
      _duration = widget.period * 1.0;
      if(position + widget.speed > _partSize) {          
        _duration = (_partSize - position) * _duration / widget.speed;
        position = _partSize;   
        if(_duration < 30) {
          _duration = 30;
        }
      } else {        
        position = position + widget.speed;  
      }
      _scrollController.animateTo(
        position,
        duration: new Duration(milliseconds: _duration.toInt()),
        curve: Curves.linear
      ).then((ad) {
        _scrolling = false;
        _scrollOnce(); 
      });
    }
  }
  

  @override
  Widget build (BuildContext context) {
    if(wrapperSize==0) {
      if(widget.direction == Axis.vertical) {
        wrapperSize = widget.size;
        _startScroll();
      } else {
        // 获取widget尺寸
        WidgetsBinding.instance.addPostFrameCallback((d){
          wrapperSize = context.size.width;
          _startScroll();
        });
      }
    }
    
    return Listener(
      onPointerDown: (ev) {
        _lock = true;
      },
      onPointerUp: (ev) {
        _lock = false;
        _scrollOnce();
      },
      child: Container(
        margin: EdgeInsets.all(0), // 如果要设置margin。请在外面布局。     
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? _defaultBackgroundColor
        ),
        child: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.all(0),
              dragStartBehavior: DragStartBehavior.down,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              reverse: widget.reverse,
              controller: _scrollController,
              scrollDirection: widget.direction,
              children: childList.length == 2
                ? childList 
                : [_ScrollItem(widget.child)],
            ),
            widget.maskLeft==null ? Container() : _getMaskSlide('left', widget.maskLeft),
            widget.maskRight==null ? Container() : _getMaskSlide('right', widget.maskRight),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _ScrollItem extends StatelessWidget {
  final Widget child;
  _ScrollItem(this.child);
  @override
  Widget build (BuildContext context) {
    return Center(child: child);
  }
}

Widget _getMaskSlide (String direction, String color) {
  LinearGradient jianbian;
  switch(direction) {
    case 'left': 
      jianbian = LinearGradient(
        colors: [ColorTool.hex(color), ColorTool.hex(color, 0)]
      );
      break;
    case 'right':
      jianbian = LinearGradient(
        colors: [ ColorTool.hex(color, 0),  ColorTool.hex(color, 1)]
      );
      break;
  }
  return Positioned(
    left: direction == 'left' ? 0 : null,
    right: direction == 'right' ? 0 : null,
    top: 0,
    bottom: 0,
    child: Container(
      width: 15,
      decoration: BoxDecoration(
        gradient: jianbian
      ),
    ),
  );
}