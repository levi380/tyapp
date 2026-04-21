import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../controllers/statistic/season_statistic_controller.dart';
import '../../../../models/analysis/analysis_model.dart';

/// 本赛季数据网格组件
/// 用于展示赛季统计数据，包括大球、小球、总进球数等数据指标
class SeasonStatisticDataGrid {
  /// 构建数据网格视图
  /// [controller] 赛季统计控制器，包含数据源和状态管理
  /// 返回一个GridView，展示赛季各项统计数据
  static Widget buildDataGrid(SeasonStatisticController controller) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.w,
        crossAxisSpacing: 8.w,
      ),
      itemCount: controller.listSaishiDurationDataBeans.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildDataGridItem(
            controller.listSaishiDurationDataBeans[index]);
      },
    );
  }

  /// 构建单个数据网格项
  /// [dataBean] 数据项，包含图标、名称、数值等信息
  /// 返回一个包含头部、数值和底部的卡片容器
  static Widget _buildDataGridItem(ListSaishiDurationDataBean dataBean) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          color: Get.theme.oddsButtonBackgroundColor,
          border: Border.all(color: Get.theme.tabAnaysisBgColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDataGridItemHeader(dataBean),
          _buildDataGridItemValue(dataBean),
          _buildDataGridItemFooter(dataBean),
        ],
      ),
    );
  }

  /// 构建数据网格项头部
  /// [dataBean] 数据项
  /// 返回包含图标、名称和帮助按钮的头部容器
  static Widget _buildDataGridItemHeader(
      ListSaishiDurationDataBean dataBean) {
    return Container(
      alignment: Alignment.center,
      height: 28.w,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.w), topLeft: Radius.circular(12.w)),
        color: Get.theme.analsTextTabBgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDataGridItemHeaderTitle(dataBean),
          _buildDataGridItemHeaderHelpButton(dataBean),
        ],
      ),
    );
  }

  /// 构建数据网格项头部标题部分
  /// [dataBean] 数据项
  /// 返回包含图标和名称的行组件
  static Widget _buildDataGridItemHeaderTitle(
      ListSaishiDurationDataBean dataBean) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ImageView(
          dataBean.img ?? "",
          boxFit: BoxFit.fill,
          width: 14.w,
          height: 14.w,
        ),
        SizedBox(
          width: 4.w,
        ),
        Container(
            width: 80.w,
            child: Text(
              dataBean.name1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Get.theme.betItemTitleColor, fontSize: (12.sp)),
            )),
      ],
    );
  }

  /// 构建数据网格项头部帮助按钮
  /// [dataBean] 数据项，点击时显示帮助信息
  /// 返回一个可点击的帮助图标按钮
  static Widget _buildDataGridItemHeaderHelpButton(
      ListSaishiDurationDataBean dataBean) {
    return InkWell(
      onTap: () {
        ToastUtils.show(dataBean.contentTitle ?? "");
      },
      child: Container(
        child: ImageView(
          "assets/images/bets/analyze_question2.png",
          width: 14.w,
          height: 14.w,
        ),
      ),
    );
  }

  /// 构建数据网格项数值显示
  /// [dataBean] 数据项
  /// 返回显示主要数值的文本组件
  static Widget _buildDataGridItemValue(ListSaishiDurationDataBean dataBean) {
    return Text(
      "${dataBean.name3}",
      style: TextStyle(
          color: Get.theme.betItemTitleColor,
          fontSize: (14.sp),
          fontWeight: FontWeight.w900),
    );
  }

  /// 构建数据网格项底部信息
  /// [dataBean] 数据项
  /// 返回包含标签和数值的底部容器
  static Widget _buildDataGridItemFooter(
      ListSaishiDurationDataBean dataBean) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      margin: EdgeInsets.only(bottom: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.analysis_football_matches_cup.tr,
            style: TextStyle(
                color: Get.theme.betItemTitleColor, fontSize: (12.sp)),
          ),
          Text(
            "${dataBean.name2}",
            style: TextStyle(
                color: Get.theme.betItemTitleColor, fontSize: (12.sp)),
          ),
        ],
      ),
    );
  }
}

