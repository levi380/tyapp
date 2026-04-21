import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/widgets/scroll_index_widget.dart';
import 'package:get/get.dart';

import '../../../modules/main_tab/main_tab_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-8094d25e-94d1-4519-baa1-a19a9185a1a6-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 数据仓库 】】】
    【【【 AUTO_DOCUMENT_TITLE  数据仓库方法执行类 】】】
    【【【 AUTO_PARAGRAPH_TITLE 数据仓库方法执行类入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 数据仓库进行增删改查操作的地方
    - 在获取指定的数据对象后，对数据对象的合并以及增删查改
    】】】
 *
 */
extension DataStoreControllerX on DataStoreController {
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-8094d25e-94d1-4519-baa1-a19a9185a1a6-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 数据仓库 】】】
      【【【 AUTO_DOCUMENT_TITLE  数据仓库方法执行类 】】】
      【【【 AUTO_PARAGRAPH_TITLE 可视化数据插入方法 】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 可视化数据插入方法
      ```
      可视化数组
      showMatchIdList
      ```
      】】】
   *
   */
  setShowMatchIdList(List<String> showList,
      {needMerge = false, String pageRouteKey = otherPageKey}) {
    if (pageKey != pageRouteKey) return;
    if (!needMerge) {
      showMatchIdList = showList;
    } else {
      final Set<String> uniqueIds = showMatchIdList.toSet();
      /// 将新列表的元素添加到Set中，自动去重
      uniqueIds.addAll(showList);
      /// 将Set转回列表并赋值
      showMatchIdList.assignAll(uniqueIds.toList());
    }
  }

  injecthowMatchIdByMatchEntity(String mid) {
    if (!showMatchIdList.contains(mid)) {
      showMatchIdList.add(mid);
    }
  }

  injecthowMatchIdListByMatchEntity(List<MatchEntity> matchList,
      {needMerge = false, String pageRouteKey = otherPageKey}) {
    List<String> matchIdList = [];
    matchList.forEach((MatchEntity match) {
      matchIdList.add(match.mid);
    });
    if (matchIdList.isNotEmpty) {
      setShowMatchIdList(matchIdList,
          needMerge: needMerge, pageRouteKey: pageRouteKey);
    }
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-8094d25e-94d1-4519-baa1-a19a9185a1a6-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 数据仓库 】】】
      【【【 AUTO_DOCUMENT_TITLE  数据仓库方法执行类 】】】
      【【【 AUTO_PARAGRAPH_TITLE 数据仓库数据增加或插入 】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 数据仓库数据增加或插入
      】】】
   *
   */
  ///============================================== 增加 ==============================================///
  injectMatch(MatchEntity matchEntity,{bool ishomebyMyId = false}) {
    ///添加后 更新UI
    matchMap[getMatchId(matchEntity.mid)] = matchEntity;

    for (var element in matchEntity.hps) {
      for (var element in element.hl) {
        hlMap[getHid(element.hid)] = element;
      }
    }

    if(ishomebyMyId){
      foreach(matchEntity.hps,ishomebyMyId,matchEntity.mhs);
    }

    bool homeUpdatable = Get.isRegistered<MainTabController>() && Get.isRegistered<TyHomeController>(tag:MainTabController.to.uuid) && TyHomeController.to.visiable &&
        TyHomeController.to.homeState.endScroll &&
        showMatchIdList.contains(matchEntity.mid);

    /**
     *
     *
        【【【 AUTO_DOCUMENT_UUID tyApp-8094d25e-94d1-4519-baa1-a19a9185a1a6-sz 】】】
        【【【 AUTO_DOCUMENT_MENU 数据仓库 】】】
        【【【 AUTO_DOCUMENT_TITLE  数据仓库方法执行类 】】】
        【【【 AUTO_PARAGRAPH_TITLE 数据仓库数据增加或插入 】】】
        【【【 AUTO_PARAGRAPH_CONTENT
        - 滚动只插入数据 不更新UI
        】】】
     *
     */

    update([getMatchId(matchEntity.mid), homeUpdatable]);

  }

  injectHl(MatchHpsHl hlEntity) {
    if (!hlMap.keys.contains(getHid(hlEntity.hid))) {

      /**
       *
       *
          【【【 AUTO_DOCUMENT_UUID tyApp-8094d25e-94d1-4519-baa1-a19a9185a1a6-sz 】】】
          【【【 AUTO_DOCUMENT_MENU 数据仓库 】】】
          【【【 AUTO_DOCUMENT_TITLE  数据仓库方法执行类 】】】
          【【【 AUTO_PARAGRAPH_TITLE 数据仓库数据增加或插入 】】】
          【【【 AUTO_PARAGRAPH_CONTENT
          - 添加后 更新UI
          】】】
       *
       */
      hlMap[getHid(hlEntity.hid)] = hlEntity;
      for (var element in hlEntity.ol) {
        injectOl(element);
      }
    }
  }

  injectOl(MatchHpsHlOl olEntity) {
    if (!olMap.keys.contains(getOid(olEntity.oid))) {
      ///添加后 更新UI
      olMap[getOid(olEntity.oid)] = olEntity;
    } else {
      String on = olEntity.on;
      String obn = olEntity.onb;
      MatchHpsHlOl? oldOl = olMap[getOid(olEntity.oid)];
      if (oldOl?.on != on || oldOl?.onb != obn) {
        ///滚动只插入数据 不更新UI
        if (!isScrolling) {
          updateOl(olEntity);
        }
      }
    }
  }

  ///===================================================================================///


  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-8094d25e-94d1-4519-baa1-a19a9185a1a6-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 数据仓库 】】】
      【【【 AUTO_DOCUMENT_TITLE  数据仓库方法执行类 】】】
      【【【 AUTO_PARAGRAPH_TITLE 数据仓库数据更新 】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 修改后 更新UI
      】】】
   *
   */
  ///============================================== 更新 ==============================================///
  updateMatch(MatchEntity matchEntityity,
      {bool keepSecondary = false, bool ishomebyMyId = false}) {
    MatchEntity? oldMatchEntity = matchMap[getMatchId(matchEntityity.mid)];

    // 关键优化：倒计时防回流逻辑
    // 如果旧数据存在，且赛事阶段没变，且倒计时误差在 15s 内，优先保留旧数据（或本地计时数据）
    if (oldMatchEntity != null &&
        oldMatchEntity.mmp == matchEntityity.mmp &&
        oldMatchEntity.mess == matchEntityity.mess) {
      double oldMst = double.tryParse(oldMatchEntity.mst) ?? 0;
      double newMst = double.tryParse(matchEntityity.mst) ?? 0;
      if (newMst > 0 && (newMst - oldMst).abs() <= 15) {
        matchEntityity.mst = oldMatchEntity.mst;
      }
    }

    ///修改后 更新UI
    if (keepSecondary) {
      MatchEntity? oldMatchEntity = matchMap[getMatchId(matchEntityity.mid)];

      if (matchEntityity.kySwitch.playType == -1 && oldMatchEntity != null && oldMatchEntity.kySwitch.playType != -1){
        matchEntityity.kySwitch = oldMatchEntity.kySwitch;
      }

      /// 核心盘口 (hps)
      /// 如果推送或轮询的数据中 hps 为空，且旧数据中有 hps，则保留旧的盘口数据
      if (matchEntityity.hps.isEmpty && oldMatchEntity != null && oldMatchEntity.hps.isNotEmpty) {
        matchEntityity.hps.addAll(oldMatchEntity.hps);
      }
      foreach(matchEntityity.hps,ishomebyMyId,matchEntityity.mhs);

      ///角球
      if (matchEntityity.hpsCorner.isEmpty) {
        matchEntityity.hpsCorner.addAll(oldMatchEntity?.hpsCorner ?? []);
        foreach(matchEntityity.hpsCorner,ishomebyMyId,matchEntityity.mhs);
        // injectOl(olEntity)
      }

      ///加时角球
      if (matchEntityity.hpsTCorner.isEmpty) {
        matchEntityity.hpsTCorner.addAll(oldMatchEntity?.hpsTCorner ?? []);
        foreach(matchEntityity.hpsTCorner,ishomebyMyId,matchEntityity.mhs);
        // injectOl(olEntity)
      }

      ///15分钟
      if (matchEntityity.hps15Minutes.isEmpty) {
        matchEntityity.hps15Minutes.addAll(oldMatchEntity?.hps15Minutes ?? []);
        foreach(matchEntityity.hps15Minutes,ishomebyMyId,matchEntityity.mhs);
      }

      ///特色组合数据
      if (matchEntityity.hpsCompose.isEmpty) {
        matchEntityity.hpsCompose.addAll(oldMatchEntity?.hpsCompose ?? []);
        foreach(matchEntityity.hpsCompose,ishomebyMyId,matchEntityity.mhs);
      }

      ///波胆数据
      if (matchEntityity.hpsBold.isEmpty) {
        matchEntityity.hpsBold.addAll(oldMatchEntity?.hpsBold ?? []);
        foreach(matchEntityity.hpsBold,ishomebyMyId,matchEntityity.mhs);
      }

      ///加时波胆数据
      if (matchEntityity.hpsTBold.isEmpty) {
        matchEntityity.hpsTBold.addAll(oldMatchEntity?.hpsTBold ?? []);
        foreach(matchEntityity.hpsTBold,ishomebyMyId,matchEntityity.mhs);
      }

      //*更新数据*/
      ///罚牌
      if (matchEntityity.hpsPunish.isEmpty) {
        matchEntityity.hpsPunish.addAll(oldMatchEntity?.hpsPunish ?? []);
        foreach(matchEntityity.hpsPunish,ishomebyMyId,matchEntityity.mhs);
      }

      ///加时罚牌
      if (matchEntityity.hpsTPunish.isEmpty) {
        matchEntityity.hpsTPunish.addAll(oldMatchEntity?.hpsTPunish ?? []);
        foreach(matchEntityity.hpsTPunish,ishomebyMyId,matchEntityity.mhs);
      }

      ///晋级赛
      if (matchEntityity.hpsPromotion.isEmpty) {
        matchEntityity.hpsPromotion.addAll(oldMatchEntity?.hpsPromotion ?? []);
        foreach(matchEntityity.hpsPromotion,ishomebyMyId,matchEntityity.mhs);
      }

      ///冠军
      if (matchEntityity.hpsOutright.isEmpty) {
        matchEntityity.hpsOutright.addAll(oldMatchEntity?.hpsOutright ?? []);
        foreach(matchEntityity.hpsOutright,ishomebyMyId,matchEntityity.mhs);
      }

      ///加时赛
      if (matchEntityity.hpsOvertime.isEmpty) {
        matchEntityity.hpsOvertime.addAll(oldMatchEntity?.hpsOvertime ?? []);
        foreach(matchEntityity.hpsOvertime,ishomebyMyId,matchEntityity.mhs);
      }

      ///点球大战
      if (matchEntityity.hpsPenalty.isEmpty) {
        matchEntityity.hpsPenalty.addAll(oldMatchEntity?.hpsPenalty ?? []);
        foreach(matchEntityity.hpsPenalty,ishomebyMyId,matchEntityity.mhs);
      }

      ///小节
      if (matchEntityity.hpsSectionPlay.isEmpty) {
        matchEntityity.hpsSectionPlay.addAll(oldMatchEntity?.hpsSectionPlay ?? []);
        foreach(matchEntityity.hpsSectionPlay,ishomebyMyId,matchEntityity.mhs);
      }

      /// 6分钟
      if (matchEntityity.hps6Minutes.isEmpty) {
        matchEntityity.hps6Minutes.addAll(oldMatchEntity?.hps6Minutes ?? []);
        foreach(matchEntityity.hps6Minutes,ishomebyMyId,matchEntityity.mhs);
      }
    }




    ///赛事更新判断是否是优惠盘口赛事级别
    // bool isDiscount= matchEntityity.dom == 1 ? true : false;
    // if(isDiscount){
    //   discountMatchMap[getDiscountMatchId(matchEntityity.mid)] = matchEntityity;
    // }else{
    //   matchMap[getMatchId(matchEntityity.mid)] = matchEntityity;
    // }

    matchMap[getMatchId(matchEntityity.mid)] = matchEntityity;

    if(ishomebyMyId){
      foreach(matchEntityity.hps,ishomebyMyId,matchEntityity.mhs);
    }


    /// 在首页且滚动结束时才更新UI
    bool homeUpdatable =
        Get.isRegistered<MainTabController>() && Get.isRegistered<TyHomeController>(tag:MainTabController.to.uuid) && TyHomeController.to.visiable && TyHomeController.to.homeState.endScroll;

    ///滚动只插入数据 不更新UI
    if (!isScrolling) {
      update([getMatchId(matchEntityity.mid), homeUpdatable]);

    }
  }


  foreach(List<MatchHps> hpsList,bool ishomebyMyId,int mhs) {
    if(!ishomebyMyId) return;
    hpsList.forEach((MatchHps hl) {
      hl.hl.forEach((MatchHpsHl hpsHl) {
        hpsHl.ol.forEach((MatchHpsHlOl ol) {
          // injectOl(ol);
          ol.hpid = hl.hpid;
          ol.hs = hl.hs;
          ol.mhs = mhs;
          updateOl(ol);
        });
      });
      //冠军赛事，ol直接在MatchHps下面
      hl.ol.forEach((MatchHpsHlOl ol) {
        // injectOl(ol);
        ol.hpid = hl.hpid;
        ol.hs = hl.hs;
        ol.mhs = mhs;
        updateOl(ol);
      });
    });
  }

  updateHl(MatchHpsHl hlEntity) {
    ///修改后 更新UI
    hlMap[getHid(hlEntity.hid)] = hlEntity;
    bool homeUpdatable =
        Get.isRegistered<MainTabController>() && Get.isRegistered<TyHomeController>(tag:MainTabController.to.uuid) && TyHomeController.to.visiable && TyHomeController.to.homeState.endScroll;

    ///滚动只插入数据 不更新UI
    if (!isScrolling) {
      update([getHid(hlEntity.hid), homeUpdatable]);
    }
  }

  updateOl(MatchHpsHlOl olEntity) {
    ///修改后 更新UI
    olMap[getOid(olEntity.oid)] = olEntity;
    bool homeUpdatable =
        Get.isRegistered<MainTabController>() && Get.isRegistered<MainTabController>() && Get.isRegistered<TyHomeController>(tag:MainTabController.to.uuid) && TyHomeController.to.visiable && TyHomeController.to.homeState.endScroll;

    ///滚动只插入数据 不更新UI
    if (!isScrolling) {
      update([getOid(olEntity.oid), homeUpdatable]);
    }

  }
  ///===================================================================================///

  ///============================================== 查询 ==============================================///

  MatchEntity? getMatchById(String mid) {
    // if(isDiscount){
    //   return discountMatchMap[getDiscountMatchId(mid)];
    // }
    return matchMap[getMatchId(mid)];
  }

  MatchHpsHl? getHlById(String hid) {
    return hlMap[getHid(hid)];
  }

  MatchHpsHlOl? getOlById(String oid) {
    return olMap[getOid(oid)];
  }

  ///===================================================================================///

  ///============================================== 删除 ==============================================///

  removeMatchById(String mid) {
    matchMap.remove(getMatchId(mid));
  }

  removeHlById(String hid) {
    hlMap.remove(getHid(hid));
  }

  removeOlById(String oid) {
    olMap.remove(getOid(oid));
  }

  ///===================================================================================///
  ///
  String getMatchId(String mid) {
    return MATCH_ID + mid;
  }

  // String getDiscountMatchId(String mid) {
  //   return discount_MATCH_ID + mid;
  // }

  String getHid(String hid) {
    return HID + hid;
  }

  String getOid(String oid) {
    return OID + oid;
  }
}
