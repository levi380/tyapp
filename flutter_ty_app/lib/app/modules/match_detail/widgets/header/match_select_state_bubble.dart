// import 'package:common_utils/common_utils.dart';
// import 'package:flutter_ty_app/app/extension/num_extension.dart';
// import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';



import '../../../../../generated/locales.g.dart';
import '../../../../../main.dart';
import '../../../../services/models/res/match_entity.dart';
import '../../../login/login_head_import.dart';
import '../../constants/theme_constant.dart';

// 球队logo通用组件 包含双打
class MatchSelectStateBubble extends StatelessWidget {
  const MatchSelectStateBubble({
    super.key,
    required this.match,
    required this.isHeader,
  });

  final MatchEntity match;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    String imageSource = '';
    double bubbleHeight = 24.w;
    double minBubbleWidth = isHeader ? 76.w : 64.w;   //  最小宽度
    double iconSize = 0;
    Color backgroundColor = ThemeConstant.stateBubbleDefaultBackgroundColor;
    Color fontColor = ThemeConstant.stateBubbleDefaultFontColor;
    String contentText = '';

    final pinkBackgroundColor = Get.isDarkMode?
    Color.fromRGBO(245, 63, 63, 0.2) :
    ThemeConstant.stateBubblePinkBackgroundColorLight;

    final grayBackgroundColor = Get.isDarkMode?
    Color.fromRGBO(255, 255, 255, 0.04) :
    ThemeConstant.stateBubbleGrayBackgroundColorLight;

    final blueBackgroundColor = Get.isDarkMode?
    Color.fromRGBO(23, 156, 255, 0.4) :
    ThemeConstant.stateBubbleBlueBackgroundColorLight;

    final pinkFontColor = ThemeConstant.stateBubblePinkFontColor;
    final grayFontColor = ThemeConstant.stateBubbleGrayFontColor;
    final blueFontColor = ThemeConstant.stateBubbleBlueFontColor;

    final watchingIconUrl = 'assets/images/icon/watching_icon.png';
    final openBlueIconUrl = 'assets/images/icon/oepned_icon.png';
    final notYetIconUrl = 'assets/images/icon/notyet_icon.png';

    if (isHeader) {
      iconSize = 20.w;
      if (match.ms == 1) {
        imageSource = watchingIconUrl;
        backgroundColor = pinkBackgroundColor;
        fontColor = pinkFontColor;
        contentText = LocaleKeys.list_match_watching.tr;
      } else {
        imageSource = notYetIconUrl;
        backgroundColor = grayBackgroundColor;
        fontColor = grayFontColor;
        iconSize = 15.w;
        contentText = LocaleKeys.list_match_current_match.tr;
      }
    } else {
      iconSize = 14.w;
      if (match.ms == 1) {
        imageSource = openBlueIconUrl;
        backgroundColor = blueBackgroundColor;
        fontColor = blueFontColor;
        contentText = LocaleKeys.list_match_start.tr;
      } else {
        imageSource = notYetIconUrl;
        backgroundColor = grayBackgroundColor;
        fontColor = grayFontColor;
        contentText = LocaleKeys.list_match_no_start.tr;
      }
    }

    return IntrinsicWidth(
      child: Container(
        constraints: BoxConstraints(
          minWidth: minBubbleWidth,   //  最小宽度
          maxWidth: 100.w,            //  给一个最大宽度，避免过长（可调）
        ),
        height: bubbleHeight,
        padding: EdgeInsets.symmetric(horizontal: 6.w), //  内容内边距
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.5 * bubbleHeight),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,  //  根据内容自动变宽
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageView(
              imageSource,
              width: isIPad ? iconSize * 2 : iconSize,
              height: isIPad ? iconSize * 2 : iconSize,
              cdn: true,
            ),
            SizedBox(width: 3.w),
            Flexible(
              child: Text(
                contentText,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  color: fontColor,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
