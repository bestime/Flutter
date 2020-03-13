import 'package:flutter/material.dart';
import './sleep.dart';
import './OverlayWrapper.dart';

const _activeColor = Color.fromRGBO(255,255,255, 1);
const _backgroundColor = Color.fromRGBO(0, 0, 0, 0.9);


class Toast {
  bool dismissed = false;
  
  static Future _basic ({
    BuildContext context,
    String msg,
    int msec,
    Color color = _activeColor
  }) async {
    OverlayWrapper.close();
    await OverlayWrapper.show(
      context: context,
      builder: (context, constraints) {
        return Center(
          child: Container(
            decoration: new BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(5)
            ),
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Text(msg, style: new TextStyle(
              color: color,
              fontSize: 14.0,
              decoration: TextDecoration.none,
            )),
          ),
        );
      }
    );
    await sleep(msec);
    OverlayWrapper.close();
  }

  static Future info (BuildContext context, String msg, [int msec = 2000]) async {
    return await _basic(
      context: context, 
      msg: msg,
      msec: msec
    );
  }

  static Future denger (BuildContext context, String msg, [int msec = 2000]) async {
    return await _basic(
      context: context, 
      msg: msg,
      msec: msec,
      color: Color.fromRGBO(237, 64, 20, 1)
    );
  }
}