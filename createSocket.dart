import 'dart:io';

/**
 * socket 连接
 * @param {String} url 连接地址
 * */
void createSocket ({ String url = '' }) async {
  print('创建 websocket => $url');

  WebSocket ws = await WebSocket.connect(url).catchError((err) {
    print('socket连接错误');
  });

  print('socket 连接成功');

  ws.add('你好呀');

  ws.listen(
    (onData) {
      print('消息： $onData');
    },

    onError: (err) {
      print('错误： $err');
    },

    onDone: () {
      print('完成/断开连接');
    }
  );
}