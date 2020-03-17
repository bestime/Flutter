import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './CreateLayer.dart';
import 'dart:async';
import './setTimeout.dart';
const _backgroundColor = Color.fromRGBO(0, 0, 0, 0.9);
const _activeColor = Color.fromRGBO(255,255,255, 1);


class Toast {
  static CreateLayer _cty = new CreateLayer(true);

  static Timer _timer;

  static build (BuildContext context, Widget child) {
    _cty?.close();
    _cty.show(
      context: context,
      builder: (ctx, constraints) {
        return child;
      }
    );
  }

  static _base ({
    @required BuildContext context,
    @required String message,
    Color color = _activeColor,
    int duration
  }) {
    if(duration == null) {
      duration = 2000;
    }
    _cty.close();
    _timer?.cancel();
    _timer = setTimeout(_cty.close, duration);
    _cty.show(
      context: context,
      builder: (ctx, constraints) {
        return Center(
          child: Container(
            decoration: new BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(5)
            ),
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Text(message, style: new TextStyle(
              color: color,
              fontSize: 14.0,
              decoration: TextDecoration.none,
            )),
          ),
        );
      }
    );
  }

  static info (BuildContext context, String message, [int duration]) {
    _base(
      context: context,
      message: message,
      duration: duration
    );
  }

  static danger (BuildContext context, String message, [int duration]) {
    _base(
      context: context,
      message: message,
      color: Colors.red,
      duration: duration
    );
  }
}