import 'dart:math';

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';

import '../../../../../../../main.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../match_detail/widgets/container/odds_info/odds_button.dart';
import '../../../../logic/other_player_name_to_playid.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-06de67a4-485b-4b00-91a1-b8c4546e388e-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 子玩法 】】】
    【【【 AUTO_PARAGRAPH_TITLE 特色组合UI组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 计算投注按钮宽度
    - 全场/半场 标题
    - 特色组合各分段赔率填充
    - title  全场/半场 两队都进球/进球大小
    - type 0 左 1 右   分辨是左侧还是右侧列表
    - btnHeight 列表高度
    - hps.hl.safeFirst?.ol 特色组合数据  如果是左边前后数据调换 客胜是在前  否在后
    - max(hps.hl.safeFirst?.ol.length ?? 0,6,) 最大长度

    # `featureTempbodyItem`

    - **功能**: 创建一个显示赔率信息的组件，包括标题和赔率按钮，支持左右布局。
    - **参数**:
    - `match`: 当前比赛的实体数据。
    - `hps`: 当前赔率数据。
    - `title`: 显示的标题文本。
    - `type`: 指示该组件是左侧（0）还是右侧（1）。
    - `btnHeight`: 按钮高度（响应式）。

    1. **计算宽度**:
    - 根据屏幕宽度动态计算每个按钮的宽度。

    2. **构建界面**:
    - 使用 `Column` 布局，包含标题和赔率按钮列表。
    - 标题使用 `Text` 组件，支持最大行数和文本溢出处理。

    3. **赔率按钮**:
    - 使用 `Wrap` 布局展示赔率按钮，支持多行显示。
    - 通过 `List.generate` 动态生成按钮，最多显示 6 个。
    - 根据 `type` 参数调整赔率数据的顺序：
    - 如果是左侧（`type == 0`），则前后数据调换。
    - 否则直接使用右侧数据。

    ## 组件结构

    - **标题部分**:
    - 使用 `Text` 显示传入的标题，样式根据设备类型（iPad 或其他）动态调整。

    - **赔率按钮部分**:
    - 使用 `SizedBox` 限制按钮区域的大小。
    - 每个按钮使用 `OddsButton` 组件显示赔率信息，并根据 `type` 参数决定赔率数据的顺序。


    】】】
 *
 */

/// type 0 左 1 右   分辨是左侧还是右侧列表
Widget featureTempbodyItem(MatchEntity match, MatchHps hps, String title,
    int type, RxDouble btnHeight, BuildContext context) {
  ///计算宽度
  double width = ((Get.width - 28.w - 12.w) * 0.25).toInt().toDouble();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        child: Text(
          title,
          style: TextStyle(
            fontSize: isIPad ? 12.sp.scale : 10.sp.scale,
            color: context.isDarkMode
                ? Colors.white.withValues(alpha:0.8999999761581421)
                : const Color(0xff949AB6),
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      4.verticalSpaceFromWidth,
      SizedBox(
        width: (Get.width - 28.w - 8.w) * 0.5,
        height: (isIPad ? btnHeight.value.w : btnHeight.value) * 3 +
            (isIPad ? 4.w : 4) +
            (TyTextScaler.instance().isScale ? 18 : 0),
        child: Wrap(
          spacing: 2.w,
          runSpacing: 2.w,
          children: List.generate(
              max(
                hps.hl.safeFirst?.ol.length ?? 0,
                6,
              ), (index) {
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
                isDetail: false,
                playId: playIdConfig.hpsCompose,
                height: (isIPad ? btnHeight.value.w : btnHeight.value) +
                    (TyTextScaler.instance().isScale ? 6 : 0),
                radius: 4.w,
                width: width,
                match: match,
                secondaryPaly: true,
                hps: hps,
                hl: hps.hl.safeFirst,
                betType: MatchUtil.isEsport(match)
                    ? OddsBetType.esport
                    : OddsBetType.common,

                ///如果是左边 前后数据调换 客胜是在前  否在后
                ol: type == 0
                    ? index % 2 == 0
                        ? hps.hl.safeFirst?.ol.safe(index + 1)
                        : hps.hl.safeFirst?.ol.safe(index - 1)
                    : hps.hl.safeFirst?.ol.safe(index),
                key: (hps.hl.safeFirst?.ol.safe(index))?.oid != null
                    ? ValueKey((hps.hl.safeFirst?.ol.safe(index))?.oid)
                    : null,
              ),
            );
          }),
        ),
      )
    ],
  );
}
