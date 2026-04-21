class HomeIndexAdsModel {
  String? title;
  String? img; // 图片链接
  String? urlType;// 跳转类型 0=不跳转 1=跳转内部路由 2=跳转外部链接
  String? url;// 跳转地址
  int? startTime;
  int? endTime;
  int? state;
  int? displayState;
  int? seq;// 显示排序值

  HomeIndexAdsModel({
    this.title,
    this.img,
    this.urlType,
    this.url,
    this.startTime,
    this.endTime,
    this.state,
    this.displayState,
    this.seq,
  });

  HomeIndexAdsModel.fromJson(dynamic json) {
    title = json['title'];
    img = json['img'];
    urlType = json['url_type'];
    url = json['url'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    state = json['state'];
    displayState = json['display_state'];
    seq = json['seq'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['img'] = img;
    map['url_type'] = urlType;
    map['url'] = url;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['state'] = state;
    map['display_state'] = displayState;
    map['seq'] = seq;
    return map;
  }
}
