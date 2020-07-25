/// 拼接url和查询参数
/// @param {developer} 开发者域名
/// @param {qs} 序列化后的参数（标准格式：a=1&b=2）

String urlToGet (String developer, String qs) {
  String res;
  qs = qs ?? '';

  /// 将连续的????，变成单个?
  developer = (developer ?? '').replaceAll(RegExp("\\\?+"), "?");

  if(RegExp(r"\?").hasMatch(developer)) {
    /// 将连续的&&&&，变成单个&
    developer = developer.replaceAll(RegExp("&+"), "&");
    res  = developer + '&' + qs;
  } else {
    res = developer + '?' + qs;
  }
  return res;
}