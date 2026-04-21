
import 'dart:collection';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import '../../../../../../main.dart';
import '../../../../../global/config_controller.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/route_check_util.dart';
import '../../../../../utils/sport.dart';
import '../../../../login/login_head_import.dart';
import '../../../../match_detail/widgets/container/odds_info/odds_button.dart';
import '../../../controllers/collection_controller.dart';
import '../../../controllers/home_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-7d3a63c7-df94-4a5e-a079-48f44ab7b750-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 新手版 】】】
    【【【 AUTO_PARAGRAPH_TITLE 新手版 投注按钮 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 空数据填充 hpsOls.isEmpty
    - 投注按钮 OddsButton
    - 收藏 controller.addOrCancelMatch(matchEntity);
    】】】
 *
 */
///新手版投注按钮
NoobbuildBetGroup(MatchEntity matchEntity, bool isDarkMode) {
  // 获取比赛的投注选项
  MatchHps? hps = matchEntity.hps.safeFirst;
  List<MatchHpsHlOl> hpsOls = hps?.hl.safeFirst?.ol ?? [];
  bool isFake = false;

  // 检查投注选项是否为空
  if (hpsOls.isEmpty) {
    isFake = true; // 设置为假数据标志
    if (int.parse(matchEntity.csid)== SportData.sportCsid_1) {
      // 足球类型是3个投注项
      hpsOls.addAll([MatchHpsHlOl(), MatchHpsHlOl(), MatchHpsHlOl()]);
    } else {
      // 其他类型是2个投注项
      hpsOls.addAll([MatchHpsHlOl(), MatchHpsHlOl()]);
    }
  } else if (hpsOls.safeFirst?.oid != '') {
    // 如果投注选项不为空且oid不为空，进行排序
    Map<int, MatchHpsHlOl?> temp = {};
    hpsOls.forEach((e) {
      // 根据ots属性分类投注选项
      if (e.ots == 'T1') {
        temp[0] = e;
      } else if (e.ots == 'T2') {
        temp[2] = e;
      } else {
        temp[1] = e;
      }
    });
    hpsOls.clear(); // 清空原有列表
    // 按照分类后的顺序添加回列表
    SplayTreeMap<int, MatchHpsHlOl> sortedValuesAsc = SplayTreeMap.from(
        temp, (int keys1, int keys2) => keys1.compareTo(keys2));
    hpsOls.addAll((sortedValuesAsc.values).toList());
  }

  // 获取收藏控制器
  CollectionController controller = CollectionController.to;
  var mWidth = 200.0.w.ceil() * 1.0; // 计算按钮宽度

  return Container(
    height: isIPad ? 50.h : 35.h, // 根据设备类型设置高度
    alignment: Alignment.center,
    child: Stack(
      children: [
        // 如果当前不是投注状态，显示收藏按钮
        if (!TyHomeController.to.homeState.menu.isMatchBet)
          Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Obx(() {
                // 检查收藏开关
                if (ConfigController.to.accessConfig.value.collectSwitch) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: GetBuilder<CollectionController>(builder: (logic) {
                      return InkWell(
                        onTap: () {
                          // 点击收藏/取消收藏
                          controller.addOrCancelMatch(matchEntity);
                        },
                        child: ImageView(
                          // 根据登录状态和收藏状态选择图标
                          (RouteCheckUtil.checkIsLogin() &&
                              (matchEntity.mf ||
                                  CollectionController
                                      .to.isCollection(matchEntity)
                              ))
                              ? 'assets/images/home/ico_fav_nor_sel.svg'
                              : isDarkMode
                              ? 'assets/images/home/ico_fav_nor.png'
                              : 'assets/images/home/ico_fav_nor_light.png',
                          width: 16.w,
                          height: 16.w,
                        ),
                      );
                    }),
                  );
                } else {
                  return 0.verticalSpaceFromWidth; // 不显示任何内容
                }
              })),
        // 显示投注按钮列表
        Align(
          alignment: Alignment.center,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ]),
                  child: OddsButton(
                    height: 33.w, // 按钮高度
                    betType: MatchUtil.isEsport(matchEntity) ? OddsBetType.esport : OddsBetType.common,
                    width: hpsOls.length == 3
                        ? (isIPad ? mWidth : 90.w) // 根据条件设置按钮宽度
                        : hpsOls.length == 2
                        ? isIPad
                        ? 200.w
                        : 140.w
                        : isIPad
                        ? 200.w
                        : 280.w,
                    match: matchEntity, // 传递比赛实体
                    radius: 4.w, // 按钮圆角
                    hps: hps, // 传递投注选项
                    ol: isFake ? null : hpsOls[index], // 根据假数据标志决定投注选项
                    hl: hps?.hl.safeFirst, // 传递高亮信息
                  ));
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 2.w, // 按钮之间的间隔
              );
            },
            itemCount: hpsOls.length, // 按钮数量
          ),
        ),
      ],
    ),
  );
}



