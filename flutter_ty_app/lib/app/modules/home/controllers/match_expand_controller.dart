import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-2bb81bd0-39de-4ec2-bb5c-ea27b888e48c-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表折叠展开逻辑管理类 】】】
    【【【 AUTO_DOCUMENT_TITLE 业务逻辑 FoldMatchManager 】】】
    【【【 AUTO_PARAGRAPH_TITLE 逻辑工具类 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
     - 首页列表折叠展开管理器
     ```
     /// 折叠展开比赛管理器
class FoldMatchManager {
  /// 存储已折叠比赛的tid
  static Set<String> _foldTids = {};

  /// 检查指定tid的比赛是否已折叠
  /// 
  /// [key] - 比赛的唯一标识
  /// [section] - 比赛所属的分组
  /// 返回是否已折叠
  static bool isFoldByTid(String key, SectionGroupEnum section) {
    return _foldTids.contains(key + section.name);
  }

  /// 设置指定tid的比赛是否折叠
  /// 
  /// [key] - 比赛的唯一标识
  /// [section] - 比赛所属的分组
  /// [isFold] - 是否折叠
  static void setFoldByTid(String key, SectionGroupEnum section, bool isFold) {
    if (isFold) {
      _foldTids.add(key + section.name);
    } else {
      _foldTids.remove(key + section.name);
    }
  }

  /// 清除所有已折叠的比赛tid
  static void clearFoldTids() {
    _foldTids.clear();
  }

  /// 存储分组是否折叠的状态
  static Map<SectionGroupEnum, bool> groupFold = {};

  /// 清除所有分组折叠状态
  static void clearGroupFold() {
    groupFold.clear();
  }

  /// 检查指定分组是否已折叠
  /// 
  /// [group] - 分组枚举
  /// 返回是否已折叠
  static bool isGroupFold(SectionGroupEnum group) {
    return groupFold[group] ?? false;
  }

  /// 设置指定分组是否折叠
  /// 
  /// [group] - 分组枚举
  /// [isExpand] - 是否折叠
  static void setGroupFold(SectionGroupEnum group, bool isExpand) {
    groupFold[group] = isExpand;
  }

///冠军引导折叠的玩法id hid
  static Set<String> _foldHids = {};

  /// 检查指定hid的比赛是否已折叠
  static bool isFoldByHid(String tid, String hid) {
    return _foldHids.contains(tid + hid);
  }

  /// 设置指定hid的比赛是否折叠
  static void setFoldByHid(String tid, String hid, bool isFold) {
    if (isFold) {
      _foldHids.add(tid + hid);
    } else {
      _foldHids.remove(tid + hid);
    }
  }
  static void clearHids() {
    _foldHids.clear();
  }

  ///是否展示“更多”，冠军引导的玩法id hid
  static Set<String> _foldHidsMore = {};

  /// 检查指定hid的比赛是否已折叠
  static bool isFoldByHidMore(String tid, String hid) {
    return _foldHidsMore.contains(tid + hid);
  }

  /// 设置指定hid的比赛是否折叠
  static void setFoldByHidMore(String tid, String hid, bool isFold) {
    if (isFold) {
      _foldHidsMore.add(tid + hid);
    } else {
      _foldHidsMore.remove(tid + hid);
    }
  }
  static void clearHidsMore() {
    _foldHidsMore.clear();
  }
}
     ```
    】】】
 *
 */

/// 折叠展开比赛管理器
class FoldMatchManager {
  /// 存储已折叠比赛的tid
  static Set<String> _foldTids = {};

  /// 检查指定tid的比赛是否已折叠
  /// 
  /// [key] - 比赛的唯一标识
  /// [section] - 比赛所属的分组
  /// 返回是否已折叠
  static bool isFoldByTid(String key, SectionGroupEnum section) {
    return _foldTids.contains(key + section.name);
  }

  /// 设置指定tid的比赛是否折叠
  /// 
  /// [key] - 比赛的唯一标识
  /// [section] - 比赛所属的分组
  /// [isFold] - 是否折叠
  static void setFoldByTid(String key, SectionGroupEnum section, bool isFold) {
    if (isFold) {
      _foldTids.add(key + section.name);
    } else {
      _foldTids.remove(key + section.name);
    }
  }

  /// 清除所有已折叠的比赛tid
  static void clearFoldTids() {
    _foldTids.clear();
  }

  /// 存储分组是否折叠的状态
  static Map<SectionGroupEnum, bool> groupFold = {};

  /// 清除所有分组折叠状态
  static void clearGroupFold() {
    groupFold.clear();
  }

  /// 检查指定分组是否已折叠
  /// 
  /// [group] - 分组枚举
  /// 返回是否已折叠
  static bool isGroupFold(SectionGroupEnum group) {
    return groupFold[group] ?? false;
  }

  /// 设置指定分组是否折叠
  /// 
  /// [group] - 分组枚举
  /// [isExpand] - 是否折叠
  static void setGroupFold(SectionGroupEnum group, bool isExpand) {
    groupFold[group] = isExpand;
  }

///冠军引导折叠的玩法id hid
  static Set<String> _foldHids = {};

  /// 检查指定hid的比赛是否已折叠
  static bool isFoldByHid(String tid, String hid) {
    return _foldHids.contains(tid + hid);
  }

  /// 设置指定hid的比赛是否折叠
  static void setFoldByHid(String tid, String hid, bool isFold) {
    if (isFold) {
      _foldHids.add(tid + hid);
    } else {
      _foldHids.remove(tid + hid);
    }
  }
  static void clearHids() {
    _foldHids.clear();
  }

  ///是否展示“更多”，冠军引导的玩法id hid
  static Set<String> _foldHidsMore = {};

  /// 检查指定hid的比赛是否已折叠
  static bool isFoldByHidMore(String tid, String hid) {
    return _foldHidsMore.contains(tid + hid);
  }

  /// 设置指定hid的比赛是否折叠
  static void setFoldByHidMore(String tid, String hid, bool isFold) {
    if (isFold) {
      _foldHidsMore.add(tid + hid);
    } else {
      _foldHidsMore.remove(tid + hid);
    }
  }
  static void clearHidsMore() {
    _foldHidsMore.clear();
  }
}
