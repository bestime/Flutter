
// 用法与javascript类似
bool some (List list, bool Function(dynamic item) handle) {
  bool res = false;
  for(int index = 0; index < list.length; index++) {
    if(handle(list[index])) {
      res = true;
      break;
    }
  }

  return res;
}