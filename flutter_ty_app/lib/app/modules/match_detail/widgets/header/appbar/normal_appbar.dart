import '../../../../../../generated/locales.g.dart';
import '../../../../../../main.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';
import '../../../../../widgets/marquee.dart';
import '../../../../login/login_head_import.dart';
import '../../../constants/detail_constant.dart';
import '../../../controllers/match_detail_controller.dart';
import '../../../controllers/match_tools_methods.dart';
import '../../../models/header_type_enum.dart';
import 'package:rxdart/rxdart.dart';

import '../half_modal_overlay.dart';
import '../match_select_widget.dart';

/**
 * 赛事详情页普通头部组件
 *
 * 功能说明：
 * 1. 显示返回按钮、赛事标题、刷新按钮
 * 2. 支持标题跑马灯滚动（当标题过长时）
 * 3. 支持点击标题打开赛事选择模态框
 * 4. 支持刷新动画
 * 5. 支持比分展示（视频/动画直播模式）
 */
class NormalAppbar extends StatefulWidget {
  const NormalAppbar({
    super.key,
    required this.match,
    required this.controller,
    this.tag
  });

  final MatchEntity match;
  final MatchDetailController controller;
  final String? tag;

  @override
  State<NormalAppbar> createState() => _NormalAppbarState();
}

class _NormalAppbarState extends State<NormalAppbar>
    with SingleTickerProviderStateMixin {

  // ============= 状态变量 =============

  /// 用于防抖刷新的Subject
  final _refreshSubject = BehaviorSubject<Function>();

  /// 刷新按钮旋转动画控制器
  late AnimationController _animationController;

  /// 是否开启跑马灯滚动
  bool runMarquee = false;

  /// 模态框是否打开的状态
  final isDialogOpen = false.obs;

  /// 半屏模态框控制器
  HalfModalController? _modalController;

  // ============= 生命周期 =============

  @override
  void initState() {
    super.initState();
    _initMarquee();
    _initRefreshDebounce();
    _initAnimationController();
    _initBusListeners();
  }

  @override
  void dispose() {
    _cleanupResources();
    super.dispose();
  }

  // ============= 初始化方法 =============

  /// 初始化跑马灯：5秒后开启滚动
  void _initMarquee() {
    5.delay(() {
      if (mounted) {
        setState(() {
          runMarquee = true;
        });
      }
    });
  }

  /// 初始化刷新防抖：1100ms内多次触发只执行最后一次
  void _initRefreshDebounce() {
    _refreshSubject
        .debounceTime(const Duration(milliseconds: 1100))
        .listen((callback) {
      callback();
    });
  }

  /// 初始化动画控制器
  void _initAnimationController() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    )..addStatusListener((status) {
      // 动画完成后重置，以便下次点击可以重新播放
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });
  }

  /// 初始化事件总线监听
  void _initBusListeners() {
    Bus.getInstance().on(EventType.matchDetailMatchListClosed, (value) {
      isDialogOpen.value = false;
    });
  }

  /// 清理资源
  void _cleanupResources() {
    Bus.getInstance().off(EventType.matchDetailMatchListClosed);
    _refreshSubject.close();
    _animationController.dispose();
    _closeModal();
  }

  // ============= 模态框操作 =============

  /// 打开半屏模态框
  void _openModal(Widget child, double topHeight) {
    _modalController = showHalfModal(
      context: context,
      topHeight: topHeight,
      child: child,
    );
    isDialogOpen.value = true;
  }

  /// 检查模态框状态并返回是否需要关闭
  /// 返回 true 表示需要关闭，false 表示需要打开
  bool _checkModalStatus() {
    if (_modalController?.isOpened == true) {
      isDialogOpen.value = false;
      return true; // 已打开，需要关闭
    } else {
      isDialogOpen.value = true;
      return false; // 未打开，需要打开
    }
  }

  /// 关闭模态框
  void _closeModal() {
    isDialogOpen.value = false;
    _modalController?.close();
    _modalController = null;
  }

  // ============= 构建方法 =============

  @override
  Widget build(BuildContext context) {
    /// 普通标题宽度 = 屏幕宽度 - 左右两边留白(左右各50)
    double normalTitleWidth = 1.sw - 100.w;

    /// 跑马灯最大宽度 = 标题宽度 - 三角形图标宽度 - 间距
    double maxMarqueeWidth = normalTitleWidth - 12.w - 4.w;

    return Obx(() {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          _buildBackButton(),
          _buildTitleSection(normalTitleWidth, maxMarqueeWidth),
          _buildRefreshButton(),
        ],
      );
    });
  }

  /// 构建返回按钮
  Widget _buildBackButton() {
    return Positioned(
      left: 0,
      child: AnimatedOpacity(
        /// 根据头部类型和视频顶部显示状态控制透明度
        opacity: (widget.controller.detailState.headerType.value == HeaderType.normal ||
            widget.controller.detailState.videoTopShow.value) ? 1.0 : 0,
        duration: const Duration(milliseconds: 300),
        child: InkWell(
          onTap: () {
            _closeModal();
            widget.controller.back();
          },
          child: Container(
            width: 24.w,
            height: obtyAppbarHeight,
            alignment: Alignment.center,
            child: ImageView(
              "assets/images/detail/icon_arrowleft_nor_night.svg",
              boxFit: BoxFit.fill,
              width: isIPad ? 14.w : 8.w,
            ),
          ),
        ),
      ),
    );
  }

  /// 构建标题区域（普通标题或比分标题）
  Widget _buildTitleSection(double normalTitleWidth, double maxMarqueeWidth) {
    // 根据头部类型决定显示普通标题还是比分标题
    if (widget.controller.detailState.headerType.value == HeaderType.normal) {
      return _buildNormalTitleSection(normalTitleWidth, maxMarqueeWidth);
    } else {
      return _buildVsScore(widget.match, widget.controller);
    }
  }

  /// 构建普通标题区域（可点击打开赛事选择）
  Widget _buildNormalTitleSection(double normalTitleWidth, double maxMarqueeWidth) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _handleTitleTap,
      child: Container(
        width: normalTitleWidth,
        alignment: Alignment.center,
        child: _buildTitleContent(maxMarqueeWidth),
      ),
    );
  }

  /// 处理标题点击事件
  void _handleTitleTap() {
    // 确保控制器已注册
    Get.put(MatchDetailController(tag: widget.tag ?? ""), tag: widget.tag);

    // 切换模态框状态
    if (_checkModalStatus()) {
      _closeModal();
    } else {
      _openModal(
          MatchSelectWidget(tag: widget.tag, match: widget.match),
          200.h + MediaQuery.of(context).padding.top
      );
    }
  }

  /// 构建标题内容（跑马灯标题或普通标题）
  Widget _buildTitleContent(double maxMarqueeWidth) {
    // 判断是否需要跑马灯效果
    if (needMarquee(
      text: widget.match.tn,
      fontSize: isIPad ? 20.sp : 18.sp,
      maxWidth: maxMarqueeWidth,
    )) {
      return _buildMarqueeTitle(maxMarqueeWidth, widget.match, widget.controller, isDialogOpen.value);
    } else {
      return _buildNormalTitle(widget.match, widget.controller, isDialogOpen.value);
    }
  }

  /// 构建刷新按钮
  Widget _buildRefreshButton() {
    // 只在普通头部且底部菜单隐藏时显示
    if (widget.controller.detailState.headerType.value != HeaderType.normal ||
        widget.controller.detailState.showBottom) {
      return const SizedBox.shrink();
    }

    return Positioned(
      right: 0,
      child: InkWell(
        onTap: _handleRefresh,
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 2.0).animate(_animationController),
          child: ImageView(
            'assets/images/shopcart/refresh1.png',
            color: Colors.white,
            width: isIPad ? 24.w : 18.w,
          ),
        ),
      ),
    );
  }

  /// 处理刷新点击
  void _handleRefresh() {
    // 防抖处理
    _refreshSubject.add(widget.controller.refreshData);

    // 播放旋转动画
    if (_animationController.status == AnimationStatus.completed ||
        _animationController.status == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  // ============= 标题构建方法 =============

  /// 构建跑马灯标题
  Widget _buildMarqueeTitle(
      double maxWidth,
      MatchEntity match,
      MatchDetailController controller,
      bool isDialogOpen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        runMarquee
            ? _buildMarqueeText(maxWidth, match.tn)
            : _buildStaticTitle(match.tn),
        _buildDropdownIcon(isDialogOpen),
      ],
    );
  }

  /// 构建跑马灯文本
  Widget _buildMarqueeText(double maxWidth, String text) {
    return SizedBox(
      width: maxWidth,
      child: Marquee(
        text: text,
        style: TextStyle(
          fontSize: isIPad ? 20.sp : 18.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        velocity: 30.0,
        blankSpace: 10.w,
      ),
    );
  }

  /// 构建静态标题
  Widget _buildStaticTitle(String text) {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(
          fontSize: isIPad ? 20.sp : 18.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  /// 构建普通标题（非跑马灯）
  Widget _buildNormalTitle(
      MatchEntity match,
      MatchDetailController controller,
      bool isDialogOpen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          match.tn,
          style: TextStyle(
            fontSize: isIPad ? 20.sp : 18.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 4.w),
        _buildDropdownIcon(isDialogOpen),
      ],
    );
  }

  /// 构建下拉箭头图标
  Widget _buildDropdownIcon(bool isDialogOpen) {
    return ImageView(
      isDialogOpen == false
          ? "assets/images/detail/icon_arrowdown_nor_night.svg"
          : "assets/images/detail/icon_arrowup_whites.svg",
      boxFit: BoxFit.fill,
      width: 12.w,
      height: 12.w,
    );
  }

  /// 构建比分标题（视频/动画直播模式）
  Widget _buildVsScore(MatchEntity match, MatchDetailController controller) {
    return AnimatedOpacity(
      opacity: controller.detailState.videoTopShow.value ? 1.0 : 0,
      duration: const Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTeamName(match.mhn, TextAlign.right, right: 16),
          _buildScoreText(match),
          _buildTeamName(match.man, TextAlign.left, left: 16),
        ],
      ),
    );
  }

  /// 构建队伍名称
  Widget _buildTeamName(String name, TextAlign align, {double? left, double? right}) {
    return SizedBox(
      width: 120.w,
      child: Text(
        name,
        maxLines: 1,
        textAlign: align,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 19.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ).marginOnly(left: left ?? 0, right: right ?? 0),
    );
  }

  /// 构建比分文本
  Widget _buildScoreText(MatchEntity match) {
    String scoreText = _getScoreText(match);

    return Text(
      scoreText,
      style: TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  /// 获取比分显示文本
  String _getScoreText(MatchEntity match) {
    if (eSportsScoring(match)) {
      return LocaleKeys.mmp_eports_scoring.tr;
    }

    if (match.ms != 110) {
      return getMsc(match.msc);
    }

    return "vs";
  }

  // ============= 工具方法 =============

  /// 判断文本是否需要跑马灯效果
  bool needMarquee({
    required String text,
    required double fontSize,
    required double maxWidth,
  }) {
    // 计算文本实际宽度
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout();

    // 如果文本宽度超过最大宽度，则使用跑马灯
    return textPainter.width > maxWidth;
  }
}