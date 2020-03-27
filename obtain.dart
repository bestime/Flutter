import 'dart:io';
import 'dart:convert';
import './paramData.dart';


// 接口配置
Map _host = {
  'jcy': 'http://192.168.0.224:9997'
};

/*
 * http请求，接口设计类似jquery的ajax
 * @author Bestime
 * @return {Future}
 */
Future obtain ({
  String url = '', // 请求地址，支持使用变量表示开发人员的域名 例：{{worker01}}/login
  String type = 'GET', // 请求类型
  Map data = const {}, // 请求数据
}) async {
  type = type.toUpperCase(); // 请求类型 转大写
  url = url.replaceAll(new RegExp('\\?\$'), '');
  url = url.replaceAll(new RegExp('\&\$'), '');
  // 处理 url 中的变量
  url = url.replaceAllMapped(new RegExp('{{.*?}}'), (Match match) {
    return _host[match[0].replaceAll(new RegExp('{|}'), '')];
  });

  // GET 请求拼接数据到 url
  if(type == 'GET') {
    String _pData = paramData(data);
    if(_pData!=null && _pData!='') {
      url += (new RegExp('\\?').hasMatch(url) ? '&' : '?') + _pData;
    }
  }

  // 创建请求
  var request;
  var httpClient = new HttpClient();
  Uri uri = Uri.parse(url);
  print('[${_getNowTime()}] 开始[$type]请求 $uri => 请求数据：$data');

  return Future<Map<String, dynamic>> (() async {
    try {
      switch (type) {
        case 'GET':
          request = await httpClient.getUrl(uri);
          break;
        case 'POST':
          request = await httpClient.postUrl(uri);

          // 设置请求头
          request.headers.contentType = new ContentType("application", "x-www-form-urlencoded", charset: "utf-8");

          // post 序列化的表单数据
          request.write(paramData(data));
          break;
      }
    } catch (err) {
      throw Exception({
        'code': -1,
        'msg': '网络异常',
        'error': err
      });
    }

    var result = await request.close().then((response) async {
      if (response.statusCode == HttpStatus.OK) {
        return await response.transform(utf8.decoder).join().then((json) {
          Map<String, dynamic> res = jsonDecode(json);
          print('[${_getNowTime()}] 结果[$type]请求 $uri 成功 => $res');
          return res;
        });
      } else {
        print('[${_getNowTime()}] [$type]状态异常 $uri => ${response}');
        throw Exception({
          'code': -3,
          'msg': '状态异常',
          'error': response
        });
      }
    }).catchError((err){
      print('[${_getNowTime()}] [$type]请求异常 $uri => $err');
      throw Exception({
        'code': -2,
        'msg': '请求异常',
        'error': err
      });
    });
    return result;
  });
}

DateTime _getNowTime () {
  return new DateTime.now();
}