import 'package:flutter_svgaplayer3/parser.dart';
import 'package:flutter_svgaplayer3/player.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import '../../modules/login/login_head_import.dart';
import '../../utils/oss_util.dart';
import 'fireworks_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-38f82dfe-f843-439e-8655-2c32f6e9307f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE 定时烟花】】】
    【【【 AUTO_PARAGRAPH_TITLE 烟花播放 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    # FireworksAnimation 类

    ### 功能
    `FireworksAnimation` 是一个 Flutter 的状态管理组件，用于显示烟花动画，包含冠军名称和图标的展示。

    ### 属性
    - `int type`：烟花类型。
    - `RxInt number`：播放次数。
    - `String championName`：冠军名称。
    - `String championIcon`：冠军图标。
    - `int beginTime`：动画开始时间。
    - `int endTime`：动画结束时间。
    - `int id`：唯一标识符。

    ### 方法
    - **构造函数**：初始化所有属性。
    - **initState**：初始化动画控制器并加载动画。
    - **dispose**：释放资源，停止动画。
    - **calculateOffsets**：计算控件的偏移量。
    - **loadAnimation**：加载烟花动画。
    - **handleAnimationStatus**：处理动画状态变化。
    - **build**：构建动画和相关 UI 组件。

    ### 重要实现
    - **动画控制**：
    - 使用 `SVGAAnimationController` 控制动画播放。
    - 根据类型加载不同的 SVGA 动画文件。
    - 支持重复播放和状态监听。

    - **UI 组件**：
    - 使用 `SlideTransition` 和 `FadeTransition` 来实现动画效果。
    - 显示冠军名称和图标，支持暗黑模式下的样式调整。


    】】】
 *
 */
class FireworksAnimation extends StatefulWidget {
  final int type; // 烟花类型
  final RxInt number; // 播放次数
  final String championName; // 冠军名称
  final String championIcon; // 冠军图标
  final int beginTime; // 开始时间
  final int endTime; // 结束时间
  final int id; // 结束时间

  FireworksAnimation({
    Key? key,
    required this.id,
    required this.beginTime,
    required this.endTime,
    required this.type,
    required this.number,
    required this.championName,
    required this.championIcon,
  }) : super(key: key);

  @override
  State<FireworksAnimation> createState() => _FireworksAnimationState();
}

class _FireworksAnimationState extends State<FireworksAnimation>
    with SingleTickerProviderStateMixin {
  late SVGAAnimationController animationController; // 动画控制器
  late Animation<Offset> sideAnimation; // 平移动画

  // 控件中心坐标
  double dx = 0.0, dy = 0.0;
  late double w = 150; // 控件宽度
  late double h = 80; // 控件高度
  bool isAnimationVisible = true; // 控制动画是否可见
  bool isFirst = true; // 存储一次
  int maxLines = 4; // 默认
  @override
  void initState() {
    super.initState();
    animationController = SVGAAnimationController(vsync: this); // 初始化动画控制器
    loadAnimation(); // 加载动画
    calculateOffsets(); // 计算偏移量
  }

  // 计算控件的偏移量
  void calculateOffsets() {
    dx = ((Get.width - w) / w) / 2; // 计算水平偏移
    dy = ((Get.height) / h); // 计算垂直偏移

    sideAnimation = Tween(begin: Offset(dx, dy), end: Offset(dx, 2))
        .animate(animationController); // 创建平移动画
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ///横竖屏动态计算 logo偏移量
    if (Get.width > Get.height) {
      maxLines = 1;
      h = 50; // 控件高度
      w = 250;
      dy = ((Get.width) / h); // 计算垂直偏移
      dx = ((Get.height - (w / 2)) / w); // 计算水平偏移
      sideAnimation = Tween(begin: Offset(dx, dy), end: Offset(dx, 1))
          .animate(animationController); // 创建平移动画
    } else {
      maxLines = 4;
      h = 80; // 控件高度
      w = 150;
      dx = ((Get.width - w) / w) / 2; // 计算水平偏移
      dy = ((Get.height) / h); // 计算垂直偏移
      sideAnimation = Tween(begin: Offset(dx, dy), end: Offset(dx, 2))
          .animate(animationController); // 创建平移动画
    }
  }

  @override
  void dispose() {
    animationController.stop(canceled: true); // 停止动画
    animationController.clear(); // 清理动画项
    animationController.dispose(); // 释放动画控制器
    super.dispose();
  }

  // 加载烟花动画
  void loadAnimation() async {
    try {
      // 根据类型加载不同的 SVGA 动画
      final videoItem = await SVGAParser.shared.decodeFromURL(
        widget.type == 1
            ? "${OssUtil.getServerPath("")}/assets-2024-04-05-12-00/assets/images/home/fireworks_slima.svga?raw=true"
            : "${OssUtil.getServerPath("")}/assets-2024-04-05-12-00/assets/images/home/fireworks_big.svga?raw=true",
      );
      animationController.videoItem = videoItem; // 设置动画项

      animationController.repeat(
          period: Duration(seconds: 5), reverse: false); // 重复播放动画
      animationController.addStatusListener((status) {
        handleAnimationStatus(status); // 处理动画状态
      });

      animationController.forward(); // 播放动画
    } catch (e) {
      AppLogger.debug("Error loading animation: $e"); // 错误处理
    }
  }

  // 处理动画状态
  void handleAnimationStatus(AnimationStatus status) {
    setState(() {
      if (status == AnimationStatus.completed) {
        if (widget.number.value > 1 && widget.number.value <= 3) {
          widget.number.value--; // 减少播放次数
          animationController.reset(); // 重置动画
          animationController.forward(); // 播放下一次动画
        } else if (widget.number.value > 3) {
          animationController.reset(); // 重置动画
          animationController.forward(); // 播放下一次动画
        } else {
          widget.number.value = 0; // 设置播放次数为零
          animationController.stop(canceled: true); // 停止动画
          isAnimationVisible = false; // 动画结束后隐藏
          animationController.clear(); // 清理动画项
          animationController.dispose(); // 释放动画控制器
        }
        if (isFirst) {
          FireworksController.to.markAsPlayed(widget.id.toString()); // 记录播放状态
          isFirst = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 如果冠军名称和图标不为空，则显示相关信息
        if (isAnimationVisible &&
            (widget.championName.isNotEmpty || widget.championIcon.isNotEmpty))
          SlideTransition(
            position: sideAnimation, // 应用平移动画
            child: FadeTransition(
              opacity: Tween<double>(begin: 1.0, end: 0.5).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: Curves.easeIn,
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                width: w,
                height: h,
                child: Column(
                  children: [
                    if (widget.championIcon.isNotEmpty)
                      ImageView(
                        "${StringKV.imgUrl.get()}/${widget.championIcon}",
                        width: 25.w,
                        height: 25.w,
                        boxFit: BoxFit.contain,
                      ),
                    if (widget.championName.isNotEmpty)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                        decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? Color(0xff1F222B) // 暗黑模式下的背景颜色
                              : Color(0xffF8FAFF), // 默认背景颜色
                          borderRadius:
                              BorderRadius.all(Radius.circular(8)), // 圆角效果
                        ),
                        child: Text(
                          "${widget.championName}",
                          maxLines: maxLines, // 最大行数
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis, // 溢出处理
                            fontSize: 10.sp.scale,
                            color: Get.isDarkMode
                                ? Color(0xffF2F2F2)
                                : Color(0xff1D1D1D), // 字体颜色
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

        // 显示 SVGA 动画
        SVGAImage(
          animationController,
          fit: BoxFit.fitWidth,
          clearsAfterStop: true, // 停止后清理
        ),
      ],
    );
  }
}
