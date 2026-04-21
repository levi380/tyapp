import 'package:flutter_ty_app/app/services/models/res/analyze_news_entity.dart';

import '../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘面】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球盘面新闻State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘面State控制器
    - 盘面State变量初始化
    - 盘面足球切换变量
    】】】
 *
 */
class MatchMarketNewsState {
  Rx<AnalyzeNewsEntity> analyzeNewsEntity=AnalyzeNewsEntity().obs;
  RxList<AnalyzeNewsEntity>  analyzeFavoriteArticleList=<AnalyzeNewsEntity>[].obs;
  String? mid;
  bool noData = true;
  String? tempTag;
  String? get tag {
    if (Get.arguments is Map) {
      Map<String, dynamic>? arguments = Get.arguments;
      String? mId = arguments?['mid'];
      if (mId != null) {
        tempTag = mId;
        return mId;
      }
    }
    return tempTag;
  }
  // ========== UI常量 ==========
  /// 无数据提示顶部间距
  static const double noDataTopSpacing = 30.0;
  
  /// 容器水平内边距
  static const double pageHorizontalPadding = 5.0;
  
  /// 容器垂直内边距
  static const double pageVerticalPadding = 5.0;
  
  /// 内容容器垂直内边距
  static const double contentVerticalPadding = 20.0;
  
  /// 内容容器水平内边距
  static const double contentHorizontalPadding = 12.0;
  
  /// 标题字体大小（iPad）
  static const double titleFontSizeIPad = 18.0;
  
  /// 标题字体大小（普通）
  static const double titleFontSize = 14.0;
  
  /// 标题下方间距
  static const double titleBottomSpacing = 6.0;
  
  /// 副标题下方间距
  static const double subtitleBottomSpacing = 8.0;
  
  /// HTML文本行高
  static const double htmlTextLineHeight = 2.0;
  
  /// HTML文本字间距
  static const double htmlTextWordSpacing = 4.0;
  
  /// 消息体高度
  static const double messageBodyHeight = 18.0;
  
  /// 图标容器宽度
  static const double iconContainerWidth = 14.0;
  
  /// 图标容器高度
  static const double iconContainerHeight = 14.0;
  
  /// 图标容器圆角半径
  static const double iconContainerBorderRadius = 12.0;
  
  /// 图标大小
  static const double iconSize = 12.0;
  
  /// 图标间距
  static const double iconSpacing = 4.0;
  
  /// 消息体字体大小（iPad）
  static const double messageBodyFontSizeIPad = 16.0;
  
  /// 消息体字体大小（普通）
  static const double messageBodyFontSize = 12.0;

  MatchMarketNewsState() {
  }


}
