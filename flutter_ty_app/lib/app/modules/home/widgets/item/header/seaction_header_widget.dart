import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../../generated/locales.g.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-7d3a63c7-df94-4a5e-a079-48f44ab7b750-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 新手版 】】】
    【【【 AUTO_PARAGRAPH_TITLE 展开收起 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - isExpand 是否展开
    - SectionGroupEnum 进行中/未开始/全部类型
    】】】
    ## SectionHeaderWidget 类

    `SectionHeaderWidget` 是一个 Flutter 的 StatelessWidget，旨在展示可展开的节标题
    ，提供用户交互以展开或收起节内容，从而提升用户体验。

    - **参数**
    - `isExpand`: 当前节的展开状态（布尔值），用于控制节内容的显示。
    - `onExpand`: 状态变化时的回调函数，允许外部组件处理展开或收起的逻辑。
    - `sectionGroupEnum`: 指定节的类型（枚举类型），用以区分不同的节内容。

    ### build 方法

    该方法用于构建 UI 组件。

    - 计算分隔线的颜色、标题和图标，确保视觉一致性。
    - 根据 `sectionGroupEnum` 的不同值，处理各类节类型的显示逻辑
    ，确保用户能够清晰地识别不同类型的节。

    #### 进行中

    - 显示当前进行中的比赛信息，包括队伍名称和相关状态。
    - 使用特定图标来直观表示进行中的比赛状态。

    #### 未开始

    - 显示未开始比赛的标题，提示用户即将到来的赛事。
    - 使用相应图标表示未开始的比赛，增强信息传达。

    #### 所有

    - 显示所有联赛或比赛的信息，可能根据时间动态更新标题。
    - 使用特定图标表示所有比赛，帮助用户快速识别。

    #### 置顶赛事

    - 显示“置顶赛事”的标题，突出重要赛事信息。
    - 使用相应图标表示置顶赛事，增强用户关注度。

    ### UI 组件

    - 使用 `InkWell` 实现点击事件，使用户能够通过点击节标题来展开或收起节内容。
    - 包含一个 `Column`，其中包含：
    - **图标**和**标题**，提供清晰的信息展示。
    - **展开/收起的提示**，根据 `isExpand` 状态动态显示，明确指示用户当前节的状态。
 *
 */

///新手版 赛事头部 进行中 展开
class SectionHeaderWidget extends StatelessWidget {
  SectionHeaderWidget(
      {super.key,
        required this.isExpand,
        required this.onExpand,
        required this.sectionGroupEnum});

  /// 是否展开
  final bool isExpand;

  final ValueChanged<bool> onExpand;
  final SectionGroupEnum sectionGroupEnum;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    ///根据不同类型做头部样式颜色的配置
    final sectionConfig = _buildSectionConfig(context);

    return InkWell(
      onTap: () {
        if (ConfigController.to.accessConfig.value.tourSwitch) {
          onExpand(!isExpand);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.04)
              : Colors.white,
          border: Border(
            top: BorderSide(width: 2, color: sectionConfig.dividerColor),
          ),
        ),
        child: Row(
          children: [
            ImageView(sectionConfig.icon, width: 14.w, height: 14.w),
            SizedBox(width: 4.w),
            Text(
              sectionConfig.title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp.scale,
                fontFamily: 'PingFang SC',
                color: isDark
                    ? Colors.white.withValues(alpha: 0.9)
                    : const Color(0xff303442),
              ),
            ),
            const Spacer(),
            Obx(() => _buildExpandButton(context)),
          ],
        ),
      ),
    );
  }

  ///SectionGroup样式的配置抽离
  SectionConfig _buildSectionConfig (BuildContext context){
    final home = TyHomeController.to.homeState;
    switch (sectionGroupEnum) {
      case SectionGroupEnum.IN_PROGRESS:
        return SectionConfig(
          dividerColor: const Color(0xff127DCC).withAlpha(70),
          title: home.menu.type == 4
              ? LocaleKeys.filter_all_leagues.tr
              : LocaleKeys.list_match_doing.tr,
          icon: 'assets/images/league/icon_processing.svg',
        );

      case SectionGroupEnum.NOT_STARTED:
        return SectionConfig(
          dividerColor: const Color(0xff127DCC).withAlpha(70),
          title: LocaleKeys.list_match_no_start.tr,
          icon: 'assets/images/league/icon_notstarted.svg',
        );

      case SectionGroupEnum.ALL:
        return SectionConfig(
          dividerColor: const Color(0xFFFEAE2B).withAlpha(60),
          title: _formatAllTitle(home.dateTime),
          icon: 'assets/images/league/icon_all.svg',
        );

      case SectionGroupEnum.Pin:
        return SectionConfig(
          dividerColor: const Color(0xFFFEAE2B),
          title: LocaleKeys.analysis_top_title.tr,
          icon: 'assets/images/pin.png',
        );
      case SectionGroupEnum.SELECTED:
        return SectionConfig(
          dividerColor:const Color(0xff179CFF),
          title: '',
          icon: '',
        );
    }
}

  /// 时间格式逻辑抽离
  String _formatAllTitle(int? dateTime) {
    if (dateTime == null || dateTime <= 0) {
      return LocaleKeys.filter_all_leagues.tr;
    }
    return DateUtil.formatDateMs(
      dateTime,
      format: LocaleKeys.time2.tr,
      isUtc: true,
    );
  }

  ///展开/收起按钮抽离
  Widget _buildExpandButton(BuildContext context) {
    final isDark = context.isDarkMode;
    final enable = ConfigController.to.accessConfig.value.tourSwitch;
    if (!enable) return 0.verticalSpaceFromWidth;
    // MatchEntity matchEntity = logic.getMatchById(match.mid) ?? match;
    // matchEntity.isExpand
    // AppLogger.debug("=============>isExpand   ${isExpand}   tourSwitch   ${ConfigController.to.accessConfig.value.tourSwitch}");
      // false 展开 ，   true 收起
      // return isExpandText(isExpand, context.isDarkMode);
    return Container(
      height: 20.w.scale,
      decoration: ShapeDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : const Color(0xFFF8F9FA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isExpand ? LocaleKeys.tips_close.tr : LocaleKeys.tips_expand.tr,
            style: TextStyle(
              fontSize: 12.sp.scale,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.4)
                  : const Color(0xFF949AB6),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 2),
          Transform.rotate(
            angle: isExpand ? 0 : -pi / 2,
            child: ImageView(
              isDark
                  ? 'assets/images/league/tips_expand_dark.png'
                  : 'assets/images/league/tips_expand_light.png',
              width: 10.w,
              height: 10.w,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionConfig {
  final Color dividerColor;
  final String title;
  final String icon;

  SectionConfig({
    required this.dividerColor,
    required this.title,
    required this.icon,
  });
}
