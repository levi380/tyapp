import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/network/request_interceptor.dart';

List generateKeyEvents() => [
      {
        "id": "0",
        "i18n": LocaleKeys.highlights_type_card_yellow.tr,
        "is_key": true,
        "eventCode": "yellow_card"
      },
      {
        "id": "0",
        "i18n": LocaleKeys.mmp_2_302.tr,
        "is_key": true,
        "eventCode": "half_time"
      },
      {
        "id": "1",
        "i18n": LocaleKeys.highlights_type_card_red.tr,
        "is_key": true,
        "eventCode": "red_card"
      },
      {
        "id": "51",
        "is_key": true,
        "i18n": LocaleKeys.match_result_double_yellow_card.tr,
        "eventCode": "yellow_red_card"
      },

      {
        "id": "2",
        "i18n": LocaleKeys.highlights_type_corner.tr,
        "is_key": true,
        "eventCode": "corner"
      },
      {
        "id": "3",
        "i18n": LocaleKeys.analysis_substitution.tr,
        "eventCode": "substitution"
      },
      {
        "id": "4",
        "i18n": LocaleKeys.match_result_goal.tr,
        "is_key": true,
        "eventCode": "goal"
      },
      // eventCode 还是进球 需要判断赛事阶段
      {
        "id": "5",
        "i18n": LocaleKeys.ouzhou_detail_penalty.tr,
        "is_key": true,
        "eventCode": "goal50",
      },
      {
        "id": "6",
        "i18n": LocaleKeys.analysis_penalty_missed.tr,
        "is_key": true,
        "eventCode": "penalty_missed",
      },
      {
        "id": "7",
        "i18n": LocaleKeys.analysis_single_knife.tr,
        "eventCode": "breakaway"
      },
      {
        "id": "8",
        "i18n": LocaleKeys.football_playing_way_penalty_shootout.tr,
        "eventCode": "penalty_shootout_event"
      },
      {
        "id": "9",
        "i18n": LocaleKeys.match_result_attack.tr,
        "eventCode": "attack"
      },
      {
        "id": "10",
        "i18n": LocaleKeys.match_result_dangerous_offense.tr,
        "eventCode": "dangerous_attack"
      },
      {
        "id": "11",
        "i18n": LocaleKeys.ouzhou_detail_shots_on_goal.tr,
        "eventCode": "goal_kick"
      },
      {
        "id": "12",
        "i18n": ["zh"].contains(getLang())
            ? LocaleKeys.analysis_throw_in.tr.replaceAll("掷", "")
            : LocaleKeys.analysis_throw_in.tr,
        "eventCode": "throw_in"
      },
      {
        "id": "13",
        "i18n": LocaleKeys.analysis_offside.tr,
        "eventCode": "offside"
      },
      {
        "id": "14",
        "i18n": LocaleKeys.analysis_shot_on.tr,
        "eventCode": "shot_on_target"
      },
      {
        "id": "15",
        "i18n": LocaleKeys.match_result_shot_off.tr,
        "eventCode": "shot_off_target"
      },
      {
        "id": "16",
        "i18n": LocaleKeys.analysis_injury.tr,
        "eventCode": "injury"
      },
      {
        "id": "17",
        "i18n": LocaleKeys.analysis_goalkeeper_save.tr,
        "eventCode": "goal_keeper_save"
      },
      {
        "id": "19",
        "i18n": LocaleKeys.analysis_goal_canceled.tr,
        "eventCode": "canceled_goal"
      },
      {
        "id": "20",
        "i18n": LocaleKeys.analysis_potential_penalty.tr,
        "eventCode": "possible_penalty"
      },
      {
        "id": "21",
        "i18n": LocaleKeys.analysis_start_penalty.tr,
        "eventCode": "take_penalty"
      },
      {
        "id": "22",
        "i18n": LocaleKeys.analysis_penalty_canceled.tr,
        "eventCode": "canceled_penalty"
      },
      {
        "id": "23",
        "i18n": LocaleKeys.analysis_missed_penalty.tr,
        "eventCode": "penalty_missed"
      },
      {
        "id": "24",
        "i18n": LocaleKeys.analysis_potential_corner.tr,
        "eventCode": "possible_corner"
      },
      {
        "id": "25",
        "i18n": LocaleKeys.analysis_corner_canceled.tr,
        "eventCode": "canceled_corner"
      },
      {
        "id": "26",
        "i18n": LocaleKeys.analysis_free_kick.tr,
        "eventCode": "free_kick"
      },
      {
        "id": "27",
        "i18n": LocaleKeys.analysis_potential_free_kick.tr,
        "eventCode": "possible_free_kick"
      },
      {
        "id": "28",
        "i18n": LocaleKeys.analysis_earned_penalty.tr,
        "eventCode": "penalty_awarded"
      },
      {
        "id": "29",
        "i18n": LocaleKeys.analysis_retaken_penalty.tr,
        "eventCode": "retake_pen"
      },
      {
        "id": "30",
        "i18n": LocaleKeys.analysis_potential_yellow_card.tr,
        "eventCode": "possible_yellow_card"
      },
      {
        "id": "31",
        "i18n": LocaleKeys.analysis_yellow_card_canceled.tr,
        "eventCode": "canceled_yellow_card"
      },
      {
        "id": "32",
        "i18n": LocaleKeys.analysis_potential_red_card.tr,
        "eventCode": "possible_red_card"
      },
      {
        "id": "33",
        "i18n": LocaleKeys.analysis_red_card_canceled.tr,
        "eventCode": "canceled_red_card"
      },
      {
        "id": "34",
        "i18n": LocaleKeys.analysis_kick_off_team.tr,
        "eventCode": "kick_off_team"
      },
      {
        "id": "35",
        "i18n": LocaleKeys.analysis_penalty_shootout_incoming.tr,
        "eventCode": "penalty_about_to_be_taken"
      },
      {
        "id": "36",
        "i18n": LocaleKeys.analysis_start_penalty_shootout.tr,
        "eventCode": "start_pen_team"
      },
      {
        "id": "37",
        "i18n": LocaleKeys.analysis_next_penalty_taker.tr,
        "eventCode": "next_penalty_scorer"
      },
      {
        "id": "38",
        "i18n": LocaleKeys.analysis_end_of_penalty_shootout.tr,
        "eventCode": "stop_pen"
      },
      {
        "id": "39",
        "i18n": LocaleKeys.analysis_connection_interrupted.tr,
        "eventCode": "lost_connection"
      },
      {
        "id": "40",
        "i18n": LocaleKeys.analysis_end_of_pause.tr,
        "eventCode": "suspension_over"
      },
      {
        "id": "41",
        "i18n": LocaleKeys.analysis_temporary_interruption.tr,
        "eventCode": "temporary_interruption"
      },
      {
        "id": "42",
        "i18n": LocaleKeys.analysis_extra_time.tr,
        "eventCode": "injury_time"
      },
      {
        "id": "43",
        "i18n": LocaleKeys.analysis_var.tr,
        "eventCode": "video_assistant_referee"
      },
      {
        "id": "44",
        "i18n": LocaleKeys.analysis_end_of_var.tr,
        "eventCode": "video_assistant_referee_over"
      },
      {
        "id": "45",
        "i18n": LocaleKeys.analysis_var_canceled.tr,
        "eventCode": "canceled_video_assistant_referee"
      },
      {
        "id": "46",
        "i18n": LocaleKeys.analysis_potential_var.tr,
        "eventCode": "possible_video_assistant_referee"
      },
      {
        "id": "47",
        "i18n": LocaleKeys.analysis_drink_break.tr,
        "eventCode": "water_break"
      },
      {
        "id": "48",
        "i18n": LocaleKeys.analysis_match_paused.tr,
        "eventCode": "suspension"
      },

      // {
      //   "id": "49",
      //   "i18n": LocaleKeys.mmp_1_31.tr,
      //   "eventCode": "match_status"
      // },
      // 乌龙球 extraInfo == "2"
      {
        "id": "50",
        "i18n": LocaleKeys.match_result_own_goals.tr,
        "is_key": true,
        "eventCode": "goal2",
      },

      // {
      //   "id": "51",
      //   "i18n": "赛事阶段",
      //   "is_key": true,
      //   "eventCode": "match_status",
      // },
      {
        "id": "50",
        "i18n": "开始计时",
        "is_key": true,
        "eventCode": "time_start",
      },

      {
        "id": "50",
        "i18n": "比赛暂停",
        "is_key": true,
        "eventCode": "timeout",
      },

      {
        "id": "50",
        "i18n": "暂停结束",
        "is_key": true,
        "eventCode": "timeout_over",
      },

      {
        "id": "50",
        "i18n": "手动删除事件",
        "is_key": true,
        "eventCode": "delete_event",
      },

      {
        "id": "50",
        "i18n": "跨阶段修改比分",
        "is_key": true,
        "eventCode": "period_score_change",
      },

      {
        "id": "50",
        "i18n": "修正比分",
        "is_key": true,
        "eventCode": "score_correction",
      },

      {
        "id": "50",
        "i18n": "赢得跳球",
        "is_key": true,
        "eventCode": "won_jump_ball",
      },
      {
        "id": "50",
        "i18n": "控球权",
        "is_key": true,
        "eventCode": "possession",
      },

      {
        "id": "50",
        "i18n": "比分变更",
        "is_key": true,
        "eventCode": "score_change",
      },
      {
        "id": "50",
        "i18n": "罚球取消",
        "is_key": true,
        "eventCode": "play_canceled",
      },

      {
        "id": "50",
        "i18n": "篮板",
        "is_key": true,
        "eventCode": "rebound",
      },

      {
        "id": "50",
        "i18n": "抢断",
        "is_key": true,
        "eventCode": "steal",
      },

      {
        "id": "50",
        "i18n": "失误",
        "is_key": true,
        "eventCode": "turnover",
      },

      {
        "id": "50",
        "i18n": "盖帽",
        "is_key": true,
        "eventCode": "block",
      },

      {
        "id": "50",
        "i18n": "未命中",
        "is_key": true,
        "eventCode": "score_miss",
      },

      {
        "id": "50",
        "i18n": "犯规",
        "is_key": true,
        "eventCode": "foul",
      },

      {
        "id": "50",
        "i18n": "防守篮板",
        "is_key": true,
        "eventCode": "rebound_defense",
      },
      {
        "id": "50",
        "i18n": "进攻篮板",
        "is_key": true,
        "eventCode": "rebound_attack",
      },

      {
        "id": "50",
        "i18n": "删除比分",
        "is_key": true,
        "eventCode": "score_delete",
      },

      {
        "id": "50",
        "i18n": "未命中:二分球未命中",
        "is_key": true,
        "eventCode": "2p_miss",
      },

      {
        "id": "50",
        "i18n": "未命中:三分球未命中",
        "is_key": true,
        "eventCode": "3p_miss",
      },
      {
        "id": "50",
        "i18n": "罚球",
        "is_key": true,
        "eventCode": "free_throw",
      },
      {
        "id": "50",
        "i18n": "罚球+1",
        "is_key": true,
        "eventCode": "free_throw_add",
      },
      {
        "id": "50",
        "i18n": "罚球-1",
        "is_key": true,
        "eventCode": "free_throw_sub",
      },
      {
        "id": "50",
        "i18n": "抢断",
        "is_key": true,
        "eventCode": "manual_time_adjust",
      },
    ];
