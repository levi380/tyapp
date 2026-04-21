/// @Author swifter
/// @Date 2024/2/4 18:31
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-c43ee781-8ca5-42bd-a755-8e7f97e8410e-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  全局消息通知类型枚举 】】】
    【【【 AUTO_PARAGRAPH_TITLE 全局消息通知类型枚举入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 全局事件通知类型枚举
    ```
    enum EventType {
    切换主题
    changeTheme,
    切换菜单
    changeMenu,
    盘口切换
    changeOddType,
   ws数据更新
    wsDataUpdate,
    赛事状态更新
    wsMatchAnalysisUpdate,
    match market odds 变化
    wsMatchMarketOddsUpdate,
    退出登录
    app退出  (之前接口返回错误达到配置 需要重新登录  现已移除)
    所以本通知注释处理 统一走tyloginout事件
    appSignOut,
    联赛ID
    tid,
    切换投注类型
    changeBetType,
    详情页返回
    detailBack,
    列表分组折叠展开
    groupExpand,
    电竞列表分组折叠展开
    djGroupExpand,
    C101, C102, C103, C104, C107
    动画状态 mvs -1: 没有配置动画源  0 已配置 不可用  1/2 已配置 可用
    视频状态 mms -1: 没有配置动画源  0 已配置 不可用  1 已配置 暂未播放  2 已配置 播放中
    RCMD_C105,

    RCMD_C101,
    详情接口更新
    updata_detail_data,
    赛事事件
    RCMD_C102,
    盘口赔率
    RCMD_C105,
    scmd_c8,
    财务推送 收到这个命令需要刷新整个页面
    RCMD_C108,
    109 赛事开盘推送 无需订阅  自动推送
    同步赛事状态 调用相关的api接口
    RCMD_C109,
    赛事订阅C1-玩法数量
    赛事玩法数量同步到玩法数量显示区域
    RCMD_C110,
    赔率相关刷新通知
    RCMD_C11,
    112 玩法集变更
    socketOddinfo,
    盘口结束时间(针对冠军赛事)
    RCMD_C120,
    未结算订单数 未结算订单数量变化 C3订阅
    RCMD_C202,
    用户账变 重新请求用户余额接口
    RCMD_C203,
    赛事提前结算投注想  C21订阅   提前结算投注项数据变化通知
    RCMD_C210,
    菜单栏目统计
    菜单栏目数量变化时触发
    RCMD_C301,
    废除
    RCMD_C304,
    新版UI菜单 C51订阅
    RCMD_C501,
    热门赛事变化时触发
    RCMD_C601,
    倒计时补充
    C8订阅  主要是同步倒计时事件
    RCMD_C801,
    赛事开赛状态
    触发http请求
    init302,
    投注选中状态更新
    oddsButtonUpdate,
    关盘补充
    收到消息后 根据联四和赛事信息删除联赛下的赛事
    RCMD_C901,
    赛事事件 通知赛事变化 更新指定模块显示逻辑
    C81订阅
    RCMD_C1021,
    菜单栏顺序变更
    RCMD_C3011,
    注单，提前结算 201
    orderPreSettle,
    SDK URL
    H5url,
    详情默认比分
    nativeDetailData,
    matchNoStart,
    matchTimeInit,
    changeLang,
    matchTimerFetch,
    回滚到顶部
    scrollToTop,
    removeMatch,
    closeSearch,
    leagueReset,
    vr详情通知投注关盘
    VRDetailClose,
    vr详情通知投注赛事结束显示赛果
    VRDetailEnd,
    用户级单枪单边水差推送 刷新赔率
    send_bat_handicap_odds,
    去登录
    tyToLogin,
    登录成功
    登录成功 刷新首页收藏状态 由于‘登录成功’的推送事件需要处理token保存 有延迟  所以列表收藏状态不能通用
    tyLogined,
    退出登录
    tyLogout,
    token 失效
    tokenExpired,
    金额刷新
    tyAmountRefresh,
    列表滚动状态 上
    listScrollingUp,
    列表滚动状态 下
    listScrollingDown,
    }
    ```
    】】】
 *
 */
enum EventType {
  /// 切换主题
  changeTheme,

  /// 切换菜单
  changeMenu,

  /// 盘口切换
  changeOddType,

  /// ws数据更新
  wsDataUpdate,

  /// 赛事状态更新
  wsMatchAnalysisUpdate,

  /// match market odds 变化
  wsMatchMarketOddsUpdate,

  /// 退出登录
  /// app退出  (之前接口返回错误达到配置 需要重新登录  现已移除)
  /// 所以本通知注释处理 统一走tyloginout事件
  // appSignOut,

  /// 联赛ID
  tid,

  /// 切换投注类型
  changeBetType,

  /// 详情页返回
  detailBack,

  /// 列表分组折叠展开
  groupExpand,

  /// 电竞列表分组折叠展开
  djGroupExpand,

  ///C101, C102, C103, C104, C107
  /// 动画状态 mvs -1: 没有配置动画源  0 已配置 不可用  1/2 已配置 可用
  /// 视频状态 mms -1: 没有配置动画源  0 已配置 不可用  1 已配置 暂未播放  2 已配置 播放中
  ///   RCMD_C105,
  ///
  RCMD_C101,

  ///详情接口更新
  updata_detail_data,

  ///赛事事件
  RCMD_C102,

  ///盘口赔率
  RCMD_C105,
  scmd_c8,

  /// 财务推送 收到这个命令需要刷新整个页面
  RCMD_C108,

  ///109 赛事开盘推送 无需订阅  自动推送
  /// ***** 同步赛事状态 调用相关的api接口
  RCMD_C109,

  ///赛事订阅C1-玩法数量
  ///赛事玩法数量同步到玩法数量显示区域
  RCMD_C110,

  ///赔率相关刷新通知
  RCMD_C11,

  ///112 玩法集变更
  socketOddinfo,

  /// 优惠盘口ws 系统级别推送
  RCMD_C152,
  RCMD_C153,

  ///盘口结束时间(针对冠军赛事)
  RCMD_C120,

  /// 未结算订单数 未结算订单数量变化 C3订阅
  RCMD_C202,

  ///用户账变 重新请求用户余额接口
  RCMD_C203,

  /// 赛事提前结算投注想  C21订阅   提前结算投注项数据变化通知
  RCMD_C210,

  ///菜单栏目统计
  ///菜单栏目数量变化时触发
  RCMD_C301,

  ///废除
  RCMD_C304,

  ///新版UI菜单 C51订阅
  RCMD_C501,

  ///热门赛事变化时触发
  RCMD_C601,

  ///倒计时补充
  ///C8订阅  主要是同步倒计时事件
  RCMD_C801,

  ///赛事开赛状态
  ///***触发http请求
  init302,

  /// 投注选中状态更新
  oddsButtonUpdate,

  ///关盘补充
  ///收到消息后 根据联四和赛事信息删除联赛下的赛事
  RCMD_C901,

  ///赛事事件 通知赛事变化 更新指定模块显示逻辑
  ///C81订阅
  RCMD_C1021,

  ///C14订阅
  ///赛事分析  走势图ws
  RCMD_C1041,

  ///菜单栏顺序变更
  RCMD_C3011,

  ///注单，提前结算 201
  orderPreSettle,

  ///SDK URL
  H5url,

  /// 详情默认比分
  nativeDetailData,
  matchNoStart,
  matchTimeInit,
  changeLang,
  matchTimerFetch,

  /// 回滚到顶部
  scrollToTop,
  removeMatch,
  // closeSearch,
  leagueReset,

  ///vr详情通知投注关盘
  VRDetailClose,

  ///vr详情通知投注赛事结束显示赛果
  VRDetailEnd,

  ///用户级单枪单边水差推送 刷新赔率
  send_bat_handicap_odds,

  ///去登录
  tyToLogin,

  ///登录成功
  ///登录成功 刷新首页收藏状态 由于‘登录成功’的推送事件需要处理token保存 有延迟  所以列表收藏状态不能通用
  tyLogined,

  ///退出登录
  tyLogout,

  ///token 失效
  tokenExpired,

  ///金额刷新
  tyAmountRefresh,

  ///列表滚动状态 上
  listScrollingUp,

  ///列表滚动状态 下
  listScrollingDown,

  /// 刷新首页
  refreshHome,

  /// 联赛搜索
  leagueSearchClick,

  /// 联赛搜索内容
  leagueSearchContent,

  /// 电竞搜索
  djSearchContent,
  /// 是否切到热门
  isHot,

  /// 打开弹框
  tyOpenDialog,
  /// 关闭框
  tyCloseDialog,

  /// 详情页是否在播放动画
  matchDetailIsPlayingAnimation,

  /// 详情页赛事列表关闭
  matchDetailMatchListClosed

}


class EventPayLoad {
  EventType eventType;
  dynamic data;

  EventPayLoad(this.eventType, this.data);
}