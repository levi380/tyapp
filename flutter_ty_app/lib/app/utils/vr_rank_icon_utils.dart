class VrRankIconUtils {
  /// VR 排名 icon
  ///
  /// 资源路径示例：
  /// - 赛狗       assets/images/icon/vr_dog_rank1_icon.png
  /// - 赛马       assets/images/icon/vr_horse_rank1_icon.png
  /// - 摩托车     assets/images/icon/vr_autocycle1_icon.png
  /// - 泥地摩托车 assets/images/icon/vr_autocycle_mud1_icon.png
  ///
  /// - 1002：VR 赛狗
  /// - 1011：VR 赛马
  /// - 1010：VR 摩托车
  /// - 1009：VR 泥地摩托车

  /// icon 资源基础路径
  static const String _iconBasePath = 'assets/images/icon/';

  /// sportId -> icon 前缀映射
  static const Map<int, String> _iconPrefixMap = {
    1002: 'vr_dog_rank',        // VR 赛狗
    1011: 'vr_horse_rank',     // VR 赛马
    1010: 'vr_autocycle',      // VR 摩托车
    1009: 'vr_autocycle_mud',  // VR 泥地摩托车
  };

  /// 排名范围
  static const Map<int, Set<String>> _rankRangeMap = {
    1009: {'1', '2', '3', '4'},                       // 泥地摩托车：1-4
    1002: {'1', '2', '3', '4', '5', '6'},             // 赛狗：1-6
    1011: {'1', '2', '3', '4', '5', '6'},             // 赛马：1-6
    1010: {'1', '2', '3', '4', '5', '6'},             // 摩托车：1-6
  };

  /// 获取 VR 排名 icon
  static String getRankIcon(
      int sportId,
      String playOptions, {
        bool acceptNoValue = false,
      }) {
    /// 获取当前 sportId 对应的排名范围
    final rankRange = _rankRangeMap[sportId];

    if (rankRange == null || !rankRange.contains(playOptions)) {

      if (acceptNoValue) {
        return '';
      }
      /// 默认兜底 icon
      return '${_iconBasePath}vr_rank_icon.png';
    }

    /// 获取 icon 前缀
    final prefix = _iconPrefixMap[sportId];

    if (prefix == null) {
      return acceptNoValue
          ? ''
          : '${_iconBasePath}vr_rank_icon.png';
    }

    /// 拼接最终 icon 路径
    return '$_iconBasePath$prefix$playOptions\_icon.png';
  }
}

