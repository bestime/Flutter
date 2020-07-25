/// 原生 int.parse() 只能传入全是数字的字符串，空字符串也会报错
/// @param {data} 任意数据
/// @param {defaultNumber} 默认数字，如果转换失败，使用此值，默认为0
int toInt (dynamic data, [int defaultNumber = 0]) {
  String str = data.toString();
  str = str.replaceAllMapped(new RegExp('[^0-9]'), (Match match) {
    return '';
  });
  return str == ''  ? defaultNumber : int.parse(str);
}