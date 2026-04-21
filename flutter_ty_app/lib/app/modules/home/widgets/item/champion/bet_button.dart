import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../../main.dart';
import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';
import '../../../../shop_cart/shop_cart_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-547f4052-1479-46be-a032-ebaae676b0c8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 冠军 】】】
    【【【 AUTO_PARAGRAPH_TITLE 冠军投注 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    ## 1. 枚举定义
    - **`BetButtonLayoutDirection`**: 定义按钮的布局方向。
    - `horizontal`: 水平布局
    - `vertical`: 垂直布局

    ## 2. `BetButton` 类
    - **构造函数**:
    - 接收按钮的宽度、布局方向和比赛数据。
    - **属性**:
    - `width`: 按钮的宽度。
    - `matchHpsHlOl`: 包含比赛信息的对象。
    - `direction`: 布局方向，默认为垂直。

    ## 3. `_BetButtonState` 类
    - **状态管理**:
    - `selected`: 表示按钮是否被选中。

    - **生命周期方法**:
    - **`initState`**:
    - 监听赔率按钮更新事件。
    - 检查购物车中是否选中该比赛，并更新 `selected` 状态。
    - **`dispose`**:
    - 清理事件监听器。

    ## 4. UI 构建
    - **`build` 方法**:
    - 使用 `GetBuilder` 监听数据变化。
    - 根据比赛 ID 获取最新的比赛数据，构建按钮外观。
    - **按钮样式**:
    - 根据选中状态和主题设置背景色和圆角。

    ## 5. 内容构建
    - **`buildHorizontal` 方法**:
    - 创建水平布局的行，包含比赛信息和赔率。
    - 使用 `Text` 和 `AutoSizeText` 显示比赛名称和格式化后的赔率。

    ## 6. 数字格式化
    - **`formatNumber` 方法**:
    - 根据传入的数字格式化为有效数字，最多显示三位有效数字，返回格式化后的字符串。
    】】】
 *
 */
enum BetButtonLayoutDirection {
  horizontal, // 水平布局
  vertical, // 垂直布局
}

class BetButton extends StatefulWidget {
  const BetButton({
    super.key,
    required this.width, // 按钮的宽度
    this.direction = BetButtonLayoutDirection.vertical, // 布局方向，默认为垂直
    required this.matchHpsHlOl, // 传入的比赛数据
  });

  final BetButtonLayoutDirection? direction; // 布局方向
  final MatchHpsHlOl matchHpsHlOl; // 比赛数据
  final double width; // 按钮的宽度

  @override
  State<BetButton> createState() => _BetButtonState(); // 创建状态
}

class _BetButtonState extends State<BetButton> {
  bool selected = false; // 选中状态

  @override
  void dispose() {
    // 移除事件监听
    Bus.getInstance().off(EventType.oddsButtonUpdate);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // 监听赔率按钮更新事件
    Bus.getInstance().on(EventType.oddsButtonUpdate, (_) {
      if (mounted) {
        // 检查购物车中是否选中该比赛
        bool checked = ShopCartController.to.isCheck(widget.matchHpsHlOl.oid);
        // 如果选中状态变化，更新状态
        if (selected != checked) {
          setState(() {
            selected = checked;
          });
        }
      }
    });
  }

  // 构建水平布局的内容
  Widget buildHorizontal(MatchHpsHlOl ol, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w), // 设置左右内边距
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 子组件间隔均匀分布
        crossAxisAlignment: CrossAxisAlignment.center, // 子组件垂直居中
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: isIPad ? 28.w : 0.w),
              // iPad特定的右内边距
              child: Text(
                ObjectUtil.isEmptyString(ol.on) ? ol.ot : ol.on, // 显示比赛信息
                maxLines: 2, // 最多显示两行
                textAlign: TextAlign.left, // 左对齐
                overflow: TextOverflow.ellipsis, // 超出部分用省略号表示
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha:0.8999999761581421) // 深色模式字体颜色
                      : const Color(0xFF303442),
                  // 默认字体颜色
                  fontSize: isIPad ? 14.sp.scale : 12.sp.scale,
                  // 字体大小
                  height: 1.2,
                  // 行高
                  fontFamily: "Akrobat",
                  // 字体
                  fontWeight: FontWeight.w400, // 字体粗细
                ),
              ),
            ),
          ),
          AutoSizeText(
            formatNumber(ol.ov), // 格式化赔率并显示
            textAlign: TextAlign.right, // 右对齐
            minFontSize: 10, // 最小字体大小
            style: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.8999999761581421)
                  : const Color(0xFF303442),
              fontSize: isIPad ? 16.sp.scale : 14.sp.scale,
              fontFamily: "Akrobat",
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  /// 只显示三位有效数字
  String formatNumber(int number) {
    double result = number / 100000; // 将数字缩放
    String resultStr;
    // 根据结果大小决定显示格式
    if (result >= 100) {
      resultStr = result.toStringAsFixed(0); // 整数
    } else if (result >= 10) {
      resultStr = result.toStringAsFixed(1); // 一位小数
    } else {
      resultStr = result.toStringAsFixed(2); // 两位小数
    }
    return resultStr; // 返回格式化后的字符串
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
        id: DataStoreController.to.getOid(widget.matchHpsHlOl.oid), // 获取唯一ID
        builder: (logic) {
          // 根据ID获取最新的比赛数据
          MatchHpsHlOl ol =
              DataStoreController.to.getOlById(widget.matchHpsHlOl.oid) ??
                  widget.matchHpsHlOl;

          return Container(
            width: widget.width, // 设置按钮宽度
            alignment: Alignment.center, // 内容居中
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
              color: selected
                  ? Get.theme.oddsButtonSelectedBackgroundColor // 选中时背景色
                  : (context.isDarkMode
                      ? Colors.white.withValues(alpha:0.07999999821186066)
                      : const Color(0xFFFFFFFE)),
              borderRadius: BorderRadius.circular(
                  widget.direction == BetButtonLayoutDirection.vertical
                      ? 4.w // 垂直布局的圆角
                      : 8.w), // 水平布局的圆角
            ),
            child: buildHorizontal(ol, context), // 根据布局方向构建内容
          );
        });
  }
}
