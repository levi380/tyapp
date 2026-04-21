import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext_s.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/config/analytic/analytics_utils.dart';

import '../modules/dj/controllers/dj_controller.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/match_detail/bindings/match_detail_binding.dart';
import '../modules/match_detail/views/match_detail_view.dart';
import '../utils/route_check_util.dart';

/// 非命明路由管理
class RouteManager {
  static goMatchDetail(
      {required String mid,
      String? csid,
      String? playId, // 次要玩法playId
      String? cid, // 玩法集Id
      String? pids, // 次要玩法玩法集
      bool isESports = false}) {
    ///判断是否登录
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;
    // 搜索埋点
    Analytics.track(AnalyticsEvent.card_match_odds, pagePath: '', clickTarget: (AnalyticsEvent.card_match_odds).toString());
    Get.to(
        () => MatchDetailView(
              tag: mid,
            ),
        routeName: Routes.matchDetail,
        binding: MatchDetailBinding(tag: mid),
        arguments: {
          'mid': mid,
          'csid': csid,
          'playId': playId,
          'cid': cid,
          'pids': pids,
          'isESports': isESports,
        })?.then((value) {
      WidgetsBinding.instance.endOfFrame.then((v) {
        String currentRoute = Get.currentRoute;
        if (currentRoute == Routes.DJView) {
          DJController.to.getDateList(isLoading: false);
        } else if ([Routes.mainTab, Routes.homeView].contains(currentRoute)) {
          // SecondaryController.clearMap();
          ///更新数据
          TyHomeController.to.fetchData(isWsFetch: true);
        }
      });
    });
  }

  // 详情切换
  static replaceMatchDetail(
      {required String mid, String? csid, bool isESports = false}) {
    if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;

    Navigator.of(Get.context!)
        .pushReplacement(
      GetPageRoute(
        page: () => MatchDetailView(tag: mid),
        binding: MatchDetailBinding(tag: mid),
        settings: RouteSettings(
          name: Routes.matchDetail,
          arguments: {
            'mid': mid,
            'csid': csid,
            'isESports': isESports,
          },
        ),
        transitionDuration: Duration.zero,
        transition: Transition.noTransition,
        popGesture: true,
      ),
    )
        .then(
      (value) {
        WidgetsBinding.instance.endOfFrame.then(
          (v) {
            String currentRoute = Get.currentRoute;
            if (currentRoute == Routes.DJView) {
              DJController.to.getDateList(isLoading: false);
            } else if ([Routes.mainTab, Routes.homeView]
                .contains(currentRoute)) {
              TyHomeController.to.fetchData(isWsFetch: true);
            }
          },
        );
      },
    );
  }
}
