///清空数组和json空值数据
/// @param {dynamic} data 需要处理的数据
/// @param {?Boolean} removeEmptyStr 是否需移除留空字符串，默认false
/// @return {dynamec} 返回处理结果
dynamic clean (dynamic data, [bool removeEmptyStr = false]) {
  dynamic res;
  if(data is Map) {
    res = {};
    dynamic mpItem;
    data.forEach((key, item) {
      if(item is Map || item is List) {
        mpItem = clean(item, removeEmptyStr);
      } else {
        mpItem = item;
      }
      _filterData(mpItem, removeEmptyStr, (useValue) {
        res[key] = useValue;
      });
    });
  } else if(data is List) {
    res = [];
    for(var item in data) {
      _filterData(clean(item, removeEmptyStr), removeEmptyStr, (useValue) {
        res.add(useValue);
      });
    }
  } else {
    res = data;
  }
  return res;
}

// 处理这是数据是否需要
void _filterData (dynamic data, bool removeEmptyStr, Function callback) {
  if(removeEmptyStr) {
    if(data!='' && data !=null) {
      callback(data);
    }
  } else if(data !=null){
    callback(data);
  }
}