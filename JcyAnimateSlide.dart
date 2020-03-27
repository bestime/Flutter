





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class JcyAnimateSlide extends StatefulWidget {
  final Widget child;
  final bool active; // 是否显示
  final int duration; // 动画时间（毫秒）
  final Curve curve; // 动画效果
  final String type; // 动画类型

  JcyAnimateSlide({
    @required this.child,
    @required this.active,
    this.type = 'scale',
    this.duration = 700,
    this.curve = Curves.easeOut
  });

  @override
  _JcyAnimateSlide createState () => new _JcyAnimateSlide();
}

class _JcyAnimateSlide extends State<JcyAnimateSlide> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<Offset> animation;
  Animation curve;

  @override
  void didUpdateWidget (oldWidget) {
    // print('变了 ${widget.active}');
    if(widget.active) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void initState () {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration
      )
    );
    
    
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    // controller.addStatusListener((status) {
      // if (status == AnimationStatus.completed) {
      //   controller.reverse();
      // } else if (status == AnimationStatus.dismissed) {
      //   controller.forward();
      // }
    // });

    curve =
    new CurvedAnimation(parent: controller, curve: widget.curve);
    animation = Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(curve);
  }


  @override
  Widget build (BuildContext context) {
    return SlideTransition(
      position: animation,
      child: widget.child,
    );
  }
}