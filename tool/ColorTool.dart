import 'package:flutter/cupertino.dart';

// Color color16 (String code) {
//   code = code.substring(1, code.length);

//   print('code $code');
//   if(code.length==3) {
//     code += code;
//   } else if(code.length!=6) {
//     code = '00000';
//   }

//   return Color(int.parse(code, radix: 16) + 0xFF000000);
// }

class ColorTool {

  // 透明色
  static const Color transparent = Color(0x00000000);

  // @param {String} code 十六进制颜色
  // @param {double} opacity 透明度，默认 1
  static Color hex (String code, [double opacity = 1.0]) {
    code = code.substring(1, code.length);
    if(opacity < 0) {
      opacity = 0;
    } else if(opacity > 1) {
      opacity = 1;
    }

    if(code.length==3) {
      code += code;
    } else if(code.length!=6) {
      code = '00000';
    }

    int num16 = int.parse('0x$code');

    return Color.fromRGBO((num16 & 0xFF0000) >> 16 ,
         (num16 & 0x00FF00) >> 8,
         (num16 & 0x0000FF) >> 0,
         opacity);
  }
}