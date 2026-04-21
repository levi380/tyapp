import 'dart:async';
import 'dart:convert';

import 'package:filbet/api/api.dart';
import 'package:filbet/utils/globe_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_launcher_icons/config/config.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/common/currency.dart';
import 'package:filbet/utils/app_config.dart';
import 'package:filbet/services/global/global_service.dart';

class WebSocketService extends GetxService with WidgetsBindingObserver {
  String TAG = "WebSocketService";
  final int PORT = 8084;
  final int MAX_COUNT = 1000; //最大重连次数
  int currentReConnectCount = 0; //当前重连次数
  MqttServerClient? _client;

  bool isConnected = false;
  bool isLogout = false; //是否手动退出登录
  final _reconnectDelay = const Duration(seconds: 5);
  Timer? _reconnectTimer;
  static WebSocketService get to => Get.find();
  String? mqttUrl = "";
  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    Configapi();
  }

  Configapi() async {
 
    mqttUrl = AppEnvConfig.instance.mqttUrl;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  Future<void> connect() async {

    if (isConnected) {
      return;
    }
    isLogout = false;
    if (UserService.to.state.isRegularUser) {
   
      _client = MqttServerClient.withPort(
        mqttUrl!, // 你的 broker 地址
        'flutter_client_${DateTime.now().millisecondsSinceEpoch}', // 唯一 clientId
        PORT, // WSS 端口
      );

      _client?.useWebSocket = true;
      _client?.websocketProtocolString = ['mqtt']; // 有些服务器要求
      _client?.logging(on: true);
      _client?.keepAlivePeriod = 20;
      _client?.setProtocolV311();
      _client?.onConnected = _onConnected;
      _client?.onDisconnected = _onDisconnected;

      // 用户名密码（如果需要）
      // client.connectionMessage = MqttConnectMessage()
      //     .authenticateAs('yourUsername', 'yourPassword');

      final connMess = MqttConnectMessage()
          .withClientIdentifier(_client!.clientIdentifier)
          .startClean()
          .withWillQos(MqttQos.atLeastOnce);

      _client?.connectionMessage = connMess;

      try {
        final res = await _client?.connect();
        if (_client?.connectionStatus?.state == MqttConnectionState.connected) {
          print('${TAG},✅ MQTT 连接成功');
          currentReConnectCount = 0;
          isConnected = true;
          
          // subscribeTip("mqtt_bonus_notify_24736056264137120");
          subscribeTip("prod/${UserService.to.state.uid}");
          _client?.updates
              ?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
            final recMess = c![0].payload as MqttPublishMessage;
            final payload = MqttPublishPayload.bytesToStringAsString(
                recMess.payload.message);
            final topic = c[0].topic;
            print('${TAG},📩 接收到主题 [$topic] 消息: $payload');
            // var jsonMsg = jsonDecode(payload);
           
            var amount = payload; //礼金金额

              if (amount != null && amount=="balance") {
                UserService.to.queryTotalBalance();
              }
          
          });
        } else {
          isConnected = false;
          print('${TAG},❌ 连接失败: ${_client?.connectionStatus}');
        }
      } catch (e) {
        isConnected = false;
        print('${TAG},❌ 连接异常: $e');
      }
    }
  }

  /// 连接成功回调
  void _onConnected() {
    print('${TAG},MQTT 已链接');
  }

  /// 断线回调
  void _onDisconnected() {
    print('${TAG},⚠️ MQTT 已断开');
    isConnected = false;
    _startReconnect();
  }

  //mqtt_bonus_notify_24736056264137120
  ///订阅消息
  void subscribeTip(String tip) {
    // 订阅主题
    _client?.subscribe(tip, MqttQos.atLeastOnce);
    print("${TAG},订阅主题$tip");
  }

  /// 发布消息
  void publish(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client?.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }

  ///断开连接
  void closeConnect() {
    if (_client?.connectionStatus?.state == MqttConnectionState.connected) {
      String tip = "mqtt_bonus_notify_${UserService.to.state.uid}";
      isLogout = true;
      isConnected = false;
      _client?.unsubscribe(tip);
      _client?.disconnect();
      print('${TAG},🔌 MQTT 断开');
    }
  }

  /// 重连逻辑
  void _startReconnect() {
    if (isConnected) return;
    if (isLogout) return;
    if (_reconnectTimer?.isActive ?? false) return;
    if (currentReConnectCount >= MAX_COUNT) return; //重连次数上限
    print('${TAG},🔄 启动重连计时器...');
    currentReConnectCount++;
    _reconnectTimer = Timer.periodic(_reconnectDelay, (_) async {
      print('${TAG},🔁 正在尝试重连...');
      await connect();
      if (isConnected) {
        _reconnectTimer?.cancel();
        print('${TAG},✅ 重连成功');
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("${TAG},📌 生命周期变化: $state");

    if (state == AppLifecycleState.resumed) {
      print("${TAG},🔙 App 从后台返回前台");
      _startReconnect();
      // 这里可以重连 MQTT 或执行其他恢复操作
    } else if (state == AppLifecycleState.paused) {
      print("${TAG},🔚 App 进入后台");
      // 可以做释放资源或断开连接

    }
  }
}
