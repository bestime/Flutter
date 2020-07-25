Map _events = {}; /// 事件存储中心
int _eventId = 0; /// 事件id


class EventBus {
  static Map item;

  /// @param {name} 事件名
  /// @param {handle(String name, [Map data])} 事件，没有强制参数
  /// @param {isOnce} 是否执行一次之后就销毁
  /// @param {onlyOne} 是否覆盖同名事件
  static Map create (String name, Function handle, bool isOnce, bool onlyOne) {
    item = {
      'id': ++_eventId,
      'name': name,
      'isOnce': isOnce,
      'handle': handle
    };

    if(onlyOne) {
      _events[name] = item;
    } else {
      if(_events[name] is List) {
        _events[name].add(item);
      } else {
        _events[name] = [item];
      }
    }

    return item;
  }

  static Map on (String name, Function handle) {
    return create(name, handle, false, false);
  }

  static Map once (String name, Function handle) {
    return create(name, handle, true, false);
  }

  static Map one (String name, Function handle) {
    return create(name, handle, false, true);
  }

  static Map oneOnce (String name, Function handle) {
    return create(name, handle, true, true);
  }

  // 取消一个bus监听
  static void clear (Map item) {
    if(item != null) {
      if(_events[item['name']] is Map) {
        _events.remove(item['name']);
      } else if(_events[item['name']] is List) {
        for(int index = _events[item['name']].length - 1; index >= 0; index--) {
          if(_events[item['name']][index]['id'] == item['id']) {
            _events[item['name']].removeAt(index);
          }
        }
      }
    }
  }

  // 返回是否执行成功，失败表示没找到需要执行的方法，可携带一个参数过去
  static bool emit (String name, [Map data = const {}]) {
    bool isSuccess = false;
    if(_events[name] is Map) {
      _events[name]['handle'](data, _events[name]);
      isSuccess = true;
      if(_events[name]['isOnce']) {
        _events.remove(name);
      }
    } else if(_events[name] is List) {
      Map eventItem;
      for(int index = _events[name].length - 1; index >= 0; index--) {
        eventItem = _events[name][index];

        eventItem['handle'](data, eventItem);
        isSuccess = true;
        if(eventItem['isOnce']) {
          _events[name].removeAt(index);
        }
      }
    }
    return isSuccess;
  }
}




/*



Map bus1 = EventBus.on('永久事件', (Map busItem, Map data) {
  print('Bus执行 =>【$busItem】$data');
});

EventBus.once('一次性事件', (Map busItem, Map data) {
  print('Bus执行 =>【$busItem】$data');
});

EventBus.one('唯一事件', (Map busItem, Map data) {
  print('Bus执行 =>【$busItem】$data');
});

EventBus.oneOnce('唯一一次性事件', (Map busItem, Map data){
  print('Bus执行 =>【$busItem】$data');
});

EventBus.clear(bus1); // 取消监听一个bus




*/