


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/BestimeDart/ImageBox.dart';
import './tool/ColorTool.dart';
import './sleep.dart';

import './CreateLayer.dart';

class JcyDrawer {
  static CreateLayer show (BuildContext context, {
    @required Widget child,
    String title = '默认标题'
  }) {
    CreateLayer ctr = new CreateLayer(true);
    ctr.show(context: context, builder: (a, b) {
      return Container(
        decoration: BoxDecoration(
          color: ColorTool.hex('#000', 0.5)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: ColorTool.hex('#fff'),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorTool.hex('#eee')
                        )
                      )
                    ),
                    child: _Header(title, ctr.close),
                  ),
                  child
                ],
              ),
            )
          ],
        ),
      );
    });
    return ctr;
  }
}

class _Header extends StatelessWidget {
  final Function onDelete;
  final String title;
  _Header(this.title, this.onDelete);
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title, style: TextStyle(
              fontSize: 16,
              color: ColorTool.hex('#666'),
              decoration: TextDecoration.none
            )),
            GestureDetector(
              onTap: this.onDelete,
              child: Icon(Icons.close),
            ),
            // Icon(Icons.close)
          ],
        ),
      ),
    );
  }
}