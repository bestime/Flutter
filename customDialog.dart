import 'package:flutter/material.dart';
import 'dart:async';

Future<T> customDialog<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
  Curve tween,
  bool maskToClose = true, // 点击空白区域关闭
  Color backgroundColor = const Color.fromRGBO(0, 0, 0, 0.8),
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: maskToClose,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: backgroundColor, // 自定义遮罩颜色
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: tween==null ? null : (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      // 使用缩放动画
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: tween, // Curves.easeInOutCubic
        ),
        child: child,
      );
    },
  );
}
