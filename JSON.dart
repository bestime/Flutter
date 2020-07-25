import 'dart:convert';

class JSON {
  static dynamic parse (String data) {
    dynamic res;
    try {
      res = jsonDecode(data);
    } catch(err) {
      res = null;
    }
    return res;
  }
}