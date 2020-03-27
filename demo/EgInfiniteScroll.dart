



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/BestimeDart/tool/ColorTool.dart';
import '../InfiniteScroll.dart';

Widget _getZfx (int count) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: count % 2 ==0 ? Colors.red : Colors.blue
    ),
    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
    child: Center(
      child: Text('$count', style: TextStyle(color: Colors.white),),
    ),
  );
}

class EgInfiniteScroll extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 10),
        InfiniteScroll(
          backgroundColor: Colors.blue,
          child: Text('写一个方法，可以利用字符串路径获取对象集合的值，当值不存在时返回错误信息----------'),
          size: 40,
          speed: 50,
          period: 1000
        ),
        Container(height: 10),

        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: InfiniteScroll(
            backgroundColor: Colors.white,
            speed: 20,
            child: Row(
              children: <Widget>[
                _getZfx(1),
                _getZfx(2),
                _getZfx(3),
                _getZfx(4),
                _getZfx(5),
                _getZfx(6),
                _getZfx(7),
              ],
            ),
            size: 50
          ),
        ),
        Container(height: 10),

        InfiniteScroll(
          backgroundColor: Colors.yellow,
          child: Text('ListView即滚动列表控件，能将子控件组成可滚动的列表。当你需要排列的子控件超出容器大小！！！！'),
          size: 30,
          speed: 20,
          period: 1000,
          reverse: true,
        ),
        Container(height: 10),
        InfiniteScroll(
          backgroundColor: Colors.blue,
          child: Text('写一个方法，可以利用字符串路径获取对象集合的值，当值不存在时返回错误信息----------'),
          size: 20,
          speed: 7,
          period: 1000,
          direction: Axis.vertical,
        ),
        Container(height: 10),
        InfiniteScroll(
          backgroundColor: Colors.orange,
          child: Text('ListView即滚动列表控件，能将子控件组成可滚动的列表。当你需要排列的子控件超出容器大小！！！！'),
          size: 30,
          speed: 10,
          period: 1000,
          reverse: true,
          direction: Axis.vertical
        )
      ],
    );
  }
}