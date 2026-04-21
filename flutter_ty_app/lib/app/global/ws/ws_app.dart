
import 'package:flutter_ty_app/app/global/app_life_cycle_state_change_util.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app_bus.dart';
import 'package:flutter_ty_app/app/global/ws/ws_type.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../modules/shop_cart/shop_cart_controller.dart';
import '../../services/models/domain_model.dart';
import '../../utils/pb.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-bc78d4ff-5b14-41a0-aa7b-ebad147c93f6-sz 】】】
    【【【 AUTO_DOCUMENT_MENU ws推送 】】】
    【【【 AUTO_DOCUMENT_TITLE  推送AppWebSocket实体创建 】】】
    【【【 AUTO_PARAGRAPH_TITLE 推送AppWebSocket实体创建入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 推送AppWebSocket实体创建
    ```
    AppWebSocket._() {
    AppLifecycleStateChangeUtil.instance().resumed();
    setWebSocketUrl();
    }
    ```
    - ws推送接受和转发
    ```
    数据变化
    static listen()
    ```
    - ws断开和重连
    ```
    断线重连
    static reconnect()
    ```
    - ws状态异常处理
    ```
    try {
    subscription  = channel?.stream.listen(
    (message) {
    try {
    Map<String, dynamic> data = jsonDecode(message);
    String cmd = data["cmd"];
    // AppLogger.debug('cmd=====>$cmd');
    if (cmd.isNotEmpty) {
    ///初始化数据仓库
    ///拿到cmd 先全局推送
    AppWebSocketBus.instance().pubicWsPush(cmd, data);
    }
    } catch (ex) {
    // AppLogger.debug('cmd=====>$ex');
    }
    },
    onError: (err) {
    /// 如果有订阅，取消订阅
    if (subscription != null) {
    subscription.cancel();
    }
    reconnect();

    },
    onDone: () {
    /// 如果有订阅，取消订阅
    if (subscription != null) {
    subscription.cancel();
    }
    reconnect();
    },
    cancelOnError: false,
    /// 如果出错，是否取消订阅
    );
    hasListener = true;
    } catch (e) {
    hasListener = false;
    // 没有监听器或者监听失败
    if (kDebugMode) {
    AppLogger.debug('没有监听器或者监听失败');
    }
    }

    ```
    】】】
 *
 */
class AppWebSocket {
  static AppWebSocket? _instance;
  static WebSocketChannel? channel;
  static String mqttUrl = '';

  ///地址默认前缀
  static String wsPrefix = '/yewuws2/push';

  ///是否加密 默认false 不加密
  static bool isWsDecrypt = false;

  ///重连定时器
  static Timer? reconnectTimer;
  Timer? sockettTimer;
  static bool socketClosed = false;

  ///单例初始化websocket
  static AppWebSocket instance() {
    _instance ??= AppWebSocket._();
    return _instance!;
  }

  static int _reconnectAttempts = 0;
  ///120次重连
  static const int _maxReconnectAttempts = 120;

  AppWebSocket._() {
    AppLifecycleStateChangeUtil.instance().resumed();
    setWebSocketUrl();
  }

  ///更换websocketurl
  static changWsUrl() async {
    // 确保关闭
    await closeSocket();
    setWebSocketUrl();
    connect();
  }

  ///保存websocketurl
  static setWebSocketUrl() {
    String? firstApi = DOMAIN_RESULT.first_one == ""
        ? StringKV.best_api.get()
        : DOMAIN_RESULT.first_one;
    // AppLogger.debug('ws链接======>$firstApi');
    if ((firstApi ?? '').isEmpty) return null;
    String wsUrl  = buildWsUrl(firstApi ?? '');
    // AppLogger.debug('ws链接2222======>$wsUrl');
    if(wsUrl.length > 0){
      StringKV.wssUrl.save(wsUrl);
    }

    return wsUrl;
  }

  ///wsl链接处理
  static String buildWsUrl(String apiUrl) {
    if (apiUrl.length == 0) return '';
    if (apiUrl.startsWith('https://')) apiUrl = apiUrl.replaceFirst('https', 'wss') + wsPrefix;
    if (apiUrl.startsWith('http://')) apiUrl = apiUrl.replaceFirst('http', 'ws') + wsPrefix;
    if(!apiUrl.contains("requestId")){
      apiUrl += "?requestId=${StringKV.token.get() ?? ""}";
    }
    if(!isWsDecrypt && !apiUrl.contains('&pb=1')){
      apiUrl += '&pb=1';
    }
    return apiUrl;
  }

  /// 获取websocket地址
  static getWebSocketUrl() {
    String? wsCache = StringKV.wssUrl.get();
    if (hasValue(wsCache) && wsCache!.isNotEmpty) {
      return wsCache;
    }
    return setWebSocketUrl();
  }

  /// 检查是否有监听器
  static bool hasListener = false;

  ///  登录成功 或者 splash_controller 有token时连接
  static connect() async {
    socketClosed = false;
    await initWebSocket();
    if (instance().sockettTimer != null) {
      instance().sockettTimer!.cancel();
      instance().sockettTimer = null;
    }
    instance().sockettTimer =
        Timer.periodic(const Duration(milliseconds: 15000), (timer) {
          pingpong();
          // AppLogger.debug('心跳包------------');
        });
    if (channel?.stream.isBroadcast == false) {
      listen();
    }
    // if (hasListener == false){
    //   listen();
    // }
    //购物车订阅
    if (Get.isRegistered<ShopCartController>()) {
      ShopCartController.to.subscribeMarket();
    }
  }

  /// 初始化连接
  static Future<void> initWebSocket() async {
    try {
      channel = WebSocketChannel.connect(Uri.parse(getWebSocketUrl()));
      await channel?.ready;
      _reconnectAttempts = 0;
    } catch (e) {
      _reconnectAttempts++;
      if (_reconnectAttempts < _maxReconnectAttempts) {
        final delay = Duration(seconds: 5 * _reconnectAttempts);
        // AppLogger.debug('WebSocket连接失败，${delay.inSeconds}秒后重试');
        await Future.delayed(delay);
        await initWebSocket();
      } else {
        // AppLogger.debug('重连次数过多，停止尝试');
      }
    }
  }

  ///心跳包
  static pingpong() {
    instance().sendMsg({
      "cmd": WsType.C0,
      "requestId": StringKV.token.get() ?? "",
    });
  }

  /// 数据变化
  static listen() {
    StreamSubscription? subscription;
    try {
      subscription = channel?.stream.listen(
            (message) {
          try {
            Map<String, dynamic> data = jsonDecode(message);

             // AppLogger.debug('cmd=====>${data.toString()}');
            ///c105 加密测试数据
            // data = {"cd":"H4sIAAAAAAAAAK1bwY4ctxH9lzlvBFYVyWLplrsDX5JDEASGYq0gIyvLsBQBgaB/z6ue3elmdTe1\nXMeQdrWzQ/bw8VW9V0X66+X9wye+vP56IWuX1//4evn5/W+/vL28Xn6+u7y//juTiFBKjZRKs8L+\nqw+fL68J33+9fuuGfbq8Tvj2Ba9oeVXw0oenXyeqUikZazVpXPG7jw/Loz/+y99PLeE/f/Xx2SxK\nqWWpqRCntAz4tDzzIz7B5ccv97/7S/3YL1jUJb1q6fLt7jaz5X5mlZY5ZWalXIlzmPlvv77dTH0b\n/Di15cu3f95d/I2kNVmupRUhXR54gmLOQBJ/AAGnkgKKfIAiP6FYJ1E07ddacgWSuUjNQJPiWjsU\nb2OflqpbFDXMTGKlYDVJS2IsbYiihqlVp1E05paJsfhUStUcUJQRinkSxVr7tUpK2L/GpsJMrYxQ\nvI19XGqtGxQ5tchFEDGRgmXZctERiuvgZeo/YYd4GsZSmPEgw8YhBiSSMY9g1DkYmahfbJZSmasW\nEEeypQGM69jbWruYriGmnRwKkjO+ChEP2VhDTNf5mGakJEnIIAkPq0oBxjKCUSbZCLS6tSZkRisV\nIWg1fyemb2Mfl1rKlo0sgedSDSEmFVmfcxpmxnXw0w41OoMRr5JZEBrbwCmJuBBgNSdniqzcCo0F\noWlpNkUGVhYu4GUxLc4eiiHYp0gKKZK2pGwRTmT9ysi8yo05j1Nkk6Bh8ixSblEsVBR/RRtyiWQd\nCI1FUtokihoCsCSlSsIe24jFISk1xB+S+TZFBiOATCHgfAHxk1YZkzJ1ToBe4YdZFKHRiGqGZuXE\nQGIgNBHFRpMZMoXQbqmo4MEmkJpMI6FZx94yZOkypAUYYXUKBAQPEEMKHGdICxnSpmFMWHwGD7O2\nmq5rPxOaHRnbrF6HkIbjQYKuyGeNaiMZ6nUI6boNaaaoM1RhR9mpsdi6IRkpxwz5PNuzhZHN8FAE\nVRW44TQSmh0beZKNHGHESpGWU4VjFtkZ5Y6NHPW68ZaNJTiq0ggTC/hYfZuGOK6Dn0SsDoRGtNMZ\n0a2HxBOLCcxFNavStmBu374BcQrAEgCseBNEgKVciRNWSTf0rgM3eGUO0VvgffHBUYhBVtjCTHzD\n6jpwAE9f70nnDbOoPwM4oaSicxWWWO1hi/6gCsO7qZcR2VNv2wXWH1BhQsKDfjAojN/tNuH/oMId\niNAOCDEKS8/PKJFORfgAxNmaWUOOt+oPB+cEBpt1ZLDXsU8ibF3NXCKTjahAc1CjwCPGmUPNHEyn\nC9MciChORBSWjF1GxE41+ADE2SolhVBjYKdAEV6QM6J2qMEcNbh1NXOcuiomVfXCGQoSdSnUzBw2\n6DnFXoeimTYoodRaBb4slsx5hOJ0yRyo6PUJzC9SSm6IvaGrPnIbd6ceSSBFCQHtZhNEH4J4bJLm\nUCxeFJAXJlrwZDlV4AMUJ40MUyAMyOIgAh9IBIq9ERcpcrF1EV1DWixixUqrLAoRLuPipIa0WE/T\noktMX+lJ5wpRmsBVQw+xM7Kj5EZiYp03S8gWHAdD/JGVwWwEHzzAmRavA58koHbqEho45EiC4pph\nLfKOjaswtxambc8hYmcFPWXkhqSEJ5Yau7F8jt1sxyF2ESGh1hYTYm6tY0pcsZtrIXoTxbtfYGJq\nZVftrNi9qH0ofWkMK6tCJAn6mGMQyzl205ocK4ak3tnDB6goSdI5dnNVsRJc4CIj5IYp0vmG3csq\n4g47PMbbTGBf1aK7/nU+x262AEmBIFAwWTiCJOiKcuqfk8Y0L13uC/Mi32ElKLCNPK2eB20NxKvT\nxBOGkyFXoezNi2gHyzl4s466Bp00w+fLy/Yh66VYMqzEq8Gu1a5HmKLHdNElExSF7E3Cc+JZ3JNh\nfzCcQ20VGOUnJa1I3N4l3PWsN93B2GtFoTCb+gKKpSD5ZDHz9jWNWwlHvnejHNHHNG0k3o9vqbFF\nbQ91SZi6PcfGdCDCvyy2CVWkdyXb5Uw9diDadG8wHnKQug9k75fDh0Ym9mVJkEltHRmDP0K5Bt1g\n73tqK23cjjk065MggvXI4eA2IqpIbGrJiImzvcHd6QkUrLp9KYi/lmPGnzk90SAmiGNzV8FktcLS\nDKmoKezQs1qsXXVnkuqV0tXa7lg5D6g43RkMQae8VA+S4Xo9lY2oOM6LFE9aFTQEkuqmPY37q+vg\nm1efjmeU+kQNbExelLRBY3BPxenGYNAAP5PHY7NmGIM6bNasY5+Wqp0nLNETeqGaEF/eBS8yzool\nyHM5leflBCocQG0ZuWgZPCgeDOGMyXF7/hTAnL7mEPVlMcDkPU583Z2JbsqSAwU479f4VQNR854h\nCg87tYcv69V02IEEjE/vJybkjz0XlojdZEm3y/7eX0VRl/xcGTJ6aq2/26YJeiXLua76ETlDVGJp\nvKlLDsRqDrxSLSdkdEmwU8gg54ISwZu1h7uc7waYkX39n7zLV5u65CDf352qVEPqI/e8jJpuf7lm\ntYeHEjUHXvXQYViA7McUNrrLEMCbLIihi7selCZ4QkPSgJLF7tbKPIrZr+WuMNldYyjOOe+NeEEc\nE+umMHnZFYYNeH7bxJJbT28z8XlhsgNvssG6S/EpQTyAWvWm//42zcq8o/R+dypKZMg/ECVx8ZBd\nvbMy71CRTmXD+vMk254nkfj5ptRCfhVjZwdX2bB4rFQmJRgVfijDBLm9+P084NlseF7SQie5P5qz\nXVZFZFJpfslE2eL2hFZ/mPpZN5I6DFuD9qGyywYhkV17lQcYzkZxCtEGBGtTFA4FhhR/RzYmxbNc\nqyNHXS1xE6iIqd8zHN9HepGj7kBE1siosfwuku/eeXtrD+JkWbI7a0/qd8oQcdq0sI7vxk2dtZMA\nO8lNZbmHOsTwhWftPYiLgS8VYpzK9QrLsZzsQZx1Mhwch6d9whfsYMVSRhXyOvaWvjozU2I4t7xc\nQcUm4TE8ZmIJ4Vymw5lRG/iNXVQkZAjuU1nZgzjbqsk1OprkSRFu0Jj3B0MdE3No8ufulqbE7alJ\nk/jpDxcI5/D0cx18259TEPFqlk5erp3ptU0JRqJQRb2aTA+uK1zf/sLrCn5KHF0NtbS4wkbp/LrC\n48AN6TiWH4laa1K89+nNs1Mfcx14Dk/r1bd1VGuIF7dLEH1rA/VtkWp5urcaqJbNr/8Ar1qZcxne\ndpu7EIzJTAvKgYLS2saX0194IbgD0W+x4g20CFze9WJ4AOLs4WbsJCPnoUQAU7wvTrsTuV5+j5rJ\nd6dtHuwKdB3sQ0JNe1EKh5sHfZ45EBssFhSQlos+XKOXlgGIs/2DHED0YzlnYmaDbvHQB+Zwzp67\nc3bZ3V418mMrBJl3b8dMlHgZWKdBRF5tXgwznHxSinc+8gDEyQb1bqne/UzAzy0ATMzwysfhSu9O\n9wcVoLcGc0Y2Z6vDC/6HGzQHIsHJwkOA0iBEq+ddwT2Is2Vdi5071CHi7TP/X01s2J9exz5VJF1P\nMM4M7WWkCuyPMiR+fHX1aOoTefm2gvPgT/rzjz+lN+8gte+qKz0yB+ogL5SXztzPYm/fOkJvfv/3\n/ecf7r/cP/iyfvjp7f27N/95+Pw98P7639/u8du//B0/fP7lw/3+A/0PnkCXrpc1AAA=","cmd":"C105","ctsp":"1760946585317","ld":"AO_0af409f62025102015494531190c39dd"};
            String cmd = data["cmd"];
            if (cmd == WsType.C105 && isWsDecrypt) {
              /// 解析
              Map<String, dynamic> cdMap = {};
              try {
                cdMap = pakoPb.unzipData(data['cd']);
              } catch (e) {
                // AppLogger.debug('cd 解密后不是合法的 JSON: $e');
              }
              data['cd'] = cdMap;
            }

            if (cmd.isNotEmpty) {
              ///初始化数据仓库
              ///拿到cmd 先全局推送
              AppWebSocketBus.instance().pubicWsPush(cmd, data);
            }
          } catch (ex) {
            // AppLogger.debug('cmd=====>$ex');
          }
        },
        onError: (err) {
          /// 如果有订阅，取消订阅
          if (subscription != null) {
            subscription.cancel();
          }
          reconnect();
        },
        onDone: () {
          /// 如果有订阅，取消订阅
          if (subscription != null) {
            subscription.cancel();
          }
          reconnect();
        },
        cancelOnError: false,

        /// 如果出错，是否取消订阅
      );
      hasListener = true;
    } catch (e) {
      hasListener = false;
      // 没有监听器或者监听失败
      if (kDebugMode) {
        // AppLogger.debug('没有监听器或者监听失败');
      }
    }
  }

  /// 订阅
  static subscribe(String topic) {
    if (channel != null) {
      channel!.sink.add(topic);
    }
  }

  /// 取消所有订阅
  static unsubscribe() async {
    if (channel != null) {
      channel!.sink.close();
      channel = null;
    }
  }

  /// 断线重连
  static reconnect() async {
    if (!socketClosed) {
      if (AppLifecycleStateChangeUtil.isResumed) {
        await unsubscribe();
        connect();
      }
    }
  }

  /// @Description:发送ws消息到ws服务器
  /// @param: data 消息体
  /// @param: type 消息标记-自定义模拟推送内部命令该值为custom
  /// @return:
  void sendMsg(dynamic data, {String? type}) {
    if (data != null) {
      if (type != null) {
        data['type'] = type;
      }
      channel?.sink.add(jsonEncode(data));
    }
  }

  /// 关闭连接
  static closeSocket() async {
    if (channel != null) {
      await channel!.sink.close();
      channel = null;
    }
    socketClosed = true;
    instance().sockettTimer?.cancel();
  }
}
