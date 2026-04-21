import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/statistics_front_fight_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../../modules/login/login_head_import.dart';
import '../../models/analysis/analysis_model.dart';
import '../../states/match_statistic_state.dart';
import '../match_tools_methods.dart';

/**
 * 统计数据转换服务类
 * 负责将正面交手数据转换为UI显示数据
 */
class MatchStatisticDataConverterService {
  /**
   * 将正面交手数据转换为UI显示数据
   * [state] 状态管理对象
   * [page1frontFightPBBeanEntity] 正面交手数据实体
   * [tag] 比赛ID
   * 转换包括：大于1球、大于2球、大于3球、总进球、主队不败、客队不败的百分比和场次
   * 以及胜平负的百分比和场次
   */
  static void converFrontFightPBBeanEntityToUI(
    MatchStatisticMatchHistoryState state,
    StatisticsFrontFightEntity? page1frontFightPBBeanEntity,
    String tag,
  ) {
    // 大于1球的百分比和场次
    GridColorBean gridColorBean = state.gridColorBeans[0];
    gridColorBean.name1 = page1frontFightPBBeanEntity?.countTotal == 0
        ? "0"
        : "${((page1frontFightPBBeanEntity?.moreThanOne ?? 0) / ((page1frontFightPBBeanEntity?.countTotal ?? 1).toDouble()) * 100).toInt()}";

    gridColorBean.name3 =
        "${page1frontFightPBBeanEntity?.moreThanOne ?? 0}/${page1frontFightPBBeanEntity?.countTotal ?? 0}${LocaleKeys.ouzhou_match_matches.tr}";
    // 大于2球的百分比和场次
    gridColorBean = state.gridColorBeans[1];
    gridColorBean.name1 = page1frontFightPBBeanEntity?.countTotal == 0
        ? "0"
        : "${((page1frontFightPBBeanEntity?.moreThanTwo ?? 0) / ((page1frontFightPBBeanEntity?.countTotal ?? 1).toDouble()) * 100).toInt()}";
    gridColorBean.name3 =
        "${page1frontFightPBBeanEntity?.moreThanTwo ?? 0}/${page1frontFightPBBeanEntity?.countTotal ?? 0}${LocaleKeys.ouzhou_match_matches.tr}";

    // 大于3球的百分比和场次
    gridColorBean = state.gridColorBeans[2];
    gridColorBean.name1 = page1frontFightPBBeanEntity?.countTotal == 0
        ? "0"
        : "${((page1frontFightPBBeanEntity?.moreThanThree ?? 0) / ((page1frontFightPBBeanEntity?.countTotal ?? 1).toDouble()) * 100).toInt()}";
    gridColorBean.name3 =
        "${page1frontFightPBBeanEntity?.moreThanThree ?? 0}/${page1frontFightPBBeanEntity?.countTotal ?? 0}${LocaleKeys.ouzhou_match_matches.tr}";

    // 总进球的百分比和场次
    gridColorBean = state.gridColorBeans[3];
    gridColorBean.name1 = page1frontFightPBBeanEntity?.countTotal == 0
        ? "0"
        : "${((page1frontFightPBBeanEntity?.allScores ?? 0) / ((page1frontFightPBBeanEntity?.countTotal ?? 1).toDouble()) * 100).toInt()}";
    gridColorBean.name3 =
        "${page1frontFightPBBeanEntity?.allScores ?? 0}/${page1frontFightPBBeanEntity?.countTotal ?? 0}${LocaleKeys.ouzhou_match_matches.tr}";

    MatchEntity matchEntity =
        DataStoreController.to.getMatchById(tag) ?? MatchEntity();

    // 主队不败的百分比和队伍名称
    gridColorBean = state.gridColorBeans[4];
    gridColorBean.name1 = page1frontFightPBBeanEntity?.countTotal == 0
        ? "0"
        : "${((page1frontFightPBBeanEntity?.homeNotLost ?? 0) / ((page1frontFightPBBeanEntity?.countTotal ?? 1).toDouble()) * 100).toInt()}";
    gridColorBean.name3 = getTeamName(type: 1, match: matchEntity);

    // 客队不败的百分比和队伍名称
    gridColorBean = state.gridColorBeans[5];
    gridColorBean.name1 = page1frontFightPBBeanEntity?.countTotal == 0
        ? "0"
        : "${((page1frontFightPBBeanEntity?.awayNotLost ?? 0) / ((page1frontFightPBBeanEntity?.countTotal ?? 1).toDouble()) * 100).toInt()}";
    gridColorBean.name3 = getTeamName(type: 2, match: matchEntity);

    // 主胜的百分比和显示文本
    state.lineColorBeans[0].expand =
        ((page1frontFightPBBeanEntity?.countTotal == 0)
                ? 1
                : ((page1frontFightPBBeanEntity?.homeWin ?? 0) /
                        ((page1frontFightPBBeanEntity?.countTotal ?? 1)
                            .toDouble())) *
                    100)
            .toInt();
    state.lineColorBeans[0].number =
        "${LocaleKeys.bet_home_win.tr}${((page1frontFightPBBeanEntity?.countTotal == 0) ? 0 : ((page1frontFightPBBeanEntity?.homeWin ?? 0) / ((page1frontFightPBBeanEntity?.countTotal ?? 1).toDouble())) * 100).toInt()}";

    // 平局的百分比和显示文本
    state.lineColorBeans[1].expand =
        ((page1frontFightPBBeanEntity?.countTotal == 0)
                ? 1
                : ((page1frontFightPBBeanEntity?.dogfallTotal ?? 0) /
                        ((page1frontFightPBBeanEntity?.countTotal ?? 1)
                            .toDouble())) *
                    100)
            .toInt();
    state.lineColorBeans[1].number =
        "${LocaleKeys.analysis_flat.tr}${((page1frontFightPBBeanEntity?.countTotal == 0) ? 0 : ((page1frontFightPBBeanEntity?.dogfallTotal ?? 0) / ((page1frontFightPBBeanEntity?.countTotal ?? 1).toDouble())) * 100).toInt()}";

    // 客胜的百分比和显示文本
    state.lineColorBeans[2].expand =
        ((page1frontFightPBBeanEntity?.countTotal == 0)
                ? 1
                : ((page1frontFightPBBeanEntity?.awayWin ?? 0) /
                        ((page1frontFightPBBeanEntity?.countTotal ?? 1)
                            .toDouble())) *
                    100)
            .toInt();
    state.lineColorBeans[2].number =
        "${LocaleKeys.bet_away_win.tr}${((page1frontFightPBBeanEntity?.countTotal == 0) ? 0 : ((page1frontFightPBBeanEntity?.awayWin ?? 0) / ((page1frontFightPBBeanEntity?.countTotal ?? 1).toDouble())) * 100).toInt()}";

    // 如果所有百分比都为0，则设置为1，避免显示异常
    bool zeroNumber = true;
    for (LineColorBean bean in state.lineColorBeans) {
      if (bean.expand > 0) {
        zeroNumber = false;
        break;
      }
    }
    if (zeroNumber) {
      for (LineColorBean bean in state.lineColorBeans) {
        bean.expand = 1;
      }
    }
  }
}

