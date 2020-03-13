import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './config/ShortSetting.dart';
import './sleep.dart';
import 'dart:async' show Completer;

// 透明色
const _transparentColor = ShortSetting.transparentColor;




class Jcyi {
  static show () {}
}



// 创建容器
class OverlayWrapper {
  static OverlayEntry overlayEntry;
  static OverlayState overlayState;
  static bool dismissed = false;

  void abc () {}
  
  static Future show({
    BuildContext context,
    LayoutWidgetBuilder builder,
    bool hasMask = true,
    Color maskBackgroundColor = _transparentColor // 遮罩背景色
  }) async {
    dismissed = false;
    Completer completer = new Completer();  
    overlayState = Overlay.of(context);
    overlayEntry = new OverlayEntry(
      builder: (context) {
        Widget child = LayoutBuilder(
          builder: (a, b) {            
            if(!completer.isCompleted) {
              completer.complete();
            }
            return builder(a, b);
          }
        );
        return IgnorePointer(
          ignoring: false,
          child: !hasMask ? child : Container(
            decoration: BoxDecoration(
              color: maskBackgroundColor
            ),
            child: child,
          ),
        );
      }
    );
    overlayState.insert(overlayEntry);
    
    return completer.future;
  }

  static close() {
    if (!dismissed) {
      overlayEntry?.remove();
      dismissed = true;
      overlayEntry = null;
    }
  }
}