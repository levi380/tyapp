// 有些玩法（主要是角球）要换行显示比分,有总比分和基准分要展示时，只展示基准分不显示总比分,所以后面6个玩法从数组中去除了
// 33 -->  15分钟进球({a}-{b})-让球  232 --> 15分钟角球({a}-{b})-让球 113 --> 角球让球(全场) 121 --> 上半场角球让球
// 32、231 --> 15分钟(进球/角球)独赢  34、233 --> 15分钟(进球/角球)大小
import 'package:common_utils/common_utils.dart';

import '../../../../../../main.dart';
import '../../../../../config/app_logger/app_logger.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/ty_text_scaler.dart';
import '../../../../login/login_head_import.dart';
import '../../../extension/theme_extension.dart';

/**
 * 角球玩法ID列表常量
 * 
 * 功能说明：
 * - 定义所有角球相关的玩法ID
 * - 用于判断某个玩法是否为角球玩法
 * - 角球玩法需要特殊处理（如换行显示比分等）
 * 
 * 包含的玩法ID：
 * - 111: 角球让球(全场)
 * - 114-119: 其他角球相关玩法
 * - 122-124: 上半场角球相关玩法
 * - 226-229: 其他角球相关玩法
 */
const List<String> cornerBall = [
  "111", // 角球让球(全场)
  "114", // 角球相关玩法
  "115", // 角球相关玩法
  "116", // 角球相关玩法
  "117", // 角球相关玩法
  "118", // 角球相关玩法
  "119", // 角球相关玩法
  "122", // 上半场角球相关玩法
  "123", // 上半场角球相关玩法
  "124", // 上半场角球相关玩法
  "226", // 角球相关玩法
  "227", // 角球相关玩法
  "228", // 角球相关玩法
  "229"  // 角球相关玩法
];

/**
 * 加时赛玩法ID列表常量
 * 
 * 功能说明：
 * - 定义所有加时赛相关的玩法ID
 * - 用于判断某个玩法是否为加时赛玩法
 * - 加时赛玩法需要特殊处理（如显示加时赛比分等）
 * 
 * 包含的玩法ID：
 * - 331: 加时赛相关玩法
 * - 1100413-1100419: 加时赛相关玩法
 * - 1100407-1100412: 加时赛相关玩法
 */
// 是否是加时赛hpid
List<String> JIASHISAI_HPIDS = [
  "331",     // 加时赛相关玩法
  "1100413", // 加时赛相关玩法
  "1100417", // 加时赛相关玩法
  "1100415", // 加时赛相关玩法
  "1100418", // 加时赛相关玩法
  "1100419", // 加时赛相关玩法
  "1100407", // 加时赛相关玩法
  "1100405", // 加时赛相关玩法
  "1100410", // 加时赛相关玩法
  "1100408", // 加时赛相关玩法
  "1100411", // 加时赛相关玩法
  "1100412"  // 加时赛相关玩法
];

/**
 * 获取当前玩法实时比分
 * 
 * 功能说明：
 * - 根据玩法ID和比赛数据，获取当前玩法的实时比分
 * - 对于特殊玩法（如1100440、1100441），从比赛比分数据中提取
 * - 对于普通玩法，从hps字段中解析比分
 * 
 * 参数：
 * - item: 盘口数据对象，类型为MatchHps，包含玩法ID和比分信息
 * - match: 比赛实体对象，类型为MatchEntity?，包含比赛比分数据
 * 
 * 返回：
 * - String: 返回格式化后的比分字符串（如"1-0"），如果解析失败则返回空字符串
 */
/// 获取当前玩法实时比分
String getMatchHpsScore(MatchHps item, MatchEntity? match) {
  // 使用try-catch捕获可能的异常
  try {
    // 判断：如果玩法ID为"1100440"（主队获胜）或"1100441"（客队获胜）
    //  1100440 主队 获胜  客队 获胜 1100441
    if (item.hpid == "1100440" || item.hpid == "1100441") {
      // 从比赛比分数据中查找包含'S1|'的比分项
      // S1表示第一节比分
      String? found =
          match?.msc.firstWhereOrNull((score) => score.contains('S1|'));
      // 判断：如果找到了第一节比分
      if (found != null) {
        // 分割字符串，获取'S1|'后面的比分部分
        String scoreStr = found.split('S1|')[1];
        // 将比分字符串按':'分割成数组
        List<String> scores = scoreStr.split(':');
        // 解析主队得分，如果解析失败则默认为0
        int home = int.tryParse(scores[0]) ?? 0;
        // 解析客队得分，如果解析失败则默认为0
        int away = int.tryParse(scores[1]) ?? 0;
        // 返回格式化后的比分字符串（如"1-0"）
        return "$home-$away";
      }
    }
    // 对于普通玩法，从hps字段中解析比分
    // 判断：如果hps字段为空，返回空字符串
    return ObjectUtil.isEmptyString(item.hps)
        ? ""
        // 否则，从hps字段中解析比分
        // hps格式通常为"xxx|1:0"，需要分割后取第二部分，并将':'替换为'-'
        : item.hps.split("|")[1].replaceAll(":", "-");
  } 
  // 捕获异常，记录错误日志并返回空字符串
  catch (e) {
    // 记录调试日志，说明hps格式不正确
    AppLogger.debug("${item.hpid}:hps格式不正确");
    // 返回空字符串
    return "";
  }
}

/**
 * 根据数量获取对应宽高比
 * 
 * 功能说明：
 * - 根据投注项的数量，计算合适的宽高比
 * - 支持全屏模式和普通模式的适配
 * - 支持iPad和普通设备的适配
 * - 考虑文本缩放因子的影响
 * 
 * 参数：
 * - length: 投注项的数量，类型为int，取值范围为1-4
 * - fullscreen: 是否为全屏模式，类型为bool
 * 
 * 返回：
 * - double: 返回计算后的宽高比，用于Grid布局的childAspectRatio属性
 */
// 根据数量获取对应宽高比
double childAspectRatio(int length, bool fullscreen) {
  // 根据文本缩放因子计算高度系数
  // 如果文本缩放因子>1（字体放大），使用46作为高度系数，否则使用42
  // 字号放大 增加高度系数
  double heightRatio = TyTextScaler.instance().textScaleFactor > 1 ? 46 : 42;
  // 根据投注项数量返回对应的宽高比
  switch (length) {
    // 4个投注项的情况
    case 4:
      return fullscreen
          // 全屏模式：75.75 / 高度系数
          ? 75.75 / heightRatio
          // 普通模式：iPad使用196/62，其他设备使用85/高度系数
          : (isIPad ? 196 / 62 : 85 / heightRatio);
    // 3个投注项的情况
    case 3:
      return fullscreen
          // 全屏模式：100 / 高度系数
          ? 100 / heightRatio
          // 普通模式：iPad使用264/62，其他设备使用116/高度系数
          : (isIPad ? 264 / 62 : 116 / heightRatio);
    // 2个投注项的情况
    case 2:
      return fullscreen
          // 全屏模式：159 / 高度系数
          ? 159 / heightRatio
          // 普通模式：iPad使用400/62，其他设备使用178/高度系数
          : (isIPad ? 400 / 62 : 178 / heightRatio);
    // 1个投注项的情况
    case 1:
      return fullscreen
          // 全屏模式：340 / 高度系数
          ? 340 / heightRatio
          // 普通模式：iPad使用808/62，其他设备使用364/高度系数
          : (isIPad ? 808 / 62 : 364 / heightRatio);
    // 默认情况（其他数量）
    default:
      return fullscreen
          // 全屏模式：75.75 / 高度系数（与4个投注项相同）
          ? 75.75 / heightRatio
          // 普通模式：iPad使用196/62，其他设备使用85/高度系数（与4个投注项相同）
          : (isIPad ? 196 / 62 : 85 / heightRatio);
  }
}

/**
 * 空白占位符组件
 * 
 * 功能说明：
 * - 创建一个显示"-"的占位符容器
 * - 用于在投注项不可用或关闭时显示
 * - 支持全屏模式和普通模式的样式适配
 * 
 * 参数：
 * - fullscreen: 是否为全屏模式，类型为bool
 * - width: 容器宽度，类型为double?，可选参数
 * - height: 容器高度，类型为double?，可选参数
 * 
 * 返回：
 * - Widget: 返回包含"-"文本的容器组件
 */
Widget blankPlaceholder(fullscreen, {double? width, double? height}) {
  // 返回容器组件
  return Container(
    // 设置容器宽度
    width: width,
    // 设置容器高度
    height: height,
    // 设置内容对齐方式为居中
    alignment: Alignment.center,
    // 设置裁剪行为为抗锯齿
    clipBehavior: Clip.antiAlias,
    // 设置容器装饰样式
    decoration: ShapeDecoration(
      // 设置背景颜色
      // 全屏模式：白色半透明（alpha: 0.08）
      // 普通模式：使用主题中的赔率按钮背景颜色
      color: fullscreen
          ? Colors.white.withValues(alpha: 0.08)
          : Get.theme.oddsButtonBackgroundColor,
      // 设置圆角矩形形状，圆角半径为8
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      // 设置阴影效果
      shadows: [
        BoxShadow(
          // 设置阴影颜色
          // 全屏模式：透明（不显示阴影）
          // 普通模式：使用主题中的赔率按钮阴影颜色
          color:
              fullscreen ? Colors.transparent : Get.theme.oddsButtonShadowColor,
          // 设置阴影模糊半径为8
          blurRadius: 8,
          // 设置阴影偏移量：x=0，y=2.h（向下偏移2.h）
          offset: Offset(0, 2.h),
          // 设置阴影扩散半径为0（不扩散）
          spreadRadius: 0,
        )
      ],
    ),
    // 容器子组件：显示"-"文本
    child: Text(
      // 显示"-"字符
      "-",
      // 设置文字溢出处理方式：使用省略号（...）表示
      overflow: TextOverflow.ellipsis,
      // 设置最大行数为1行，防止文字换行
      maxLines: 1,
      // 设置文字样式
      style: TextStyle(
        // 设置文字颜色
        // 全屏模式：白色半透明（alpha: 0.5）
        // 普通模式：使用主题中的赔率按钮名称文字颜色
        color: fullscreen
            ? Colors.white.withValues(alpha: 0.5)
            : Get.theme.oddsButtonNameFontColor,
        // 设置字体粗细为400（正常）
        fontWeight: FontWeight.w400,
        // 设置字体大小
        // 全屏模式：iPad使用16，其他设备使用12
        // 普通模式：使用主题中的12号字体大小
        fontSize: fullscreen ? (isIPad ? 16 : 12) : Get.theme.fontSize_12,
        // 设置字体族为'PingFang SC'（中文字体）
        fontFamily: 'PingFang SC',
      ),
    ),
  );
}

/**
 * 判断玩法是否应该移除
 * 
 * 功能说明：
 * - 检查玩法中的所有盘口是否都已关盘（hs == 2）
 * - 如果所有盘口都关盘，则该玩法应该被移除
 * 
 * 参数：
 * - item: 盘口数据对象，类型为MatchHps，包含盘口列表
 * 
 * 返回：
 * - bool: 返回true表示应该移除，false表示不应该移除
 */
///@description hl里面的每一个盘口都关盘的话，移除这个玩法
///@return {Boolean}
bool isRemove(MatchHps item) {
  // 获取盘口列表
  List<MatchHpsHl> hl_ = item.hl;
  // 初始化结果为true（默认应该移除）
  bool res = true;
  // 使用every方法检查所有盘口是否都关盘（hs == 2）
  // 如果所有盘口的hs都为2，则res为true（应该移除）
  res = hl_.every((data) => data.hs == 2);
  // 返回结果
  return res;
}

/**
 * 判断玩法盘口的显示或隐藏
 * 
 * 功能说明：
 * - 检查玩法是否有可用的盘口
 * - 如果盘口列表为空，则应该隐藏该玩法
 * 
 * 参数：
 * - item: 盘口数据对象，类型为MatchHps，包含盘口列表
 * 
 * 返回：
 * - bool: 返回true表示应该隐藏，false表示应该显示
 */
///@description 判断玩法盘口的显示或者是隐藏
///@param {Undefined}
///@return {String} 是否显示主盘或者附加盘
bool isHide(MatchHps item) {
  // 获取盘口列表的长度
  var len = item.hl.length;
  // 判断：如果盘口列表长度<=0（没有盘口）
  if (len <= 0) {
    // 返回true（应该隐藏）
    return true;
  } 
  // 如果盘口列表长度>0（有盘口）
  else {
    // 返回false（应该显示）
    return false;
  }
}
