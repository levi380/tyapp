import 'dart:convert';

/// game_id : "2001"
/// game_type : "1"
/// id : "107"
/// name : "SK真人"
/// venue_id : "107"

class JumpConfigModel {
  JumpConfigModel({
    this.gameId,
    this.gameType,
    this.id,
    this.name,
    this.venueId,
  });

  JumpConfigModel.fromJson(dynamic json) {
    gameId = json['game_id'];
    gameType = json['game_type'];
    id = json['id'];
    name = json['name'];
    venueId = json['venue_id'];
    linkType = '${json['link_type']}';
    try {
      url = json['url'];
    } catch (e) {
      print('object123456 url=$e');
    }

    route = json['route'];
    activityId = json['activity_id'];
    ty = json['ty'];
    if (linkType == '0') {
      if (url != null) {
        try {
          print("object123456 url=$url");
          // url 可能是 Map（{pc,h5,app}）也可能是 String
          if (url is Map) {
            final map = (url as Map).map((k, v) => MapEntry('$k', v));
            final dynamic candidate = map['app'];
            appUrl = candidate?.toString();
          } else {
            appUrl = url.toString();
          }
        } catch (e) {
          print("object123456 appUrl=$e");
        }
      }
    }
  }

  String? gameId;
  String? gameType;
  String? id;
  String? name;
  String? venueId;
  String? linkType;
  dynamic url;
  String? route;
  String? activityId;
  int? ty;
  String? appUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['game_id'] = gameId;
    map['game_type'] = gameType;
    map['id'] = id;
    map['name'] = name;
    map['venue_id'] = venueId;
    return map;
  }
}
