import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';



// https://app-h5.dbsportxxx1zx.com/?token=5deda33ab8cd8b0e198aac566174e11d1c1cb857&tag=01&jz=1&ignore_iframe_pc=1&gr=common&api=F44HJ+atFdYQqXLm85ADtiugr0ZrwutNsM85t6cxNP9Hzf/22TCB/6e++ProM/DCOtWXfg8JnJSNy6Cnjhqp1g==&keep_url=1&pb=1&env=line1&timestamp=1712733101824
// 例url 流程1 URL
const URL1 =
    'https://topic.sportxxx1zx.com/sports-rules/23-app/common/zh_cn?token=a9078f7a06bd879efa3633d3680fd709177409cd&gr=common&theme=theme-1&lang=zh&pb=1&api=F44HJ+atFdYQqXLm85ADttIpMFzIilQuBIFLyvAEXBo=&project=app-h5&topic=https%3A%2F%2Ftopic.sportxxx1zx.com&pb=1&rdm=1708055653519&themeColors=theme02&sty=y0';
// 流程2 URL  无api
const URL2 =
    'https://topic.sportxxx1zx.com/sports-rules/23-app/common/zh_cn?token=a9078f7a06bd879efa3633d3680fd709177409cd&gr=common&theme=theme-1&lang=zh&pb=1&project=app-h5&topic=https%3A%2F%2Ftopic.sportxxx1zx.com&pb=1&rdm=1708055653519&themeColors=theme02&sty=y0';
// 测试
const URL = URL2;
Map BUILDIN_CONFIG = {
  'PROJECT_NAME': 'app-h5',
  'CURRENT_ENV': 'idc_online',
  'DOMAIN_RESULT': null,
  'TOPIC': null,
  'OSS_JSON': null,
  'OSS_FILE_NAME': 'prod.json'
};

// 域名计算结果
DamainModel DOMAIN_RESULT = DamainModel();

// todo
class UrlModel {
  String? domain;
  String? token;
  String? api;
  String? gr;
  String? topic;
  String? theme;
  String? lang;
  String? pb;
  String? env;

  UrlModel({
    this.domain,
    this.token,
    this.api,
    this.gr,
    this.topic,
    this.theme,
    this.lang,
    this.pb,
    this.env,
  });

  UrlModel.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    token = json['token'];
    api = json['api'];
    gr = json['gr'];
    topic = json['topic'];
    theme = json['theme'];
    lang = json['lang'];
    pb = json['pb'];
    env = json['env'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = domain;
    data['token'] = token;
    data['api'] = api;
    data['gr'] = gr;
    data['topic'] = topic;
    data['theme'] = theme;
    data['lang'] = lang;
    data['pb'] = pb;
    data['env'] = env;
    return data;
  }
}

// getUserinfo 接口返回的oss属性model
class OssObj {
  List<String>? api;
  List<String>? chatroomHttpUrl;
  List<String>? chatroomUrl;
  List<String>? img;
  String? live_h5;
  String? live_pc;
  String? loginUrl;
  List<String>? loginUrlArr;

  OssObj(
      {this.api,
        this.chatroomHttpUrl,
        this.chatroomUrl,
        this.img,
        this.live_h5,
        this.live_pc,
        this.loginUrl,
        this.loginUrlArr});

  OssObj.fromJson(Map<String, dynamic> json) {
    api = json['api'].cast<String>();
    chatroomHttpUrl = json['chatroomHttpUrl'].cast<String>();
    chatroomUrl = json['chatroomUrl'].cast<String>();
    img = json['img'].cast<String>();
    live_h5 = json['live_h5'];
    live_pc = json['live_pc'];
    loginUrl = json['loginUrl'];
    loginUrlArr = json['loginUrlArr'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api'] = api;
    data['chatroomHttpUrl'] = chatroomHttpUrl;
    data['chatroomUrl'] = chatroomUrl;
    data['img'] = img;
    data['live_h5'] = live_h5;
    data['live_pc'] = live_pc;
    data['loginUrl'] = loginUrl;
    data['loginUrlArr'] = loginUrlArr;
    return data;
  }
}

class DamainModel {
  //gr
  String gr = "COMMON";

  //最优 API
  String first_one = "";

  //可用 的 api 数组
  List useable_apis = [];

  //全量API 数组
  List full_apis = [];

  // 用户信息接口返回
  late Response getuserinfo_res;

  //live_domains 视频页面地址 vue为数组 这里直接使用字符串 方便取值
  String live_domains = "";

  // 图片域名
  List img_domains = [];
  List jt_static_domains = [];
}

//  待抽离
decodeString(String encodedString) {
  String decodedString = utf8.decode(base64.decode(encodedString));
  var decodedList = Uri.decodeComponent(decodedString);
  return decodedList;
}


/*
   * 通过 域名返回的字符串 计算 真实分组
   */
String compute_exact_group_by_str({str = ''}) {
  // data : "oky\n"
  str = str.toLowerCase();
  String group = "";

  if (str.isEmpty) {
    group = "";
  } else if (str.contains("oky")) {
    group = "Y";
  } else if (str.contains("okb")) {
    group = "B";
  } else if (str.contains("oks")) {
    group = "S";
  } else if (str.contains("ok") || str.contains("okc")) {
    group = "COMMON";
  }

  return group;
}

/*
   * 把一条API 数据组装当前的 分组数据 等
   *
   */
Map<String, dynamic> format_api_to_obj(String api, {String? group}) {
  return {
    'api': api, // 域名
    'group':
    group ?? DOMAIN_RESULT.gr, // 域名分组信息 "COMMON" "GA" + .gr
    'update_time': DateTime.now().millisecondsSinceEpoch,
  };
}



Future myAny(List<Future> list){
  Completer completer = Completer();

  int num = 0;
  for(var u in list){
    u.then((r){
      if (!completer.isCompleted)  completer.complete(u);
    }).catchError((err){
      num ++;
      if(num >= list.length){
        //if (!completer.isCompleted) completer.completeError('all rejected',err);
        if (!completer.isCompleted) completer.completeError('all rejected');
      }
    });
  }
  return completer.future;
}