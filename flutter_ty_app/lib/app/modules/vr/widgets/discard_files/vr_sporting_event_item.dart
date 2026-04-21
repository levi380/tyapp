
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/// VR 体育赛事列表单项组件
/// 用于显示单个赛事的图标、名称及未读消息提示
class VrSportingEventItem extends StatelessWidget {
  /// 默认状态下的图片资源名称
  final String imgName;

  /// 赛事名称
  final String eventName;

  /// 未读消息数量，若大于 0 则显示红点或数字
  final int unreadCount;

  /// 是否处于选中状态
  final bool isSelected;

  /// 点击回调函数
  final VoidCallback? onTap;

  /// 构造函数
  /// [imgName] 图片资源路径
  /// [eventName] 赛事显示名称
  /// [unreadCount] 未读数，默认为 0
  /// [isSelected] 是否选中，默认为 false
  /// [onTap] 点击事件回调
  const VrSportingEventItem({
    Key? key,
    required this.imgName,
    required this.eventName,
    this.unreadCount = 0,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        constraints: BoxConstraints(minWidth: 52.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 2.w),
            _buildIconStack(),
            SizedBox(height: 4.w),
            _buildEventName(),
          ],
        ),
      ),
    );
  }

  /// 构建图标及未读数标记层
  Widget _buildIconStack() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildMainIcon(),
        if (unreadCount > 0) _buildUnreadBadge(),
      ],
    );
  }

  /// 构建主图标
  Widget _buildMainIcon() {
    // 判断是否为本地资源还是网络图片，这里假设主要是本地资源
    if (imgName.startsWith('http')) {
      return ImageView(
        imgName,
        width: 24.w,
        height: 24.w,
      );
    }
    return ImageView(
      imgName,
      width: 24.w,
      height: 24.w,
    );
  }

  /// 构建未读数角标
  Widget _buildUnreadBadge() {
    return Positioned(
      right: -7.w,
      top: -2.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          color: Colors.transparent, // 这里实际背景可能由上层决定，或者文字自带颜色
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Text(
          unreadCount > 99 ? '99+' : '$unreadCount',
          style: TextStyle(
            color: !isSelected ? '#AFB3C8'.hexColor : '#303442'.hexColor,
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// 构建赛事名称文本
  Widget _buildEventName() {
    return Text(
      eventName,
      style: TextStyle(
        color: !isSelected ? '#AFB3C8'.hexColor : '#303442'.hexColor,
        fontSize: 10.sp,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        height: 1.2,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }
}
