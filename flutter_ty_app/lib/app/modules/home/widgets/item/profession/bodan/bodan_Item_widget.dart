import 'dart:math';

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';

import '../../../../../../../main.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../match_detail/widgets/container/odds_info/odds_button.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-06de67a4-485b-4b00-91a1-b8c4546e388e-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 子玩法 】】】
    【【【 AUTO_PARAGRAPH_TITLE 波胆UI组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - title 特色组合队伍标题
    - OddsButton 赔率按钮
    - maxLine 最大itemCount
    - type  0 全场数据 1 半场数据

    ## bodan_Item 类

      `bodan_Item` 是一个 Flutter 的 StatelessWidget，用于显示波胆项的相关信息。

    - **参数**
    - `title`: 当前项的标题（队伍名称）。
    - `list`: 波胆数据列表。
    - `match`: 当前比赛的实体。
    - `hps`: 波胆数据。
    - `maxLine`: 最大显示行数。
    - `type`: 数据类型（全场或半场）。

    ### build

    构建 UI 组件。

    - 计算每个项的宽度。
    - 创建一个 `Column`，包含队伍名称和赔率列表。

    #### 队伍名称

    - 使用 `Container` 显示队伍名称。
    - 设置文本样式，支持深色模式。

    #### 赔率列表

    - 使用 `ListView.separated` 显示赔率列表，设置不可滚动。
    - 根据 `maxLine` 和 `list.length` 控制显示的条目数量。
    - 每个赔率项使用 `OddsButton` 组件构建。

    】】】
 *
 */
// ignore: camel_case_types
class BodanItemWidget extends StatelessWidget {
  const BodanItemWidget(
      {super.key,
      required this.title,
      required this.list,
      required this.match,
      required this.hps,
      required this.maxLine,
      required this.type});

  final MatchHps hps;
  final List<MatchHpsHlOl> list;
  final MatchEntity match;
  final int maxLine;
  final String title;
  final int type;

  @override
  Widget build(BuildContext context) {
    //计算item宽度
    double width = ((Get.width - 28.w - 8.w - 8.w) / 6).toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ///队伍名称
        Container(
          ///不同语言显示行高不一样 会导致挤压下面盘口列表
          height: 17,
          width: width,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: isIPad ? 14.sp.scale : 10.sp.scale,
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.8999999761581421)
                  : const Color(0xff949AB6),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        4.verticalSpaceFromWidth,
        ///赔率
        SizedBox(
          width: width,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: max(list.length, maxLine),
            separatorBuilder: (BuildContext context, int index) {
              return 2.verticalSpaceFromWidth;
            },
            itemBuilder: (BuildContext context, int index) {
              return OddsButton(
                betType: MatchUtil.isEsport(match) ? OddsBetType.esport : OddsBetType.common,
                height: (isIPad? 35.h: 33)+(TyTextScaler.instance().isScale ? 12 : 0),
                width: width,
                match: match,
                radius: 4.w,
                //是否是子玩法
                secondaryPaly: true,
                hps: hps,
                type: type,
                hl: hps.hl.safeFirst,
                ol: list.safe(index),
                nameColor: const Color(0xff3AA6FC),
                playId: playIdConfig.hpsBold,
              );
            },
          ),
        ),
      ],
    );
  }
}
