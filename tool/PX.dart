

import 'package:flutter/cupertino.dart';

double screenWidthFromPX = 0;
double _scale = 0; // 缩放比例
bool _isInit = false; // 是否已经初始化
double screenHeightFromPX = 0;

void initPx (BuildContext context, double width) {
  if(!_isInit) {
    MediaQueryData query = MediaQuery.of(context);
    screenWidthFromPX = query.size.width;
    screenHeightFromPX = query.size.height;
    _scale = screenWidthFromPX / width;
    print('屏幕信息：$query');
    _isInit = true;
  }
}

double px (double num) {
  num = num ?? 0;
  return _scale * num;
}

