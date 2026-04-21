import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/change_skin_tone_color_util.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../main.dart';
import '../states/home_state.dart';

///新手版的骨架屏
class SkeletonNewItem extends StatelessWidget {
  const SkeletonNewItem({super.key});

  /// 通用骨架组件
  Widget skeletonBox({
    double? width,
    double? height,
    double radius = HomeState.skeletonBoxDefaultRadius,
    EdgeInsets? margin,
    required Color color,
  }) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  /// 小图标行（****5个18x18小方块）
  Widget skeletonIconRow(Color color) {
    return Row(
      children: List.generate(5, (index) {
        return skeletonBox(
          width: HomeState.skeletonIconSize,
          height: HomeState.skeletonIconSize,
          radius: HomeState.skeletonIconRadius,
          margin:
              const EdgeInsets.only(right: HomeState.skeletonIconMarginRight),
          color: color,
        );
      }),
    );
  }

  /// 统一按钮宽度逻辑
  double getBtnWidth() {
    return isIPad
        ? HomeState.professionalBtnWidthIPad.w
        : HomeState.professionalBtnWidthMobile.w;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    /// item 统一颜色
    final Color itemColor = isDark
        ? Colors.white.withValues(alpha: HomeState.skeletonOpacityDark)
        : Colors.grey.withValues(alpha: HomeState.skeletonOpacityLight);

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
            : HomeState.skeletonLightBackgroundColor,
        borderRadius: BorderRadius.circular(
            isDark ? 10.r : HomeState.skeletonBorderRadius.r),
      ),
      margin: EdgeInsets.only(bottom: HomeState.skeletonBottomMargin.h),
      padding: EdgeInsets.all(HomeState.skeletonItemPadding.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 顶部条骨架屏
            skeletonBox(
              height: HomeState.skeletonTopItemHeight,
              radius: HomeState.skeletonBoxDefaultRadius,
              color: itemColor,
            ),

            SizedBox(height: 8.h),

            /// 图标行
            skeletonIconRow(itemColor),

            SizedBox(height: 12.h),

            /// 两条横向骨架屏
            Row(
              children: [
                Expanded(
                  child: skeletonBox(
                    height: 20,
                    radius: 10,
                    color: itemColor,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: skeletonBox(
                    height: 20,
                    radius: 10,
                    color: itemColor,
                  ),
                ),
              ],
            ),

            8.verticalSpace,

            /// 按钮行骨架屏
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                skeletonBox(
                  width: getBtnWidth(),
                  height: 32,
                  radius: 4,
                  color: itemColor,
                ),
                8.horizontalSpace,
                skeletonBox(
                  width: getBtnWidth(),
                  height: 32,
                  radius: 4,
                  color: itemColor,
                ),
                8.horizontalSpace,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
