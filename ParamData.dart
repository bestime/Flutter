
import './isEmpty.dart';

/**
 * 序列化字符串，参照以前JS写的ParamData
 */

String ParamData (Map data) {
  String res = '';

  void addOne (String key, dynamic value) {
    if(value is Function) {
      value = value();
    } else if(isEmpty(value)) {
      value = '';
    } else if(value is num) {
      value = value.toString();
    }
    res = res + (isEmpty(res) ? '' : '&') + Uri.encodeComponent(key) + '=' + Uri.encodeComponent(value);
  }

  void buildParam (String prefix, dynamic item) {
    if(!isEmpty(prefix)) {
      if(item is List) {
        for(var index = 0; index < item.length; index++) {
          buildParam('$prefix[${item[index] is Map && item[index] ? index : ''}]', item[index]);
        }
      } else if(item is Map) {
        item.forEach((key, val){
          buildParam(prefix + '[' + key + ']', item[key]);
        });
      } else {
        addOne(prefix, item);
      }
    } else if(item is Map) {
      item.forEach((key, val){
        buildParam(key, val);
      });
    }
  };

  buildParam('', data);
  
//  print('结果：$res');
  return res;
}