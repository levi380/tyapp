import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_api_service.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:rxdart/rxdart.dart';

import '../controllers/match_detail_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-9e9d1afb-12a9-4217-9f95-6bd304e51513 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 限频节流】】】
    【【【 AUTO_PARAGRAPH_TITLE 详情限频节流处理相关】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 在ws推送，关联请求http或者页面ui刷新太频繁，则需要进行限频节流
    - 主要对C303 以及 http请求的玩法集和投注列表接口 进行限频节流
    】】】
 *
 */
extension DetailThrottleExtension on MatchDetailController {
  initThrottle() {
    detailState.throttleCategoryList = detailState.throttleCategoryListSubject
        .throttleTime(const Duration(milliseconds: 3000),
            trailing: true, leading: false) // 后置节流
        .listen((_) {
      if (isClosed) {
        return;
      }
      fetchCategoryList();
    });

    detailState.throttleOddsInfo = detailState.throttleOddsInfoSubject
        .throttleTime(const Duration(milliseconds: 3000),
            trailing: true, leading: false) // 后置节流
        .listen((_) {
      if (isClosed) {
        return;
      }
      refreshOddsInfoData(refresh: true, noLoading: true);
    });

    /// 一秒限流
    detailState.throttleOddsInfoWithOneSecond = detailState
        .throttleOddsInfoSubjectWithOneSecond
        .throttleTime(const Duration(milliseconds: 1000),
            trailing: true, leading: false) // 后置节流
        .listen((_) {
      if (isClosed) {
        return;
      }
      refreshOddsInfoData(refresh: true, noLoading: true);
    });
  }
}
