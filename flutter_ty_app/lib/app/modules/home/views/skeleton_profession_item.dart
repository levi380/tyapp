import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../main.dart';
import '../states/home_state.dart';

///首页骨架屏
class SkeletonProfessionItem extends StatelessWidget {
  const SkeletonProfessionItem({super.key});

  @override
  Widget build(BuildContext context) {
    final itemColor = context.isDarkMode
        ? Colors.white.withValues(alpha: HomeState.skeletonOpacityDark)
        : Colors.grey.withValues(alpha: HomeState.skeletonOpacityLight);

    final double itemWidth = isIPad
        ? ((Get.width - 28.w - 18.w) * 0.5) / 3
        : HomeState.professionalBtnWidthMobile;

    return Container(
      decoration: context.isDarkMode
          ? const BoxDecoration()
          : BoxDecoration(
              color: HomeState.skeletonLightBackgroundColor,
              borderRadius:
                  BorderRadius.circular(HomeState.skeletonBorderRadius.r),
            ),
      margin: EdgeInsets.only(bottom: HomeState.skeletonBottomMargin.h),
      padding: EdgeInsets.all(HomeState.skeletonItemPadding.w),
      child: _SkeletonWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 顶部标题骨架屏
            SkeletonBox(
                width: double.infinity,
                height: HomeState.skeletonTopItemHeight,
                radius: HomeState.skeletonBoxDefaultRadius,
                color: itemColor),
            SizedBox(height: HomeState.skeletonTopItemSpacing.h),

            /// 顶部 3 个的小条骨架屏
            _buildTopThreeItems(itemWidth, itemColor),
            SizedBox(height: HomeState.skeletonTopItemSpacing.h),
            SkeletonBox(
                width: HomeState.skeletonMiddleItemWidth,
                height: HomeState.skeletonMiddleItemHeight,
                radius: HomeState.skeletonMiddleItemRadius,
                color: itemColor),
            SizedBox(height: HomeState.skeletonTopItemSpacing.h),

            /// 中间区域（左侧信息 + 右侧方块骨架屏）
            _buildMiddleSection(itemWidth, itemColor),
            SizedBox(height: 7.h),

            /// 底部 5 个小条骨架屏
            Row(
              children: List.generate(5, (_) {
                return SkeletonBox(
                  width: HomeState.skeletonItemWidth,
                  height: HomeState.skeletonItemHeight,
                  radius: HomeState.skeletonItemRadius,
                  color: itemColor,
                ).marginOnly(right: HomeState.skeletonIconMarginRight);
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// 顶部三段横条的骨架屏
  Widget _buildTopThreeItems(double itemWidth, Color color) {
    return Row(
      children: [
        const Spacer(),
        SkeletonBox(width: itemWidth, height: 12, radius: 24, color: color),
        SkeletonBox(
          width: itemWidth,
          height: 12,
          radius: 24,
          color: color,
        ).marginSymmetric(horizontal: 2),
        SkeletonBox(width: itemWidth, height: 12, radius: 24, color: color),
      ],
    );
  }

  /// 中间区域，大块内容 + 右侧多个竖向骨架块
  Widget _buildMiddleSection(double itemWidth, Color color) {
    return Row(
      children: [
        /// 骨架屏左侧详情骨架
        Expanded(
          child: SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                SkeletonBox(width: 100, height: 18, radius: 100, color: color),
                const SizedBox(height: 16),
                SkeletonBox(width: 100, height: 18, radius: 100, color: color),
                const SizedBox(height: 16),
                Row(
                  children: List.generate(5, (_) {
                    return Expanded(
                      child: SkeletonBox(
                        width: 18,
                        height: 18,
                        radius: 4,
                        color: color,
                      ).marginOnly(right: 4),
                    );
                  }),
                )
              ],
            ),
          ),
        ),

        /// 骨架屏右侧的赔率方块
        SizedBox(
          height: 100,
          child: Row(
            children: [
              _buildVerticalBlocks(
                  count: 3, width: itemWidth, height: 32, color: color),
              const SizedBox(width: 2),
              _buildVerticalBlocks(
                  count: 2, width: itemWidth, height: 49, color: color),
              const SizedBox(width: 2),
              _buildVerticalBlocks(
                  count: 2, width: itemWidth, height: 49, color: color),
            ],
          ),
        ),
      ],
    );
  }

  /// 右侧骨架屏竖排方块
  Widget _buildVerticalBlocks({
    required int count,
    required double width,
    required double height,
    required Color color,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(count, (_) {
        return SkeletonBox(
            width: width, height: height, radius: 4, color: color);
      }),
    );
  }
}

class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color color;

  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 4,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _SkeletonWrapper extends StatelessWidget {
  final Widget child;

  const _SkeletonWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }
}

