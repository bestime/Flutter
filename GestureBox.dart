



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';






class GestureBox extends StatefulWidget {
  final Function onClick;
  final Function onPress;
  final Function onLeave;
  final Widget child;

  GestureBox({
    @required this.child,
    this.onClick,
    this.onPress,
    this.onLeave
  });
  
  @override
  _GestureBox createState () => new _GestureBox();
}

class _GestureBox extends State<GestureBox> {
  @override
  Widget build (BuildContext context) {
    return Listener(
      onPointerDown: (down) {
        print("onPointerDownEvent");
      },
      onPointerMove: (move) {
        print("onPointerMove");
      },
      onPointerUp: (up) {
        print("onPointerUp");
      },
      onPointerCancel: (cancle){
        print("onPointerCancel");
      },
      child: Center(
        child: Text(
          "test",
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}