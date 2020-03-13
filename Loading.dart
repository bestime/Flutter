import 'package:flutter/material.dart';
import './OverlayWrapper.dart';
import './setTimeout.dart';
import 'dart:async';




const _activeColor = Color.fromRGBO(255,255,255, 1);
const _backgroundColor = Color.fromRGBO(0, 0, 0, 0.9);

class Loading {
  bool dismissed = false;
  static Function _update;
  static Timer _timer;
  static dynamic oWrapper;
  static int _duration = 15000; // 自动关闭
  
  // static OverlayWrapper tv = new OverlayWrapper();
  
  static Future show (BuildContext context, String msg) async {    
    _timer?.cancel();
    if(_update!=null) { 
      _update(msg);
      _timer = setTimeout(close, _duration);
    } else {
      _timer = setTimeout(close, _duration);
      
      await OverlayWrapper.show(
        context: context,
        builder: (context, constraints) {
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
        },
      );
    }
  }

  static close () {
    OverlayWrapper.close(); // 关闭上一个
    _update = null;
  }
}