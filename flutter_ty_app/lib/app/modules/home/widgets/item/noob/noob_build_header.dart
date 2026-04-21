import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/utils/format_score_util3.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../global/config_controller.dart';
import '../../../../../services/models/res/match_entity.dart';


import '../../../../../utils/match_util.dart';
import '../../../../../utils/sport.dart';
import '../../../../../utils/utils.dart';
import '../../../../login/login_head_import.dart';

import '../counting-down/counting-down.dart';
import '../profession/secodary/flag_widget.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-score.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-7d3a63c7-df94-4a5e-a079-48f44ab7b750-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 新手版 】】】
    【【【 AUTO_PARAGRAPH_TITLE 新手版UI组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    # NoobbuildHeader 函数

    ## 功能
    `NoobbuildHeader` 函数用于展示比赛的头部信息，包括比赛图标、时间、状态、比分等。根据比赛的状态动态更新展示内容。

    - 列表头部 NoobbuildHeader
    - 新手版图标 FlagWidget
    - 比赛 倒计时或正计时 Countingdown

    】】】
 *
 */

NoobbuildHeader(MatchEntity matchEntity, BuildContext context) {
  bool showCountingDown = MatchUtil.showCountingDown(matchEntity);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 0.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //新手版图标
        FlagWidget(
          matchEntity: matchEntity,
          type: 1,
        ),
        SizedBox(
          width: 4.w,
        ),
        //  if (!ObjectUtil.isEmptyString(matchEntity.mcid) &&
        //       TyHomeController.to.isJinZu())
        Text(
          matchEntity.mcid,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp.scale,
            color: context.isDarkMode
                ? Colors.white.withValues(alpha:0.30000001192092896)
                : const Color(0xffAFB3C8),
          ),
        ).marginOnly(right: 4.w),
        // 1 开赛   110 即将开赛
        //  ms = 1 110 才匹配（已开赛的）其他直接显示时间。

        //  <!--开赛日期 ms != 110 (不为即将开赛)  subMenuType = 13网球(进行中不显示，赛前需要显示)-->
        ///  kyapp 没有显示即将开始 倒计时 这里不需要判断倒计时
        /*       if (matchEntity.ms != 110 &&
                      !showStartCountingDown &&
                      !showCountingDown)*/

        if (matchEntity.ms != SportData.sportMs_110 && !showCountingDown)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateUtil.formatDateMs(int.tryParse(matchEntity.mgt) ?? 0,
                    format: isZh() ? LocaleKeys.time11.tr : LocaleKeys.time4.tr,
                    isUtc: true),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp.scale,
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha:0.30000001192092896)
                      : const Color(0xffAFB3C8),
                ),
              ),
              SizedBox(
                width: 5.w,
              )
            ],
          ),
        // <!-- 赛事回合数mfo match.ms != 1(不为开赛)-->
        if (matchEntity.mfo != null &&
            ![SportData.sportMs_1, SportData.sportMs_110]
                .contains(matchEntity.ms) &&
            [
              SportData.sportCsid_5,
              SportData.sportCsid_7,
              SportData.sportCsid_8,
              SportData.sportCsid_9,
              SportData.sportCsid_10
            ].contains(int.parse(matchEntity.csid)))
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                matchEntity.mfo,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp.scale,
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha:0.30000001192092896)
                      : const Color(0xffAFB3C8),
                ),
              ),
              SizedBox(
                width: 5.w,
              )
            ],
          ),

        ///  即将开赛 ms = 110  显示即将开赛
        if (matchEntity.ms == SportData.sportMs_110)
          Text(
            'ms_110'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp.scale,
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.30000001192092896)
                  : const Color(0xffAFB3C8),
            ),
          ).marginOnly(right: 4.w),

        /// 今日赛事
        // if (matchEntity.mcg == 3)
        //  ms = 1 110 才匹配（已开赛的）其他直接显示时间。
        // if ([1].contains(matchEntity.ms))
        //   Text(
        //     // tid 联赛id归位一类，
        //     'mmp_${matchEntity.csid}_${matchEntity.mmp}'.tr,
        //     style: TextStyle(
        //       fontSize: 12.sp.scale,
        //       fontFamily: 'PingFang SC',
        //       fontWeight: FontWeight.w400,
        //       color: context.isDarkMode
        //           ? Colors.white.withValues(alpha:0.30000001192092896)
        //           : const Color(0xffAFB3C8),
        //     ),
        //   ).marginOnly(right: 4.w),
        //  <!--倒计时或正计时-->
        if (matchEntity.ms != SportData.sportMs_110 &&
            showCountingDown)
          Countingdown(
            matchEntity,
            key: ValueKey('counting_noob_header_${matchEntity.mid}'),
          ),
        // TimeWidget(
        //   matchEntity: matchEntity,
        // ),

        SizedBox(
          width: 4.w,
        ),
        matchEntity.ms != SportData.sportMs_110
            ? Text(
                //网球单独处理
                int.parse(matchEntity.csid) == SportData.sportCsid_5
                    ? FormatScore3.formatminScore(matchEntity)
                    : TYFormatScore.formatTotalScore(matchEntity).text,
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha:0.8999999761581421)
                      : const Color(0xFF303442),
                  fontSize: 12.sp.scale,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ).marginOnly(left: 4.w)
            : const SizedBox(),
        // 赛事回合数mfo match.ms != 1(不为开赛) 为开赛显示
        /*   if (ObjectUtil.isNotEmpty(matchEntity.mfo) && matchEntity.ms != 1)
            Text(
              matchEntity.mfo,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha:0.30000001192092896)
                    : const Color(0xffAFB3C8),
                fontSize: 12.sp.scale,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ).marginOnly(left: 4.w),*/
        const Spacer(),
        Obx(() {
          //更多
          return Text(
            ConfigController.to.accessConfig.value.handicapNum
                ? '${LocaleKeys.footer_menu_more.tr}(${matchEntity.mc})'
                : LocaleKeys.footer_menu_more.tr,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.30000001192092896)
                  : const Color(0xFFAFB3C8),
              fontSize: 10.sp.scale,
              height: 0.9,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          );
        }),
        ImageView(
          context.isDarkMode
              ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
              : 'assets/images/league/ico_arrowright_nor.png',
          width: 12.w,
          height: 12.w,
        ),
      ],
    ),
  );
}
