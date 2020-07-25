import './setTimeout.dart';
import 'dart:async';
typedef DebounceCallback = Function(Function callback);

// 用法与javascript版相同，没有了this上下文指向传递
DebounceCallback debounce (int sleepTime, [bool isFirstWork = false]) {
  bool firstFlag = isFirstWork; // 第一次是否执行
  Timer tot; // 定时器用于执行之后还原firstFlag
  Timer timer;

  void doOnce (Function handle) {
    handle();
    tot = setTimeout(() {
      firstFlag = isFirstWork;
    }, sleepTime);
  }

  return (Function callback) {
    timer?.cancel();
    tot?.cancel();
    if(firstFlag) {
      firstFlag = false;
      doOnce(callback);
    } else {
      timer = setTimeout((){
        doOnce(callback);
      }, sleepTime);
    }
  };
}