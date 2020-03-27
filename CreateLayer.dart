import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './config/ShortSetting.dart';
import 'dart:async' show Completer;

/**
 * 创建一个全屏的遮罩
 * 内容可自定义
 * 提供 show => 显示 
 * 提供 close => 关闭 
 */
class CreateLayer {
  OverlayEntry overlayEntry;
  OverlayState overlayState;
  bool active = false;
  bool ignoring = false; // 是否事件穿透
  bool _mounted = false; // 是否一个实例化挂载成功

  CreateLayer(this.ignoring);

  Future show ({
    @required BuildContext context,
    @required LayoutWidgetBuilder builder
  }) async {
    Completer completer = new Completer();  
    overlayState = Overlay.of(context);
    
    if(this.active && !this._mounted) {
      // 防止多个实例同时调用，导致只能关闭最后一个
      // 在没有mounted之前，频繁触发，就关闭之前的
      this.close();
    }

    this.active = true;
    
    overlayEntry = new OverlayEntry(
      builder: (context) {
        Widget child = LayoutBuilder(
          builder: (a, b) {            
            if(!completer.isCompleted) {
              this._mounted = true;
              completer.complete();
            }
            return builder(a, b);
          }
        );
        
        return _Wrapper(ignoring, Container(
            decoration: BoxDecoration(
              color: ShortSetting.transparentColor
            ),
            child: child,
          ),
        );
      }
    );
    overlayState.insert(overlayEntry);
    
    return completer.future;
  }

  close () {
    if (this.active) {
      this._mounted = false;
      this.overlayEntry?.remove();
      this.active = false;
      this.overlayEntry = null;
    }
  }
}

class _Wrapper extends StatelessWidget{
  final bool ignoring;
  final Widget child;
  _Wrapper(this.ignoring, this.child);
  
  @override
  Widget build (BuildContext context) {
    return !this.ignoring
      ? Container(
        child: child,
      )
      : IgnorePointer(
        ignoring: true,
        child: child
      );
  }
}