import 'package:filbet/src/activity/model/image_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'dart:convert';

class ActivityTypeModel {
/*
{
  "ty": 1,
  "name": "实时返水"
  "sort": 1000,
}
*/
  int? id;
  String? name;
  int? sort;
  String? icon;
  String? icon_light;
  num? color_num;
  String? iconName;
  RxList<ActivityModel> activityList = <ActivityModel>[].obs;

  ActivityTypeModel({
    this.id,
    this.sort,
    this.name,
  });

  ActivityTypeModel.fromJson(dynamic json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    sort = int.tryParse(json['sort']?.toString() ?? '');
    name = json['name']?.toString();
    icon = json['icon'];
    icon_light = json['icon_light'];
    color_num = json['color_num'];
    iconName = json['icon_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['sort'] = sort;
    data['name'] = name;
    return data;
  }
}

class ActivityModel {
/*
{
  "id": "1",
  "name": "盲合活动",
  "ty": 1,
  "display": 1,
  "display_start_at": 0,
  "display_end_at": 0,
  "state": 1,
  "config": "{\"is_active\": true, \"auto_approve\": true, \"daily_budget\": \"1250\", \"max_bonus_rate\": \"0.002\", \"min_bonus_rate\": \"0.001\", \"turnover_multiplier\": \"1\"}",
  "start_at": 1748185200,
  "end_at": 1748185200,
  "client_type": "[]",
  "multiple": "1.00",
  "recommend": 2,
  "automatic": 2,
  "sort": 1000,
  "images": "/promo/welfare_list_mystery.webp",
  "summary": "1",
  "detail_image": 1,
  "display_type": 1,
  "updated_name": "地方"
}
*/

  String? id;
  String? name;
  int? ty;
  int? display;
  int? displayStartAt;
  int? displayEndAt;
  int? state;
  String? config;
  int? startAt;
  int? endAt;
  String? clientType;
  String? multiple;
  int? recommend;
  int? automatic;
  int? sort;
  String? images;
  String? summary;
  int? detailImage;
  int? displayType;
  String? updatedName;
  int? updatedAt;
  int? tag_type;
  int? applyPart; //申请参与 1.是 2.否
  num? apply_mode;
  String? platform_ids;
  num? activityCycle;
  ActivityConfigModel? activityConfigModel;
  ImageModel? imageModel;
  String? h5Summary;

  ActivityModel({
    this.id,
    this.name,
    this.ty,
    this.display,
    this.displayStartAt,
    this.displayEndAt,
    this.state,
    this.config,
    this.startAt,
    this.endAt,
    this.clientType,
    this.multiple,
    this.recommend,
    this.automatic,
    this.sort,
    this.images,
    this.summary,
    this.detailImage,
    this.displayType,
    this.updatedName,
    this.updatedAt,
    this.tag_type,
  });

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    ty = int.tryParse(json['ty']?.toString() ?? '');
    display = int.tryParse(json['display']?.toString() ?? '');
    displayStartAt = int.tryParse(json['display_start_at']?.toString() ?? '');
    displayEndAt = int.tryParse(json['display_end_at']?.toString() ?? '');
    state = int.tryParse(json['state']?.toString() ?? '');
    config = json['config'];
    startAt = int.tryParse(json['start_at']?.toString() ?? '');
    endAt = int.tryParse(json['end_at']?.toString() ?? '');
    clientType = json['client_type']?.toString();
    multiple = json['multiple']?.toString();
    recommend = int.tryParse(json['recommend']?.toString() ?? '');
    automatic = int.tryParse(json['automatic']?.toString() ?? '');
    sort = int.tryParse(json['sort']?.toString() ?? '');
//    images = jsonDecode(json['images'])["h5_main"] ?? "";
    images = json['images'] ?? "";
    summary = json['summary']?.toString();
    h5Summary = json['h5_summary']?.toString();
    detailImage = int.tryParse(json['detail_image']?.toString() ?? '');
    displayType = int.tryParse(json['display_type']?.toString() ?? '');
    updatedName = json['updated_name']?.toString();
    updatedAt = int.tryParse(json['updated_at']?.toString() ?? '');

    tag_type = json['tag_type'];
    applyPart = json['apply_part'];
    apply_mode = json['apply_mode'];
    platform_ids = json['platform_ids'];
    activityCycle = json['activity_cycle'];
    try {
      activityConfigModel =
          ActivityConfigModel.fromJson(jsonDecode(config ?? ''));
      if (images != null) {
        imageModel = ImageModel.fromJson(jsonDecode(images ?? ''));
      }
    } catch (e) {
    }
  }

  String parseH5(dynamic imagesJson) {
    try {
      if (imagesJson == null) return "";
      if (imagesJson is Map<String, dynamic>) {
        return imagesJson["h5"] ?? "";
      }
      if (imagesJson is String && imagesJson.isNotEmpty) {
        final decoded = jsonDecode(imagesJson);
        if (decoded is Map<String, dynamic>) {
          return decoded["h5"] ?? "";
        }
      }
    } catch (_) {
      // 忽略任何解析错误
    }
    return "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['ty'] = ty;
    data['display'] = display;
    data['display_start_at'] = displayStartAt;
    data['display_end_at'] = displayEndAt;
    data['state'] = state;
    data['config'] = config;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    data['client_type'] = clientType;
    data['multiple'] = multiple;
    data['recommend'] = recommend;
    data['automatic'] = automatic;
    data['sort'] = sort;
    data['images'] = images;
    data['summary'] = summary;
    data['detail_image'] = detailImage;
    data['display_type'] = displayType;
    data['updated_name'] = updatedName;
    return data;
  }
}

class ActivityConfigModel {
  int? applyEnter;
  int? applyRecord;
  int? contentType;
  String? applySuccessAlertText;
  String? applySuccessAlertTitle;

  ActivityConfigModel({
    this.applyEnter,
    this.applyRecord,
    this.contentType,
  });

  ActivityConfigModel.fromJson(Map<String, dynamic> json) {
    applyEnter = json['apply_enter'];
    applyRecord = json['apply_record'];
    contentType = json['content_type'];
    applySuccessAlertText = json['apply_success_alert_text'];
    applySuccessAlertTitle = json['apply_success_alert_title'];
  }
}

class Images {
  final String? h5;
  final String? pc;

  Images({this.h5, this.pc});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      h5: json['h5'] as String?,
      pc: json['pc'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'h5': h5,
        'pc': pc,
      };
}
