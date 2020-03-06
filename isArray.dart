// 判断是否是数组
bool isArray (dynamic data) {
  return data == null || data is String || data is Map || data is num ? false : true;
}