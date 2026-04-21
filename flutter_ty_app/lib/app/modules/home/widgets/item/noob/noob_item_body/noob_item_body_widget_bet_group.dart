import 'dart:collection';

import 'package:flutter_ty_app/app/extension/num_extension.dart';

// import 'package:flutter_ty_app/app/global/data_store_controller.dart';
// import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
// import 'package:flutter_ty_app/app/modules/home/widgets/item/guanjun_yindao/guanjun_yindao.dart';
// import 'package:flutter_ty_app/app/modules/home/widgets/item/noob/noob_build_bet_group_team.dart';
// import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/secodary/secodary_build_body_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/pin_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';

import '../../../../../../../main.dart';
import '../../../../../../global/config_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../match_detail/widgets/container/odds_info/odds_button.dart';
import '../../../../controllers/collection_controller.dart';

class NoobItemBodyWidgetBetGroup extends StatelessWidget {
  const NoobItemBodyWidgetBetGroup({
    super.key,
    required this.matchEntity,
    required this.isThree,
    required this.isDetail,
    required this.isDarkMode
  });

  final MatchEntity matchEntity;
  final bool isThree;
  final bool isDetail;
  final bool isDarkMode;


  @override
  Widget build(BuildContext context) {
    MatchHps? hps = matchEntity.hps.safeFirst;
    List<MatchHpsHlOl> hpsOls = hps?.hl.safeFirst?.ol ?? [];
    bool isFake = false;
    if (hpsOls.isEmpty) {
      isFake = true;
      if (isThree == true) {
        hpsOls.addAll([MatchHpsHlOl(), MatchHpsHlOl(), MatchHpsHlOl()]);
      } else {
        hpsOls.addAll([MatchHpsHlOl(), MatchHpsHlOl()]);
      }
    } else if (hpsOls.safeFirst?.oid != '') {
      Map<int, MatchHpsHlOl?> temp = {};
      hpsOls.forEach((e) {
        if (e.ots == 'T1') {
          temp[0] = e;
        } else if (e.ots == 'T2') {
          temp[2] = e;
        } else {
          temp[1] = e;
        }
      });
      hpsOls.clear();
      SplayTreeMap<int, MatchHpsHlOl> sortedValuesAsc = SplayTreeMap.from(
          temp, (int keys1, int keys2) => keys1.compareTo(keys2));
      hpsOls.addAll((sortedValuesAsc.values).toList());
    }
    CollectionController controller = CollectionController.to;
    var mWidth = 200.0.w.ceil() * 1.0;
    return Container(
      height: isIPad
          ? 50.h
          : TyTextScaler
          .instance()
          .isScale
          ? 38.h
          : 33.h,
      alignment: Alignment.center,
      child: Stack(
        children: [
          if (!TyHomeController.to.homeState.menu.isMatchBet)
            Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Obx(() {
                  if (ConfigController.to.accessConfig.value.collectSwitch) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: GetBuilder<CollectionController>(builder: (logic) {
                        return InkWell(
                          onTap: () {
                            controller.addOrCancelMatch(matchEntity);
                          },
                          child: ImageView(
                            (RouteCheckUtil.checkIsLogin() &&
                                (matchEntity.mf ||
                                    CollectionController.to
                                        .isCollection(matchEntity)))
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
                    return 0.verticalSpaceFromWidth;
                  }
                })),
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
                      height: TyTextScaler
                          .instance()
                          .isScale ? 38.h : 33.h,
                      width: hpsOls.length == 3
                          ? (isIPad ? mWidth : 90.w)
                          : hpsOls.length == 2
                          ? isIPad
                          ? 200.w
                          : 140.w
                          : isIPad
                          ? 200.w
                          : 280.w,
                      match: matchEntity,
                      radius: 4.w,
                      hps: hps,
                      ol: isFake ? null : hpsOls[index],
                      hl: hps?.hl.safeFirst,
                      betType: MatchUtil.isEsport(matchEntity)
                          ? OddsBetType.esport
                          : OddsBetType.common,
                    ));
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 2.w,
                );
              },
              itemCount: hpsOls.length,
            ),
          ),
          // if (matchEntity.csid.toInt() < 100)
          if (isDetail == false)
            Align(
              alignment: Alignment.centerRight,
              child: PinWidget(
                isLeague: false,
                matchEntity: matchEntity,
                isNoob: false,
                isDjInCommon: MatchUtil.isEsport(matchEntity),
              ).marginOnly(right: 12.w),
            )
        ],
      ),
    );
  }
}