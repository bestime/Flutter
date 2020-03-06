/**
 * 清空数组和json空值数据
 * @param {dynamic} data 需要处理的数据
 * @param {?Boolean} useNull 是否需要保留空字符串，默认false
 * @return {dynamec} 返回处理结果
 * */
dynamic clean (dynamic data, [bool useNull = false]) {
  dynamic res;
  if(data is Map) {
    res = {};
    dynamic mpItem;
    data.forEach((key, item) {
      if(item is Map || item is List) {
        mpItem = clean(item, useNull);
      } else {
        mpItem = item;
      }
      _filterData(mpItem, useNull, (useValue) {
        res[key] = useValue;
      });
    });
  } else if(data is List) {
    res = [];
    for(var item in data) {
      item = clean(item, useNull);
      _filterData(item, useNull, (useValue) {
        res.add(useValue);
      });
    }
  } else {
    res = data;
  }
  return res;
}

// 处理这是数据是否需要
void _filterData (dynamic data, bool useNull, Function callback) {
  if(useNull || data != null) {
    callback(data);
  }
}