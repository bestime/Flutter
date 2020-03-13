
import 'dart:async';
Timer setTimeout (Function callback, int msec) {
  
  return new Timer(new Duration(milliseconds: msec), callback);
}