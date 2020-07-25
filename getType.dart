import 'package:dio/dio.dart';

String getType (dynamic data) {
  String res;
  if(data is int) {
    res = 'Int';
  } else if(data is double) {
    res = 'Double';
  } else if(data is num) {
    res = 'Num';
  } else if(data is String) {
    res = 'String';
  } else if(data is Map) {
    res = 'Map';
  } else if(data is List) {
    res = 'List';
  } else if(data is bool) {
    res = 'Boolean';
  } else if(data is Runes) {
    res = 'Runes';
  } else if(data is Symbol) {
    res = 'Symbol';
  } else if(data is Response) {
    res = 'Response';
  }else {
    res = '此类型未处理';
  }
  return res;
}