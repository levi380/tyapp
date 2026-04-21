import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../main.dart';
import '../../../login/login_head_import.dart';

/**
 * 球队Logo组件
 *
 * 功能说明：
 * 1. 展示球队Logo，支持主队和客队
 * 2. 支持单打和双打两种模式（双打时显示两个重叠的Logo）
 * 3. 双打模式支持偏移效果，主队向右偏移，客队向左偏移
 * 4. 支持自定义尺寸和偏移量
 * 5. 支持DJ详情页特殊处理（使用dj参数加载图片）
 *
 * 使用场景：
 * - 赛事详情页球队Logo展示
 * - 支持网球、羽毛球等双打项目的Logo展示
 */
class TeamLogo extends StatelessWidget {
  const TeamLogo({
    super.key,
    required this.match,
    required this.isDJDetail,
    required this.isHome,
    this.size,
    this.offset,
  });

  // ============= 常量定义 =============

  /// 默认Logo尺寸
  static const double _kDefaultSize = 40;

  /// iPad模式下的容器尺寸
  static const double _kIPadContainerSize = 84;

  /// iPad模式下的图片尺寸
  static const double _kIPadImageSize = 76.36;

  /// 普通模式下的容器内边距
  static const double _kContainerPadding = 4;

  /// 双打模式下的额外宽度
  static const double _kDoublesExtraWidth = 34;

  /// 默认偏移量
  static const double _kDefaultOffset = 30;

  /// 默认Logo资源路径（主队）
  static const String _kDefaultHomeLogo = 'assets/images/detail/default_team_home.svg';

  /// 默认Logo资源路径（客队）
  static const String _kDefaultAwayLogo = 'assets/images/detail/default_team_away.svg';

  /// 默认Logo资源路径（第一个位置）
  static const String _kDefaultFirstLogo = 'assets/images/home/home_team_logo.svg';

  /// 默认Logo资源路径（最后一个位置）
  static const String _kDefaultLastLogo = 'assets/images/detail/default_team_away.svg';

  // ============= 属性 =============

  /// 比赛数据
  final MatchEntity match;

  /// 是否为DJ详情页面（影响图片加载方式）
  final bool isDJDetail;

  /// 是否为主队（true:主队，false:客队）
  final bool isHome;

  /// Logo尺寸（正方形），为空则使用默认值
  final double? size;

  /// 双打时的Logo偏移量，为空则使用默认值
  final double? offset;

  // ============= 构建方法 =============

  @override
  Widget build(BuildContext context) {
    // 获取球队Logo列表
    final List logoList = isHome
        ? (match.mhlu as List)
        : (match.malu as List);

    // 获取Logo URL（第一个和最后一个）
    final String firstLogo = _getLogoUrl(logoList, true);
    final String lastLogo = _getLogoUrl(logoList, false);

    // 计算尺寸
    final double logoSize = size ?? _kDefaultSize.w;

    // 根据主客队返回对应的Widget
    return isHome
        ? _buildHomeTeamWidget(firstLogo, lastLogo, logoSize)
        : _buildAwayTeamWidget(firstLogo, lastLogo, logoSize);
  }

  // ============= Logo URL获取 =============

  /// 获取Logo URL
  /// [logoList] - Logo URL列表
  /// [isFirst] - 是否获取第一个Logo（true:第一个，false:最后一个）
  String _getLogoUrl(List logoList, bool isFirst) {
    final String defaultLogo = isFirst
        ? _kDefaultFirstLogo
        : _kDefaultLastLogo;

    // 列表为空，返回默认Logo
    if (ObjectUtil.isEmpty(logoList)) return defaultLogo;

    // 获取对应位置的Logo URL
    final String? logoUrl = isFirst
        ? logoList.safeFirst
        : logoList.safeLast;

    // 返回有效URL或默认Logo
    return ObjectUtil.isNotEmpty(logoUrl) ? logoUrl! : defaultLogo;
  }

  // ============= 主队/客队构建 =============

  /// 构建主队Widget
  Widget _buildHomeTeamWidget(
      String homeLogo,
      String homeLogo2,
      double logoSize,
      ) {
    // 判断是否为双打（Logo数量大于1）
    final bool isDoubles = _isDoubles(true);
    final double logoOffset = offset ?? _kDefaultOffset.w;

    return isDoubles
        ? _buildDoublesWidget(
      isHome: true,
      logo1: homeLogo,
      logo2: homeLogo2,
      logoSize: logoSize,
      offset: logoOffset,
    )
        : _buildSinglesWidget(
      logo: homeLogo,
      logoSize: logoSize,
      isHome: true,
    );
  }

  /// 构建客队Widget
  Widget _buildAwayTeamWidget(
      String awayLogo,
      String awayLogo2,
      double logoSize,
      ) {
    // 判断是否为双打（Logo数量大于1）
    final bool isDoubles = _isDoubles(false);
    final double logoOffset = offset ?? _kDefaultOffset.w;

    return isDoubles
        ? _buildDoublesWidget(
      isHome: false,
      logo1: awayLogo,
      logo2: awayLogo2,
      logoSize: logoSize,
      offset: logoOffset,
    )
        : _buildSinglesWidget(
      logo: awayLogo,
      logoSize: logoSize,
      isHome: false,
    );
  }

  /// 判断是否为双打模式
  bool _isDoubles(bool isHome) {
    final List logoList = isHome
        ? (match.mhlu as List)
        : (match.malu as List);
    return logoList.length > 1;
  }

  // ============= 尺寸计算 =============

  /// 获取容器尺寸
  double _getContainerSize(double logoSize) {
    return isIPad
        ? _kIPadContainerSize.w
        : logoSize + _kContainerPadding.w;
  }

  /// 获取图片尺寸
  double _getImageSize(double logoSize) {
    return isIPad
        ? _kIPadImageSize.w
        : logoSize;
  }

  /// 获取双打模式总宽度
  double _getDoublesTotalWidth(double logoSize) {
    return isIPad
        ? _kIPadContainerSize.w + _kDoublesExtraWidth.w
        : logoSize + _kDoublesExtraWidth.w;
  }

  // ============= 双打模式构建 =============

  /// 构建双打Widget（两个重叠的Logo）
  Widget _buildDoublesWidget({
    required bool isHome,
    required String logo1,
    required String logo2,
    required double logoSize,
    required double offset,
  }) {
    final double containerSize = _getContainerSize(logoSize);
    final double imageSize = _getImageSize(logoSize);
    final double totalWidth = _getDoublesTotalWidth(logoSize);

    return SizedBox(
      width: totalWidth,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // 背景Logo（偏移位置）
          _buildBackgroundLogo(
            isHome: isHome,
            logo: logo2,
            containerSize: containerSize,
            imageSize: imageSize,
            offset: offset,
          ),
          // 前景Logo（对齐边缘）
          _buildForegroundLogo(
            isHome: isHome,
            logo: logo1,
            containerSize: containerSize,
            imageSize: imageSize,
          ),
        ],
      ),
    );
  }

  /// 构建背景Logo（带偏移）
  Widget _buildBackgroundLogo({
    required bool isHome,
    required String logo,
    required double containerSize,
    required double imageSize,
    required double offset,
  }) {
    return Positioned(
      right: isHome ? offset : null,
      left: isHome ? null : offset,
      child: _buildLogoContainer(
        logo: logo,
        containerSize: containerSize,
        imageSize: imageSize,
        isHome: isHome,
      ),
    );
  }

  /// 构建前景Logo（对齐边缘）
  Widget _buildForegroundLogo({
    required bool isHome,
    required String logo,
    required double containerSize,
    required double imageSize,
  }) {
    return Align(
      alignment: isHome ? Alignment.centerRight : Alignment.centerLeft,
      child: _buildLogoContainer(
        logo: logo,
        containerSize: containerSize,
        imageSize: imageSize,
        isHome: isHome,
      ),
    );
  }

  // ============= 单打模式构建 =============

  /// 构建单打Widget（单个Logo）
  Widget _buildSinglesWidget({
    required String logo,
    required double logoSize,
    required bool isHome,
  }) {
    final double containerSize = _getContainerSize(logoSize);
    final double imageSize = _getImageSize(logoSize);

    return Container(
      width: containerSize,
      height: containerSize,
      alignment: Alignment.center,
      child: _buildLogoImage(
        logo: logo,
        width: imageSize,
        height: imageSize,
        isHome: isHome,
      ),
    );
  }

  // ============= Logo容器和图片构建 =============

  /// 构建Logo容器（包含边框）
  Widget _buildLogoContainer({
    required String logo,
    required double containerSize,
    required double imageSize,
    required bool isHome,
  }) {
    return Container(
      width: containerSize,
      height: containerSize,
      alignment: Alignment.center,
      child: _buildLogoImage(
        logo: logo,
        width: imageSize,
        height: imageSize,
        isHome: isHome,
      ),
    );
  }

  /// 构建Logo图片
  Widget _buildLogoImage({
    required String logo,
    required double width,
    required double height,
    required bool isHome,
  }) {
    final String defaultLogo = isHome
        ? _kDefaultHomeLogo
        : _kDefaultAwayLogo;

    return ImageView(
      logo,
      width: width,
      height: height,
      // DJ详情页面使用dj参数，否则使用cdn参数
      dj: isDJDetail,
      cdn: !isDJDetail,
      errorWidget: _buildErrorImage(
        defaultLogo: defaultLogo,
        width: width,
        height: height,
      ),
    );
  }

  /// 构建错误占位图
  Widget _buildErrorImage({
    required String defaultLogo,
    required double width,
    required double height,
  }) {
    return ImageView(
      defaultLogo,
      width: width,
      height: height,
      // 确保错误widget也有正确的cdn设置
      cdn: !isDJDetail,
    );
  }
}