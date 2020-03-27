



import 'package:flutter/cupertino.dart';
import './tool/ColorTool.dart';
import './YBorderRadiusBox.dart';




class ButtonBox extends StatefulWidget {
  final Color downBackgroundColor; // 按下的背景色
  final Color staticBackgroundColor; // 默认背景色
  final Function onClick; // 点击回调
  final String label; // 文字
  final double fontSize; // 文字大小
  final List<double> padding; // 按钮padding
  final List<double> margin; // 按钮margin

  final List<double> borderRadius; // 按钮圆角

  ButtonBox({
    this.label = '按钮',
    this.downBackgroundColor,
    this.staticBackgroundColor,
    this.onClick,
    this.fontSize = 14,
    this.padding = const <double>[10, 0, 10, 0],
    this.margin = const <double>[0, 0, 0, 0],
    this.borderRadius = const <double>[0, 0, 0, 0],
  });

  @override
  _ButtonBox createState () => new _ButtonBox();
}

class _ButtonBox extends State<ButtonBox> {
  Color _currentBackgroundColor;
  @override
  Widget build (BuildContext context) {
    _currentBackgroundColor = _currentBackgroundColor == null ? widget.staticBackgroundColor : _currentBackgroundColor;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(widget.margin[3], widget.margin[0], widget.margin[1], widget.margin[2]),
        child: YBorderRadiusBox(
          borderRadius: widget.borderRadius,
          child: Container(
            decoration: BoxDecoration(
              color: _currentBackgroundColor
            ),
            padding: EdgeInsets.fromLTRB(widget.padding[3], widget.padding[0], widget.padding[1], widget.padding[2]),
            child: Center(
              child: Text(widget.label, style: TextStyle(
                color: ColorTool.hex('#fff'),
                fontSize: widget.fontSize,
                decoration: TextDecoration.none,
              )),
            ),
          ),
        ),
      ),
      onTapDown: (det) {
        setState(() {
          _currentBackgroundColor = widget.downBackgroundColor;
        });
      },
      onTapUp: (det) {
        setState(() {
          _currentBackgroundColor = widget.staticBackgroundColor;
        });
      },
      onTap: widget.onClick,
      onVerticalDragUpdate: (det) {
        setState(() {
          _currentBackgroundColor = widget.staticBackgroundColor;
        });
      },
      onHorizontalDragUpdate: (det) {
        setState(() {
          _currentBackgroundColor = widget.staticBackgroundColor;
        });
      }
    );
  }
}