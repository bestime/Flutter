
import 'dart:async';
Timer setTimeout (Function callback, int milliseconds) {
  return new Timer(new Duration(milliseconds: milliseconds), callback);
}