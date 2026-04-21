import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/cp_ticket_cate_entity.dart';

CpTicketCateEntity $CpTicketCateEntityFromJson(Map<String, dynamic> json) {
  final CpTicketCateEntity cpTicketCateEntity = CpTicketCateEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    cpTicketCateEntity.id = id;
  }
  final List<CpTicketCateList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<CpTicketCateList>(e) as CpTicketCateList)
      .toList();
  if (list != null) {
    cpTicketCateEntity.list = list;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    cpTicketCateEntity.name = name;
  }
  final int? seriesKind = jsonConvert.convert<int>(json['seriesKind']);
  if (seriesKind != null) {
    cpTicketCateEntity.seriesKind = seriesKind;
  }
  return cpTicketCateEntity;
}

Map<String, dynamic> $CpTicketCateEntityToJson(CpTicketCateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  data['name'] = entity.name;
  data['seriesKind'] = entity.seriesKind;
  return data;
}

extension CpTicketCateEntityExtension on CpTicketCateEntity {
  CpTicketCateEntity copyWith({
    String? id,
    List<CpTicketCateList>? list,
    String? name,
    int? seriesKind,
  }) {
    return CpTicketCateEntity()
      ..id = id ?? this.id
      ..list = list ?? this.list
      ..name = name ?? this.name
      ..seriesKind = seriesKind ?? this.seriesKind;
  }
}

CpTicketCateList $CpTicketCateListFromJson(Map<String, dynamic> json) {
  final CpTicketCateList cpTicketCateList = CpTicketCateList();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    cpTicketCateList.code = code;
  }
  final bool? isCollect = jsonConvert.convert<bool>(json['isCollect']);
  if (isCollect != null) {
    cpTicketCateList.isCollect = isCollect;
  }
  final String? ticketId = jsonConvert.convert<String>(json['ticketId']);
  if (ticketId != null) {
    cpTicketCateList.ticketId = ticketId;
  }
  final String? ticketName = jsonConvert.convert<String>(json['ticketName']);
  if (ticketName != null) {
    cpTicketCateList.ticketName = ticketName;
  }
  return cpTicketCateList;
}

Map<String, dynamic> $CpTicketCateListToJson(CpTicketCateList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['isCollect'] = entity.isCollect;
  data['ticketId'] = entity.ticketId;
  data['ticketName'] = entity.ticketName;
  return data;
}

extension CpTicketCateListExtension on CpTicketCateList {
  CpTicketCateList copyWith({
    String? code,
    bool? isCollect,
    String? ticketId,
    String? ticketName,
  }) {
    return CpTicketCateList()
      ..code = code ?? this.code
      ..isCollect = isCollect ?? this.isCollect
      ..ticketId = ticketId ?? this.ticketId
      ..ticketName = ticketName ?? this.ticketName;
  }
}