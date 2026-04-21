import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../services/api/analyze_detail_api.dart';
import '../../../services/models/res/analyze_news_entity.dart';
import '../../../utils/relative_date_format.dart';
import 'match_detail_controller.dart';
import '../states/match_market_news_state.dart';

typedef AnalyzeNewListener = Function(AnalyzeNewsEntity entity);
/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘面】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球盘面新闻控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘面控制器
    - 盘面初始化
    - 盘面足球切换
    】】】
 *
 */
class MatchMarketNewsController extends GetxController {
  final String tag;

  MatchMarketNewsController({required this.tag});

  final MatchMarketNewsState state = MatchMarketNewsState();


  /// 控制器初始化方法
  @override
  void onInit() {
    super.onInit();
  }

  /// 控制器准备就绪方法
  /// 初始化数据
  @override
  void onReady() {
    initData();
    super.onReady();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 详情列表】】】
      【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 页面初始化数据
      】】】
   *
   */
  /// 初始化数据
  /// 请求数据
  Future<void> initData() async {
    requestData();
  }

  /**
   * 请求数据
   * 从详情控制器获取赛事ID并请求文章数据
   */
  void requestData() async {
    MatchDetailController controller =
        Get.find<MatchDetailController>(tag: state.tag);

    state.mid = controller.detailState.mId;
    requestGetArticle(mid: state.mid ?? "");
  }

  /**
   * 请求收藏文章列表
   * [aricleId] 文章ID
   * 获取收藏的文章列表并格式化显示时间
   */
  void requestGetFavoriteArticle(String aricleId) {
    AnalyzeDetailApi.instance()
        .getFavoriteArticle(aricleId, state.mid)
        .then((value) {
      // 格式化每个文章的显示时间（时间戳转相对时间）
      value.data?.forEach((element) {
        element.showTime =
            "${RelativeDateFormat.format(DateTime.fromMicrosecondsSinceEpoch(int.parse(element.showTime ?? "0") * 1000))}";
      });
      state.analyzeFavoriteArticleList.value = value.data ?? [];

      update();
    });
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 赛事分析】】】
      【【【 AUTO_PARAGRAPH_TITLE 信息控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 请求文章数据
      】】】
   *
   */
  /**
   * 请求文章数据
   * [mid] 赛事ID
   * [type] 文章类型，默认为"1"
   * [analyzeNewListener] 文章数据回调监听器
   * type为"1"时更新state，否则通过回调返回数据
   */
  void requestGetArticle(
      {String mid = "",
      String type = "1",
      AnalyzeNewListener? analyzeNewListener}) {
    AnalyzeDetailApi.instance().getArticle(mid, type).then((value) {

      if (type == "1") {
        // 更新state中的文章数据
        state.analyzeNewsEntity.value = value.data ?? AnalyzeNewsEntity();
        // 请求收藏文章列表
        requestGetFavoriteArticle(value.data?.id ?? "");
        // 格式化显示时间（时间戳转相对时间）
        state.analyzeNewsEntity.value.showTime =
            "${RelativeDateFormat.format(DateTime.fromMicrosecondsSinceEpoch(((int.tryParse(value.data?.showTime ?? "0") ?? 0) * 1000).toInt()))}";
        // 判断是否有文章内容
        if (state.analyzeNewsEntity.value.articleContent?.isNotEmpty == true) {
          state.noData = false;
        } else {
          state.noData = true;
        }
      } else {
        // 通过回调返回数据
        if (analyzeNewListener != null) {
          value.data?.showTime =
              "${RelativeDateFormat.format(DateTime.fromMicrosecondsSinceEpoch(((int.tryParse(value.data?.showTime ?? "0") ?? 0) * 1000).toInt()))}";

          analyzeNewListener(value.data ?? AnalyzeNewsEntity());
        }
      }
      update();
    });
  }
}
