import 'package:flutter_screenutil/flutter_screenutil.dart'; // Importing FlutterScreenUtil for screen size scaling
import 'package:flutter_ty_app/app/extension/num_extension.dart'; // Importing NumExtension for number formatting
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart'; // Importing VR sport detail import head

// SearchNoData widgets class definition
class SearchNoData extends StatelessWidget {
  const SearchNoData({super.key});

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-2ff9023b-91e1-4537-b352-b54d6944eb13-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
      【【【 AUTO_DOCUMENT_TITLE 菜单搜索空页面 】】】
      【【【 AUTO_PARAGRAPH_TITLE 菜单搜索空页面入口 】】】
      【【【 AUTO_PARAGRAPH_CONTENT
            空数据样式
       】】】
   *
   */
  @override
  Widget build(BuildContext context) {
    // Building the UI for the SearchNoData widgets
    return Column(
      children: [
        // Container for the search no data message
        Container(
          height: 44.w, // Setting height using screenUtil
          alignment: Alignment.center,
          color: context.isDarkMode // Adjusting color based on dark mode
              ? Colors.white.withValues(alpha:0.04)
              : Colors.white,
          child: Text(
            LocaleKeys.league_search_no_data.tr, // Displaying the translation for "league_search_no_data"
            style: TextStyle(
                fontSize: 14.sp.scale, // Setting font size using screenUtil
                fontWeight: FontWeight.w400,
                color: context.isDarkMode // Adjusting text color based on dark mode
                    ? Colors.white.withValues(alpha:0.3)
                    : Colors.black54),
          ),
        ),
        // Expanded container for the background color
        Expanded(
          child: Container(
            height: double.infinity, // Setting height to infinity
            color: context.isDarkMode // Adjusting color based on dark mode
                ? Colors.transparent
                : const Color(0xFFF2F2F6), // Setting background color
          ),
        ),
      ],
    );
  }
}
