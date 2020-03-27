



import 'package:flutter/cupertino.dart';
import './tool/ColorTool.dart';
import './YBorderRadiusBox.dart';





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
  bool _isDown = false;
  @override
  Widget build (BuildContext context) {
    return GestureDetector(
      onPanCancel: () {
        print(9999999999);
      },
      child: widget.child,
      onTapDown: (ev) {
        _isDown = true;
        if(widget.onPress!=null) {
          widget.onPress();  
        }
      },
      onTapUp: (ev) {
        _isDown = false;
        if(widget.onLeave!=null) {
          widget.onLeave();  
        }
      },
      onTap: () {
        if(_isDown && widget.onClick!=null) {
          widget.onClick();  
          _isDown = false;
        }
      },
      onVerticalDragUpdate: (ev) {
        // print('y => ${ev.delta.dy}');
        if(_isDown && widget.onLeave!=null) {
          widget.onLeave();  
          _isDown = false;
        }
      },
      onHorizontalDragUpdate: (ev) {
        // print('x => ${ev.delta.dx} => ${context.size}');
        if(_isDown && widget.onLeave!=null) {
          widget.onLeave();  
          _isDown = false;
        }
      }
    );
  }
}