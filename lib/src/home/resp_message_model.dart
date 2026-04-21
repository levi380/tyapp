import 'package:filbet/src/home/appconfig_model.dart';

/// d : [{"id":"2885849965656019388","title":"会员端测试-通知消息","content":"这是一条通知类型的测试消息。","message_type":1,"image_url_app":"","image_url_web":"","jump_type":0,"jump_config":"","devices":[24,25,26,27],"is_top":0,"publish_time":1768976911,"created_at":1768976911,"published_at":1768976912,"read_state":"0"}]
/// t : 10
/// s : 10
/// unread_count : 8

class RespMessageModel {
  RespMessageModel({
    this.d,
    this.t,
    this.s,
    this.unreadCount,
    this.scroll,
  });

  RespMessageModel.fromJson(dynamic json) {
    if (json['d'] != null) {
      d = [];
      json['d'].forEach((v) {
        d?.add(NoticeModel.fromJson(v));
      });
    }
    t = json['t'];
    s = json['s'];
    unreadCount = json['unread_count'];
    scroll = json['scroll'];
  }

  List<NoticeModel>? d;
  num? t;
  num? s;
  num? unreadCount;
  String? scroll;
}

