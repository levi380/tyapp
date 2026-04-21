import 'dart:collection';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/get_x_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext_s.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/match_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';

import '../../../services/models/res/match_entity.dart';
import '../../../utils/menu_util.dart';
import '../../../utils/route_check_util.dart';
import '../widgets/menu/league/hotLeagueController.dart';
import 'collection_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-909fb8e7-eb95-4882-8520-befd7836e3e7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  置顶数据全局管理类 】】】
    【【【 AUTO_PARAGRAPH_TITLE 置顶数据管理入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT 
  - 全局置顶数据管理类，用于管理置顶的联赛和赛事数据
  - 通过调用接口获取置顶数据，判断联赛和赛事是否置顶，置顶或取消置顶联赛和赛事
  - 通过接口获取置顶数列表
    】】】
*
*/
class PinController extends GetxController {
  /// 联赛置顶的但赛事不置顶的mid
  LinkedHashSet<int> _pinCmidSet = LinkedHashSet<int>();

  /// 当前置顶的赛事列表
  List<MatchEntity> _pinList = [];

  /// 置顶的联赛mid
  LinkedHashSet<int> _pinMidSet = LinkedHashSet<int>();

  /// 置顶的联赛id
  LinkedHashSet<int> _pinTidSet = LinkedHashSet<int>();

  @override
  void onInit() {
    super.onInit();
  }

  static PinController? get to => Get.findOrNull<PinController>();

  /// 判断联赛是否置顶
  bool isLeaguePin(int tid) {
    return _pinTidSet.contains(tid);
  }

  /// 判断赛事是否置顶
  bool isMatchPin(MatchEntity match) {
    /// 赛事置顶
    bool isPin = _pinMidSet.contains(match.mid.toInt());
    if (!isPin) {
      /// 联赛置顶
      bool isLeaguePined = isLeaguePin(match.tid.toInt());
      if (isLeaguePined) {
        /// 联赛置顶，赛事不置顶
        isPin = !_pinCmidSet.contains(match.mid.toInt());
      }
    }
    return isPin;
  }

  List<MatchEntity> pinMatchList() {
    return _pinList;
  }
  /// 清除置顶数据
  void clearPin() {
    _pinList.clear();
    _pinMidSet.clear();
    _pinTidSet.clear();
    _pinCmidSet.clear();
    update();
  }
}

/// api调用扩展
extension PinControllerApi on PinController {
  /// 刷新
  Future refreshPin() async {
    try {
      await Future.wait([
        fetchPinList(),
        fetchPinTidAndMid(),
      ]);
    } catch (e) {
      // TODO
    }
  }

  /// 获取置顶的列表
  Future<void> fetchPinList() async {
    try {
      int lastMaxCount = _pinList.length;
      int lastTidCOunt = countTidCount(_pinList);
      final res = await MatchApi.instance().findTopMatchsPB(
        menuId: _getMenuId(),
        mType: _getMenuType(),
        md: _getMd(),
        mLeve3: _getEuid(),
        h5Collect: 0,
      );
      if (res.success) {
        _pinList.clear();
        _pinList.addAll(res.data ?? []);

        ///这里加判断，否则电竞的置顶数据会在首页出现
        if (Get.currentRoute == Routes.DJView) {
          DJController.to.update();
          if (!DJController.to.djScrollController.hasClients ||
              DJController.to.djScrollController.positions.isEmpty) return;
          Future.delayed(Duration(milliseconds: 0), () {
            if (DJController.to.djScrollController.offset <= 0) return;
            int diff = _pinList.length - lastMaxCount;
            int diffHeader = countTidCount(_pinList) - lastTidCOunt;

            double itemH = TyHomeController.to.homeState.isProfess ? 235 : 170;
            double headerH = TyHomeController.to.homeState.isProfess ? 120 : 60;
            double offset = DJController.to.djScrollController.offset +
                diff * (itemH - headerH) +
                diffHeader * headerH;
            if (offset <= 0) return;
            DJController.to.djScrollController.jumpTo(offset);
          });
        } else {
          try {
            if (TyHomeController.to.homeState.combineList.isNotEmpty) {
              TyHomeController.to.handleData();
              if (!TyHomeController.to.commonScrollController.hasClients ||
                  TyHomeController.to.commonScrollController.positions.isEmpty)
                return;
              Future.delayed(Duration(milliseconds: 0), () {
                if (TyHomeController.to.commonScrollController.offset <= 0)
                  return;
                int diff = _pinList.length - lastMaxCount;
                double itemH =
                    TyHomeController.to.homeState.isProfess ? 235 : 170;
                double offset =
                    TyHomeController.to.commonScrollController.offset +
                        diff * itemH;

                double oddsHeight =
                    TyHomeController.to.homeState.matchtDiscount.isNotEmpty
                        ? 96.w
                        : 0;
                if (offset <= 0) return;
                TyHomeController.to.commonScrollController.jumpTo(
                    TyHomeController.to.commonScrollController.offset +
                        diff * itemH +
                        oddsHeight);
              });
            }
          } catch (e) {
            // TODO
          }
        }
      }
    } catch (e) {
      AppLogger.error(e, tag: 'fetchPinList error');
    }
  }

  ///简化过滤
  int countTidCount(List<MatchEntity> pinList) {
    return pinList.map((e) => e.tid).toSet().length;
  }

  /// 获取置顶的tid和mid
  Future<void> fetchPinTidAndMid() async {
    try {
      _pinTidSet.clear();
      _pinMidSet.clear();
      _pinCmidSet.clear();
      final res = await MatchApi.instance().findTopIdsPB(
          menuId: _getMenuId(),
          mType: _getMenuType(),
          mLeve3: _getEuid(),
          h5Collect: 0);
      if (res.success) {
        _pinTidSet.addAll(res.data!.tIds.map((e) => e.toInt()));
        _pinMidSet.addAll(res.data!.mIds.map((e) => e.toInt()));

        _pinCmidSet.addAll(res.data!.cMids.map((e) => e.toInt()));
      }
      update();
    } catch (e) {
      AppLogger.debug('fetchPinTidAndMid error: $e');
    }
  }

  /// 置顶联赛
  Future<void> toggleLeaguePin(String tid, {bool isDjInCommon = false}) async {
    try {
      ///判断是否登录
      if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;
      bool isPin = isLeaguePin(tid.toInt());
      final res;
      if (isDjInCommon) {
        res = await MatchApi.instance().leagueTopPB(
            status: isPin ? 1 : 0,
            tId: tid,
            matchId: null,
            menuId: _getMenuId(),
            mType: _getMenuType(),
            cuid: TYUserController.to.getUid(),
            mLeve3: _getEuid(),
            h5Collect: 0,
            matchType: 1);
      } else {
        res = await MatchApi.instance().leagueTopPB(
          status: isPin ? 1 : 0,
          tId: tid,
          matchId: null,
          menuId: _getMenuId(),
          mType: _getMenuType(),
          cuid: TYUserController.to.getUid(),
          mLeve3: _getEuid(),
          h5Collect: 0,
        );
      }
      if (Get.currentRoute == Routes.DJView) {
        CollectionController.to.getDJCollectCount();
      } else {
        CollectionController.to.fetchCollectionCount();
      }
      if (res.success) {
        /// 体育列表
        if (!isDjInCommon) {
          /// 置顶
          if (!isPin) {
            /// 置顶联赛
            FoldMatchManager.setFoldByTid(
              tid,
              SectionGroupEnum.Pin,
              true,
            );

            /// 如果置顶列表为空，说明首次置顶，则折叠置顶分组
            if (_pinList.isEmpty) {
              FoldMatchManager.setGroupFold(SectionGroupEnum.Pin, true);
            }
          }
        }
        refreshPin();
        // if (Get.currentRoute != Routes.DJView) {
        CollectionController.to.updateCollection();
        // }
      } else {
        AppLogger.debug("联赛 res.msg! = " + res.msg);
        if (!ObjectUtil.isEmptyString(res.msg)) {
          ToastUtils.show(res.msg!);
        }
      }
    } catch (e) {
      AppLogger.debug('toggleLeaguePin error: $e');
    }
  }

  /// 置顶赛事
  Future<void> toggleMatchPin(MatchEntity match,
      {bool isDjInCommon = false}) async {
    try {
      ///判断是否登录
      if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;
      bool isPin = isMatchPin(match);
      final res;
      if (isDjInCommon) {
        res = await MatchApi.instance().leagueTopPB(
            status: isPin ? 1 : 0,
            tId: null,
            matchId: match.mid,
            menuId: _getMenuId(),
            mType: _getMenuType(),
            cuid: TYUserController.to.getUid(),
            mLeve3: _getEuid(),
            h5Collect: 0,
            matchType: 1);
      } else {
        res = await MatchApi.instance().leagueTopPB(
          status: isPin ? 1 : 0,
          tId: null,
          matchId: match.mid,
          menuId: _getMenuId(),
          mType: _getMenuType(),
          cuid: TYUserController.to.getUid(),
          mLeve3: _getEuid(),
          h5Collect: 0,
        );
      }
      if (Get.currentRoute == Routes.DJView) {
        CollectionController.to.getDJCollectCount();
      } else {
        CollectionController.to.fetchCollectionCount();
      }
      if (res.success) {
        /// 体育列表
        if (!isDjInCommon) {
          /// 置顶
          if (isPin) {
            /// 置顶赛事
            FoldMatchManager.setFoldByTid(
              match.tid,
              SectionGroupEnum.Pin,
              true,
            );
            if (_pinList.isEmpty) {
              FoldMatchManager.setGroupFold(SectionGroupEnum.Pin, true);
            }
          }
        }

        refreshPin();

        CollectionController.to.updateCollection();

        /// 更新可视化的数据
        if (Get.currentRoute != Routes.DJView) {
          TyHomeController.to.refreshData();
        }
      } else {
        AppLogger.debug("赛事 res.msg! = " + res.msg);
        if (!ObjectUtil.isEmptyString(res.msg)) {
          ToastUtils.show(res.msg!);
        }
      }
    } catch (e) {
      AppLogger.debug('toggleMatchPin error: $e');
    }
  }
}

extension PinControllerPrivate on PinController {
  int _getMenuId() {
    /// 判断当前路由为电竞
    if (Get.currentRoute == Routes.DJView) {
      return 4;
    } else {
      return TyHomeController.to.homeState.menu.munuId;
    }
  }

  /// 获取菜单类型
  int _getMenuType() {
    // 判断当前路由是否为电竞视图
    if (Get.currentRoute == Routes.DJView) {
      // 从DJController获取菜单类型
      int mType = DJController.to.DJState.djListReq.csid.toInt();
      // 记录日志
      AppLogger.debug("md == " + mType.toString());
      if (DJController.to.isCollect()) {
        mType = 0;
      }
      return mType;
    } else {
      // 从TyHomeController获取菜单类型
      String mi = TyHomeController.to.homeState.sportId;
      // 使用MenuUtil将mi转换为CSID
      return MenuUtil.getCSIDFromMi(mi.toInt()).toInt();
    }
  }

  /// 获取MD值
  String _getMd() {
    // 判断当前路由是否为电竞视图
    if (Get.currentRoute == Routes.DJView) {
      // 如果是电竞视图，返回空字符串
      return '';
    } else {
      // 从TyHomeController获取MD值
      return TyHomeController.to.homeState.matchListReq.md ?? '';
    }
  }

  /// 获取EUID值
  String _getEuid() {
    // 判断当前路由是否为电竞视图
    if (Get.currentRoute == Routes.DJView) {
      // 如果是电竞视图，返回'0'
      return '0';
    } else {
      // 判断HotLeagueController的当前索引是否为0
      if (HotLeagueController.to?.currentIndex == 0) {
        // 如果是，返回'0'
        return '0';
      }
      // 从TyHomeController获取EUID值
      return TyHomeController.to.homeState.matchListReq.euid;
    }
  }
}
