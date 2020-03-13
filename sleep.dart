
/*
 * 延迟执行
 * @param {int} msec 等待时间（毫秒） 
 * @return {Future}
 */
Future sleep (int msec) async {
  await Future.delayed(Duration(milliseconds: msec));
}