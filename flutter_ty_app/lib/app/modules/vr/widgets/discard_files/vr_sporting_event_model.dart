

/// VR 体育赛事模型
/// 用于定义赛事列表中的每一项数据结构
class VrSportingEventModel {
  /// 默认状态下的图片资源名称
  final String imgName;

  /// 选中状态下的图片资源名称
  final String imgNameSel;

  /// 赛事名称
  final String eventName;

  /// 未读消息数量
  final int unreadCount;

  /// 构造函数
  /// [imgName] 默认图片名称
  /// [imgNameSel] 选中图片名称
  /// [eventName] 赛事名称
  /// [unreadCount] 未读数，默认为 0
  VrSportingEventModel({
    this.imgName = '',
    this.imgNameSel = '',
    this.eventName = '',
    this.unreadCount = 0,
  });

  /// 从 JSON 数据创建模型实例
  /// [json] Map<String, dynamic> 类型的数据源
  factory VrSportingEventModel.fromJson(Map<String, dynamic> json) =>
      VrSportingEventModel(
        imgName: json['imgName'] ?? '',
        imgNameSel: json['imgNameSel'] ?? '',
        eventName: json['eventName'] ?? '',
        unreadCount: json['unreadCount'] ?? 0,
      );

  /// 将模型转换为 JSON 数据
  Map<String, dynamic> toJson() => {
        'imgName': imgName,
        'imgNameSel': imgNameSel,
        'eventName': eventName,
        'unreadCount': unreadCount,
      };

  /// 复制当前对象并支持修改部分属性
  VrSportingEventModel copyWith({
    String? imgName,
    String? imgNameSel,
    String? eventName,
    int? unreadCount,
  }) {
    return VrSportingEventModel(
      imgName: imgName ?? this.imgName,
      imgNameSel: imgNameSel ?? this.imgNameSel,
      eventName: eventName ?? this.eventName,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  String toString() {
    return 'VrSportingEventModel(imgName: $imgName, imgNameSel: $imgNameSel, eventName: $eventName, unreadCount: $unreadCount)';
  }
}
