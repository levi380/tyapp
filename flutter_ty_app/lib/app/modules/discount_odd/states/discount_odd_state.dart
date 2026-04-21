
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../login/login_head_import.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 增值赔率】】】
    【【【 AUTO_PARAGRAPH_TITLE 增值赔率】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 增值赔率state
    】】】
 *
 */
class DiscountOddState{
  /// 新增优惠赔率
  List<MatchEntity> matchtDiscount = [];
  List<List<MatchEntity>> matchtDiscountMerge = [];
  ///折叠列表
  Set<String> foldList = <String>{};
  // ListView滚动空间
  final ScrollController scrollController = ScrollController();

  RxBool isHot = (BoolKV.sort.get() ?? true).obs;
  //是否全部展开
  var isExpand = true.obs;

  // 动画控制器
  late AnimationController animationController;
  // 是否需要重新载入
  bool needReload = true;
  // 时间timer
  Timer? timer;
  // 是否空的
  int isEmptyTimer=0;
}