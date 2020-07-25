import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './setTimeout.dart';
import './CreateLayer.dart';
import 'dart:async';
const Color _backgroundColor = Color.fromRGBO(0, 0, 0, 0.9);
const Color _activeColor = Color.fromRGBO(255,255,255, 1);

class Loading {
  static CreateLayer _cty = new CreateLayer(false);
  static Timer _timer;
  static Function _update;

  static close () {
    _update = null;
    _cty.close();
  }

  static Future show (BuildContext context, String msg, [int duration = 15000]) async {
    _timer?.cancel();
    _timer = setTimeout(close, duration);
    if(_update!=null) {
      _update(msg);
    } else {
      await _cty.show(
        context: context,
        builder: (ctx, constraints) {
          String message = msg;
          return StatefulBuilder(
            builder: (context, state) {     
              _update = ((String newMessage){
                state(() {
                  message = newMessage;
                });
              });
              return new Center(
                child: Container(
                  decoration: new BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: EdgeInsets.all(30.0),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: new CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation(_activeColor)
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                        child: Text(message, style: new TextStyle(
                          color: _activeColor,
                          fontSize: 14.0,
                          decoration: TextDecoration.none,
                        )),
                      )
                    ]
                  )
                )
              );
            },
          );
        }
      );
    }
  }
}