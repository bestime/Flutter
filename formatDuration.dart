
import './zero.dart';

int _oneSecond = 1000;
int _oneMinute = 60 * _oneSecond;
int _oneHour = _oneMinute * 60;



/// 将秒转换为 时:分:秒
String formatDuration (int millisecond) {
//  millisecond = (1000 * 60 * 60 * 2) + (1000*60) + 5000;

  /// 小时
  int hour = millisecond ~/ _oneHour;
  millisecond = millisecond % _oneHour;

  /// 分钟
  int minute = millisecond ~/ _oneMinute;
  millisecond = millisecond % _oneMinute;

  /// 秒
  int second = millisecond ~/ _oneSecond;
  millisecond = millisecond % _oneSecond;


  return '${zero(hour)}:${zero(minute)}:${zero(second)}';
}