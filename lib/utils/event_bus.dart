typedef EventCallback = void Function(dynamic arg);

class EventBus {
  EventBus._internal();

  static final EventBus _instance = EventBus._internal();

  factory EventBus() => _instance;

  static final _listeningEvents = <Object, List<EventCallback>?>{};

  //添加订阅者
  static void on(EventType eventName, EventCallback f) {
    _listeningEvents[eventName] ??= <EventCallback>[];
    _listeningEvents[eventName]!.add(f);
  }

  //移除订阅者
  static void off(EventType eventName, [EventCallback? f]) {
    var list = _listeningEvents[eventName];
    if (list == null) return;
    if (f == null) {
      _listeningEvents[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  //触发事件，支持一对多
  static void emit(EventType eventName, {arg}) {
    var list = _listeningEvents[eventName];
    if (list == null) return;
    int len = list.length - 1;
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

enum EventType {
  // onTokenExpire, // token过期
  onSiteMaintain, // 站点到期
  onAuthRequire, // 需要认证/登录
  onLogin, // 登录
  onLogout, // 注销
  goToLogin,
  goToRegister,

  onRefUserCenter, //刷新个人中心

  changeLanguage, //语言切换 部分地方需要通知更新

  onGoRecharge, //打开充值页面
  onGoWithdraw, //打开取款页面
  onGoVip, //打开vip页面
  onGoTransfer, //转账
}
