import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/discount_odd_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


DiscountOddEntity $DiscountOddEntityFromJson(Map<String, dynamic> json) {
  final DiscountOddEntity discountOddEntity = DiscountOddEntity();
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    discountOddEntity.count = count;
  }
  final List<MatchEntity>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MatchEntity>(e) as MatchEntity).toList();
  if (data != null) {
    discountOddEntity.data = data;
  }
  return discountOddEntity;
}

Map<String, dynamic> $DiscountOddEntityToJson(DiscountOddEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['count'] = entity.count;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

extension DiscountOddEntityExtension on DiscountOddEntity {
  DiscountOddEntity copyWith({
    int? count,
    List<MatchEntity>? data,
  }) {
    return DiscountOddEntity()
      ..count = count ?? this.count
      ..data = data ?? this.data;
  }
}