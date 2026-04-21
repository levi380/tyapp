import 'package:get/get.dart';

enum PlatformUnit {
  table,
  field,
  kind;

  String get value {
    switch (this) {
      case PlatformUnit.table:
        return "platform_unit_table".tr;
      case PlatformUnit.field:
        return "platform_unit_field".tr;
      case PlatformUnit.kind:
        return "platform_unit_kind".tr;
    }
  }
}

