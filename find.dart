
typedef Iteration = bool Function (dynamic item, int index);

Object find (List list, Iteration handle) {
  dynamic res;
  for(int index = 0; index < list.length; index++) {
    if(handle(list[index], index) == true) {
      res = list[index];
      break;
    }
  }
  return res;
}