import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/corner_play_temp_penalty.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/secodary/secodary_build_body_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/utils/bus/event_bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../controllers/secondary_expand_controller.dart';
import '../../../../models/play_info.dart';
import '../../../../models/secondary_state_model.dart';
import '../corner_play_temp_overtime.dart';
import 'secondary_game_play_header.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 常规赛事 】】】
    【【【 AUTO_PARAGRAPH_TITLE 加时赛和常规赛UI  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 子玩法 加时赛和常规赛区分
    ```
    ///当只有常规赛，或者只有加时赛的时候处理（有时候数据只有常规赛，或者只有加时赛，特殊处理）
    if (!isShowRegularAndOvertimeTogether(match)) {
    ///只有常规赛
    if (match.cosCorner ||
    match.cos15Minutes ||
    match.cosBold ||
    match.compose ||
    match.cosPunish) {
    isOvertimeMatch = true;
    } else {
    ///只有加时赛
    if ((match.cosTBold ||
    match.cosTCorner ||
    match.cosTPunish ||
    match.cosOvertime ||
    match.cosPenalty)) {
    isOvertimeMatch = false;
    }
    }
    }
    ```
    - 当玩法数量超过一屏 显示更多+
    ```
    ///当有加时赛开关展示的时候，子玩法的数量超过4个，就展示跟多玩法.
    if (isShowRegularAndOvertimeTogether(match)) {
    moreleng = 4;
    } else {
    moreleng = ScreenUtil().screenWidth ~/ (50) > 5
    ? 5
    : ScreenUtil().screenWidth ~/ (50);
    }
    ```
    ## 主要属性
    - **matchEntity**: 当前比赛的信息（类型为 `MatchEntity`）。
    - **_playInfo**: 当前选中的玩法信息（类型为 `PlayInfo`）。
    - **isSelect**: 标记当前是否选中某个玩法。
    - **isMoreSelect**: 标记是否显示更多玩法选项。
    - **plays**: 存储可选玩法的信息列表。
    ## UI 构建
    - **build()**: 根据比赛状态（常规赛或加时赛）构建 UI，包括：
    - 切换按钮（常规赛与加时赛）。
    - 玩法列表，支持点击选择和动态更新。

    ## 玩法管理
    - **setDataPlays()**: 根据比赛状态设置子玩法列表。
    - **_createPlayInfo()**: 创建 `PlayInfo` 对象的方法。

    ## 交互处理
    - **_buildToggleButton()**: 处理切换常规赛和加时赛的逻辑。
    - **_buildHeader()**: 显示玩法标题，并处理点击事件。
    - **showMoreItem()**: 显示更多玩法的弹出菜单，允许用户选择额外的玩法。

    ## 其他功能
    - **isShowRegularAndOvertimeTogether()**: 检查是否需要显示加时赛和常规赛的切换开关。
    - **isOvertimeMatchView()**: 构建切换视图，显示常规赛和加时赛的选择。
    】】】
 *
 */
///角球', '15分钟', '波胆', '特色组合', '罚牌

class SecondayGamePlayWidget extends StatefulWidget {
  const SecondayGamePlayWidget({super.key, required this.matchEntity});
  final MatchEntity matchEntity;
  @override
  State<SecondayGamePlayWidget> createState() => _SecondayGamePlayWidgetState();
}

class _SecondayGamePlayWidgetState extends State<SecondayGamePlayWidget> {

  late SecondaryStateModel state;
  DateTime? lastUpdateTime;
  ///常规赛赛-加时赛切换开关
  late bool isOvertimeMatch = false;
  bool isMoreSelect = false; //更多组合
  ///展开还是收起
  bool isSelect = false;
  String mid = "";
  String moreSelectTitle = "";
  ///这里是用于主cell里面的玩法合集
  // List<PlayInfo> plays = [];
  ///这里是用于展开后的加时赛或者点球的玩法合集
  // List<PlayInfo> playsOvertime = [];
  // ScrollController, x, y, Keys 均已移至 SecondaryGamePlayHeader
  PlayInfo _playInfo = PlayInfo(
    title: '',
    playId: '',
    pids: '',
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final initSwitch = widget.matchEntity.kySwitch;
    state = SecondaryStateModel(
      kySwitch: initSwitch,
      currentPlayType: _computePlayType(initSwitch),
      showOvertime: false,
      showPenalty: false,
      plays: [],
      subPlays: [],
    );
    _recomputeState();

    ///UI刷新 初始化数据
    final match = widget.matchEntity;
    Map? savedMap = SecondaryController.map;
    Map? map = savedMap[match.mid];
    setState(() {
      if (map?["playInfo"] != null) {
        _playInfo = map?['playInfo'];
        mid = map?['mid'];
        isSelect = map?['isSelect'] == 1;
        isMoreSelect = map?['isSelect'] == 2;
      }
    });
    EventBus().on<EventType>().listen((event) {
      if (event == EventType.refreshHome && (isSelect || isMoreSelect)) {
        TyHomeController.to.getMatchBaseInfo(match, _playInfo);
      }
    });
    EventBus().on<EventType>().listen((event) {
      if (event == EventType.changeLang && (isSelect || isMoreSelect))
        TyHomeController.to.getMatchBaseInfo(match, _playInfo);
    });
  }

  @override
  void didUpdateWidget(covariant SecondayGamePlayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newSwitch = widget.matchEntity.kySwitch;
    if (newSwitch.playType == -1) {
      return;
    }
    /// 若无变化，不需要更新
    if (newSwitch == state.kySwitch) return;

    // /// 2 秒节流
    final now = DateTime.now();    if (lastUpdateTime != null &&

        now.difference(lastUpdateTime!).inSeconds < 2) {
      return;
    }

    lastUpdateTime = now;
    /// 更新 kySwitch 并重新计算 UI
    state = state.copyWith(kySwitch: newSwitch);
    _recomputeState();

  }

  ///判断是否常规赛加时赛同时显示
  bool _isShowRegularAndOvertimeTogether(MatchEntity match) {
    bool showBoth = false;
    showBoth = (match.cosCorner ||
        match.cos15Minutes ||
        match.cosBold ||
        match.compose ||
        match.cosPunish) &&
        (match.cosTBold ||
            match.cosTCorner ||
            match.cosTPunish ||
            match.cosOvertime ||
            match.cosPenalty);
    return showBoth;
  }

  ///   构建玩法逻辑（ 主玩法/子玩法 以及对应的  常规赛 / 加时赛）
  List<PlayInfo> _buildPlays(
      MatchEntity match,
      bool isMainPlays,
      int currentPlayType,
      String playsState, // regular / both / overtime
      ) {
    final List<PlayInfo> list = [];

    // 函数：添加常规玩法
    void addRegular() {
      if (match.cosCorner)
        list.add(_createPlayInfo(LocaleKeys.football_playing_way_corner.tr,
            playIdConfig.hpsCorner, '-111,113,-114,-119,-121,-122'));

      if (match.cos15Minutes)
        list.add(_createPlayInfo(LocaleKeys.football_playing_way_hps15Minutes.tr,
            playIdConfig.hps15Minutes, '32,33,34,231,232,233'));

      if (match.cosBold)
        list.add(_createPlayInfo(LocaleKeys.football_playing_way_hpsBold.tr,
            playIdConfig.hpsBold, '7'));

      if (match.compose)
        list.add(_createPlayInfo(LocaleKeys.football_playing_way_feature.tr,
            playIdConfig.hpsCompose, "13,101,345,105"));

      if (match.cosPunish)
        list.add(_createPlayInfo(LocaleKeys.football_playing_way_penalty_cards.tr,
            playIdConfig.hpsPunish, '310,306,307,311,308,309'));

      if (match.cosPenalty)
        list.add(_createPlayInfo(LocaleKeys.football_playing_way_penalty_shootout.tr,
            playIdConfig.hpsPenalty, '-333,-334,-335'));
    }

    // 函数：添加加时赛玩法
    void addOvertime() {
      if (match.cosOvertime)
        list.add(_createPlayInfo(LocaleKeys.app_extra_time_goal.tr,
            playIdConfig.hpsOvertime, '-126,-128,-127,-129,-130,-332'));

      if (match.cosTCorner)
        list.add(_createPlayInfo(LocaleKeys.app_extra_time_corners.tr,
            playIdConfig.hpsCornerOvertime,
            '331,1100413,1100414,1100415,1100416,1100417'));

      if (match.cosTPunish)
        list.add(_createPlayInfo(LocaleKeys.app_extra_time_cards.tr,
            playIdConfig.hpsPunishOvertime,
            '1100405,1100406,1100407,1100408,1100409,1100410'));

      if (match.cosTBold)
        list.add(_createPlayInfo(LocaleKeys.app_extra_time_correct_score.tr,
            playIdConfig.hpsBoldOvertime, '343'));

      if (match.cosPenalty &&
          !['32', '33', '41', '42', '50', '110'].contains(match.mmp))
        list.add(_createPlayInfo(LocaleKeys.football_playing_way_penalty_shootout.tr,
            playIdConfig.hpsPenalty, '-333,-334,-335'));
    }
    // 函数：添加常规 + 加时（all）
    void addAll() {
      addRegular();
      addOvertime();
    }

    // 主体逻辑：
    if (isMainPlays) {
      // ★ mainCell 一定要加上 晋级 + 冠军
      if (match.cosPromotion)
        list.add(_createPlayInfo(LocaleKeys.football_playing_way_promotion.tr,
            playIdConfig.hpsPromotion, '-135,-136'));
      if (match.cosOutright)
        list.add(_createPlayInfo(LocaleKeys.ouzhou_match_outrights.tr,
            playIdConfig.hpsOutright, '136'));
      // 继续处理 mainCell 的其他玩法
      if (currentPlayType == 1) {

        if (playsState == 'both') {
          addRegular();
        } else if (playsState == 'regular') {
          addRegular();
        } else { // overtime
          addOvertime();
        }
      } else { // currentPlayType != 1
        if (playsState == 'both') {
          addAll();
        } else if (playsState == 'regular') {
          addRegular();
        } else { // overtime
          addOvertime();
        }
      }
    } else {
      // subCell 逻辑
      //
      if (currentPlayType == 1) {
        if (playsState == 'both') {
          addOvertime(); // subCell 只显示加时赛
        } else {
          return list; // 空
        }
      } else {
        return list; // 空
      }
    }
    return list;
  }

  ///   统一计算 UI 所有逻辑
  void _recomputeState() {
    final match = widget.matchEntity;
    final ky = state.kySwitch;

    /// 1. 计算 currentPlayType
    final currentPlayType = _computePlayType(ky);

    /// 2. 计算显示隐藏
    final showOvertime = match.cosOvertime == true &&
        !['34'].contains(match.mmp) &&
        currentPlayType == 1;

    final showPenalty = match.cosPenalty == true &&
        ['32', '33', '41', '42', '110'].contains(match.mmp) &&
        currentPlayType == 1;

    /// 3. 生成玩法（常规赛 + 加时赛）
    String playsState = _computePlaysState(match);

    final plays = _buildPlays(match, true, currentPlayType, playsState);
    final subPlays = _buildPlays(match, false, currentPlayType, playsState);

    /// 4. 一次性 setState → build 只渲染状态，不做逻辑
    setState(() {
      state = state.copyWith(
        currentPlayType: currentPlayType,
        showOvertime: showOvertime,
        showPenalty: showPenalty,
        plays: plays,
        subPlays: subPlays,
      );
    });
  }


  ///   计算玩法类型
  int _computePlayType(KySwitch kySwitch) {
    // if (kySwitch.playType == -1) return state.currentPlayType;

    if (kySwitch.playType == 0) return 1;

    if (kySwitch.playType == 1) {
      if (kySwitch.tournamentId.isEmpty) return 2;

      /// match 的 tid 是否在 list 中
      if (kySwitch.tournamentId.contains(widget.matchEntity.tid.toString())) {
        return 1;
      }
      return 2;
    }

    return 0;
  }

  /// 创建 PlayInfo 对象
  PlayInfo _createPlayInfo(String title, String playId, String pids) {
    return PlayInfo(
      title: title,
      playId: playId,
      pids: pids,
    );
  }

  /// 集中处理Header组件传回的点击逻辑
  void _handlePlaySelection(PlayInfo info, bool selected, bool moreSelected) {
    final match = widget.matchEntity;

    setState(() {
      _playInfo = info;
      isSelect = selected;
      isMoreSelect = moreSelected;

      if (moreSelected) {
        moreSelectTitle = info.title;
        // 如果是更多里的，强制关闭常规选中 (虽然逻辑上 selected 参数已经传了false进来)
        // if (isSelect) { isSelect = false; } 逻辑已合并到参数
      }

      // 构造保存数据
      Map<String, dynamic> map = {
        "playInfo": _playInfo,
        "isSelect": isMoreSelect ? 2 : (isSelect ? 1 : 0),
        "mid": isSelect || isMoreSelect ? match.mid : "", // 取消选中时mid清空逻辑
        "tag": isSelect || isMoreSelect ? _playInfo.playId : '',
      };

      Map savedMap = SecondaryController.map;
      savedMap[match.mid] = map;
    });

    if (selected || moreSelected) {
      TyHomeController.to.getMatchBaseInfo(match, _playInfo);
      TyHomeController.to.setSecondaryName(info.title, match.mid);
    }
  }

  ///当前比赛阶段判断
  String _computePlaysState(match) {
    /// 返回 1 常规加时同时都存在
    /// 返回 2 只有常规赛
    /// 返回 3 只有加时赛
    // plays.clear();
    if (!_isShowRegularAndOvertimeTogether(match)) {
      ///只有常规赛
      if ((match.cosCorner ||
          match.cos15Minutes ||
          match.cosBold ||
          match.compose ||
          match.cosPunish) && !['32','33','41','42','110'].contains(match.mmp)) {
        // match.cosPunish)) {
        return  'regular';
      } else {
        ///只有加时赛
        return 'overtime';
      }
    }else{
      ///加时赛常规赛同时存在
      return  'both';
    }
  }


  @override
  Widget build(BuildContext context) {
    final s = state;
    final match = widget.matchEntity;

    ///当只有常规赛，或者只有加时赛的时候处理（有时候数据只有常规赛，或者只有加时赛，特殊处理）
    ///此处判断为判断常规赛和加时赛是否同时存在

    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // 替换为拆分后的组件
                child: SecondaryGamePlayHeader(
                  match: match,
                  plays: s.plays,
                  currentPlayInfo: _playInfo,
                  isSelect: isSelect,
                  isMoreSelect: isMoreSelect,
                  onPlaySelected: _handlePlaySelection,
                ),
              ),
            ],
          ),
          buildBodyWidget(
            match: match,
            playInfo: _playInfo,
            isMoreSelect: isMoreSelect,
            isSelect: isSelect,
            mid: mid,
          ),

          /// 具体加时赛渲染部分
          Visibility(
            key: ValueKey('${match.mid}_${match.mmp}_cosOvertime_${s.currentPlayType}'),
            visible: s.showOvertime,
            child: CornerPlayTempOvertime(
              // key: ValueKey(playIdConfig.hpsOvertime + mid),
              match: match,
              hps: match.hpsOvertime,
              playId: playIdConfig.hpsOvertime,
              isMainPlay: false,
              plays: s.subPlays,
            ),
          ),

          Visibility(
              key: ValueKey('${match.mid}_${match.mmp}_cosPenalty_${s.currentPlayType}'),
              visible: s.showPenalty,
              child: CornerPlayTempPenalty(
                // key: ValueKey(playIdConfig.hpsPenalty + mid),
                match: match,
                hps: match.hpsPenalty,
                playId: playIdConfig.hpsPenalty,
                isMainPlay: false,
                plays: s.subPlays.where((item)=>[playIdConfig.hpsPromotion,playIdConfig.hpsOutright].contains(item.playId)).toList(),
              )
          ),
        ],
      ),
    );
  }
}