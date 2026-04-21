import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/fireworks_activity_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/fireworks_activity_entity.g.dart';

@JsonSerializable()
class FireworksActivityEntity {
	/**
	 * 活动状态(0:关闭,1:开启)
	 */
	late int activityStatus;
	/**
	 * 活动标题
	 */
	late String activityTitle;
	/**
	 * 活动类型(1:定时播放烟花)
	 */
	late int activityType;
	/**
	 * 活动开始时间
	 */
	late String beginTime;
	dynamic codeList;
	late String createBy;
	late String createTime;
	/**
	 * 展示设备类型(0:全部,1:PC亚洲版,2:移动端亚洲版包含h5新版/sdk/ipad,3:PC欧洲版,4:H5欧洲版)
	 */
	late String deviceType;

	dynamic deviceTypeList;
	/**
	 * 活动结束时间
	 */
	late String endTime;
	/**
	 * 烟花款式
	 */
	late int fireworksType;
	late String id;
	late List<FireworksActivityLanguageReqList> languageVOList = [];
	/**
	 * 活动logo
	 */
	late String logo;
	late String merchantCode;
	/**
	 * 播放方式(0:仅一次,1:连续播放三次,2:循环播放)
	 */
	late int playType;
	late String updateBy;
	late String updateTime;

	FireworksActivityEntity();

	factory FireworksActivityEntity.fromJson(Map<String, dynamic> json) => $FireworksActivityEntityFromJson(json);

	Map<String, dynamic> toJson() => $FireworksActivityEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FireworksActivityLanguageReqList {
	/**
	 * 语种
	 */
	late String languageType;
	/**
	 * 烟花活动文案说明
	 */
	late String copyDesc;

	FireworksActivityLanguageReqList();

	factory FireworksActivityLanguageReqList.fromJson(Map<String, dynamic> json) => $FireworksActivityLanguageReqListFromJson(json);

	Map<String, dynamic> toJson() => $FireworksActivityLanguageReqListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}