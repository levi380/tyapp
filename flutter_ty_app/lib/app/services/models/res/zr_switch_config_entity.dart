import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/zr_switch_config_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/zr_switch_config_entity.g.dart';

@JsonSerializable()
///调试zr cp开关 默认关闭cpzr入口  以下值全部改为true  即可打开zr和cp入口
class ZrSwitchConfigEntity {
	late bool cp = false;
	late bool cpH5 = false;
	late bool cpMaintenance = false;
	late bool cpPc = false;
	late bool cpSdk = false;
	late bool cpSwitch = false;
	late bool zr = false;
	late bool zrH5 = false;
	late bool zrMaintenance = false;
	late bool zrPc = false;
	late bool zrSdk = false;
	late bool zrSwitch = false;

	ZrSwitchConfigEntity();

	factory ZrSwitchConfigEntity.fromJson(Map<String, dynamic> json) => $ZrSwitchConfigEntityFromJson(json);

	Map<String, dynamic> toJson() => $ZrSwitchConfigEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}