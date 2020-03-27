import 'package:flutter/material.dart';
import './sleep.dart';

// class RefreshBox extends StatelessWidget {
//   final List<Widget> children;
//   final Function onReachBottom; // 上拉加载
//   final Function onRefresh; // 下拉刷新
//   final String log;

//   RefreshBox({
//     this.children,
//     this.onReachBottom,
//     this.onRefresh,
//     this.log = 'abc'
//   });


//   @override
//   Widget build (BuildContext context) {
//     return Text(log);
//   }
// }


class RefreshBox extends StatefulWidget {
  final List<Widget> children;
  final Function onReachBottom; // 上拉加载
  final Function onRefresh; // 下拉刷新
  final String log;

  RefreshBox({
    this.children,
    this.onReachBottom,
    this.onRefresh,
    this.log = '0'
  });

  @override
  _RefreshView createState() => new _RefreshView();
}

class _RefreshView extends State<RefreshBox> {
  ScrollController _scrollController = new ScrollController();

  bool _bottomReaching = false; // 刚刚到达上拉加载条件，并执行回调函数
  bool _botomEnding = true; // 加载数据后，渲染过程中不再执行
 




  @override
  void initState () {
    super.initState();
    
    // print('齿梳化');
    if(widget.onReachBottom!=null) {
      _scrollController.addListener(() async {
        double diff = _scrollController.position.pixels - _scrollController.position.maxScrollExtent;
        if(_botomEnding && !_bottomReaching && diff >= 0) {
          print('下拉加载');
          widget.onReachBottom();
          setState(() {
            _bottomReaching = true;
            _botomEnding = false;
          });
          await sleep(5000);
          setState(() {
            _bottomReaching = false;
          });
          await sleep(500);
          setState(() {
            _botomEnding = true;
          });
        }
      });
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return Text(widget.log);
  }

  // @override
  // void dispose () {
  //   // _scrollController?.dispose();
  // }
}