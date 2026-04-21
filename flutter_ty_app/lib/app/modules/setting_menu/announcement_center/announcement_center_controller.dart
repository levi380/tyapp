import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/announcement_center/announcement_center_controller_ext.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import '../../../../generated/locales.g.dart';
import '../../../core/constant/project/module/betting/bet-odds-constant.dart';
import '../../../services/api/notice_center_api.dart';
import '../../../services/models/res/get_notice_front_list_new_entity.dart';
import '../../../utils/oss_util.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../../utils/utils.dart';
import 'announcement_center_logic.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a3a627ae-2de5-4ce2-862f-eeb8573aa24d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 公告中心】】】
    【【【 AUTO_PARAGRAPH_TITLE 公告中心 控制器 AnnouncementCenterController  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 公告中心 控制器 AnnouncementCenterController
    - AnnouncementCenterController
    ```
    ///选项卡控制器
    late TabController tabController;

    ///滚动控制器
    final ScrollController scrollController = ScrollController();

    ///输入框控制器
    TextEditingController searchController = TextEditingController();

    ///光标控制器
    final FocusNode focusNode = FocusNode();

    ///列表观察者控制器
    late ListObserverController listObserverController =
    ListObserverController(controller: scrollController);

    ///显示关闭日期弹窗
    bool openDate = false;

    ///更新数据
    bool updateList = false;

    ///开始时间
    String beginTime = '';

    ///结束时间
    String endTime = '';

    ///外部时间区间
    DateTime? rangeStart;
    DateTime? rangeEnd;

    ///类型
    String noticeType = '';

    ///固定展示时间
    String sendTimeOther = '';

    ///公告列表数据
    late List<GetNoticeFrontListDataNb> nb = [];

    ///根据搜索条件删选后数据
    late List<GetNoticeFrontListDataNb> nbList = nb.where((item) {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    if (searchControllerText.isEmpty) {
    return true;
    }

    return keywords.every((keyword) {
    var lowerKeyword = keyword.toLowerCase();
    return item.context.toLowerCase().contains(lowerKeyword);
    });
    }).toList();

    ///球种类型数据
    late List<GetNoticeFrontListDataNl> nl = [];

    ///置顶按钮
    bool returnToFirst = false;

    ///搜索框
    bool searchBox = false;

    ```
    】】】
 *
 */
class AnnouncementCenterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AnnouncementCenterLogic logic = AnnouncementCenterLogic();

  ///选项卡控制器
  late TabController tabController;

  ///滚动控制器
  final ScrollController scrollController = ScrollController();

  ///输入框控制器
  TextEditingController searchController = TextEditingController();

  ///光标控制器
  final FocusNode focusNode = FocusNode();

  ///列表观察者控制器
  late ListObserverController listObserverController =
      ListObserverController(controller: scrollController);





  ///公告列表数据
  late List<GetNoticeFrontListNewDataNb> nb = [];
  late List<GetNoticeFrontListNewDataNb> nbs = [];

  ///根据搜索条件删选后数据
  late List<GetNoticeFrontListNewDataNb> nbList = nb.where((item) {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    if (searchControllerText.isEmpty) {
      return true;
    }

    return keywords.every((keyword) {
      var lowerKeyword = keyword.toLowerCase();
      return logic.typeIndex == 0 ? (item.context1.toLowerCase().contains(lowerKeyword) || item.context2.toLowerCase().contains(lowerKeyword)) : item.context.toLowerCase().contains(lowerKeyword);
    });
  }).toList();

  ///球种类型数据
  late List<GetNoticeFrontListNewDataNl> nl = [];



  @override
  void onInit() {
    // TODO: implement onInit
    logic.nlBool = true;
    initData();

    ///监听滚动位置
    scrollController.addListener(() {
      if (scrollController.offset > 5 * 100.0) {
        logic.returnToFirst = true;
        update();
      } else {
        logic.returnToFirst = false;
        update();
      }
    });
    super.onInit();
  }

  ///滚动到最上方
  void scrollToFirstItem() {
    listObserverController.animateTo(
      index: 0,
      duration: const Duration(milliseconds: 10),
      curve: Curves.ease,
    );
    update();
  }

  ///滚动的最后一页
  void scrollToTheLastPage(int item) {
    listObserverController.animateTo(
      index: item,
      duration: const Duration(milliseconds: 10),
      curve: Curves.ease,
    );
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///接口数据
  Future<void> initData() async {
    logic.updateList = true;
    update();
    nb.clear();
    nbList.clear();
    nl.clear();
    final res;
    if ((logic.noticeType=='8888'|| logic.noticeType=='9999') && logic.beginTime.isEmpty && logic.endTime.isEmpty) {
      res = await NoticeCenterApi.instance().getNoticeFrontLists();
    }else if ((logic.noticeType=='8888'|| logic.noticeType=='9999')  && logic.beginTime.isNotEmpty && logic.endTime.isNotEmpty) {
      res = await NoticeCenterApi.instance().getNoticeFrontListBeginTime(logic.beginTime, logic.endTime);
    } else if (logic.noticeType.isEmpty && logic.beginTime.isEmpty && logic.endTime.isEmpty) {
      res = await NoticeCenterApi.instance().getNoticeFrontLists();
    } else if (logic.beginTime.isEmpty && logic.endTime.isEmpty) {
      res = await NoticeCenterApi.instance().getNoticeFrontListNoticeType(logic.noticeType);
    } else if ((logic.beginTime.isNotEmpty && logic.endTime.isNotEmpty) && logic.noticeType.isEmpty) {
      res = await NoticeCenterApi.instance().getNoticeFrontListBeginTime(logic.beginTime, logic.endTime);
    } else {
      res = await NoticeCenterApi.instance().getNoticeFrontList(logic.beginTime, logic.endTime, logic.noticeType);
    }

    if (res.code == '0401038') {
      initData();
    } else {

      if (nl.isEmpty) {

        GetNoticeFrontListNewDataNl getNoticeFrontListNewDataNl =
        new GetNoticeFrontListNewDataNl();
        getNoticeFrontListNewDataNl.nen = LocaleKeys.app_relatedToMe.tr;
        getNoticeFrontListNewDataNl.net = '9999';
        nl.add(getNoticeFrontListNewDataNl);

        GetNoticeFrontListNewDataNl getNoticeFrontListNewDataNls =
        new GetNoticeFrontListNewDataNl();
        getNoticeFrontListNewDataNls.nen = LocaleKeys.common_all_notice.tr;
        getNoticeFrontListNewDataNls.net = '8888';
        nl.add(getNoticeFrontListNewDataNls);
        nl.addAll(res.data.nl);
        logic.sIndex = 0;
        var countIndex = 0;
        for (var i = 0; i < nl.length; i++) {
          countIndex += nl[i].mtl.length;
        }
        logic.sIndex = countIndex;
        if(logic.nlBool){
          tabController = TabController(length: nl.length, vsync: this);
          logic.nlBool = false;
        }

      }

      if (res.data.nb.isNotEmpty) {
        nb = res.data.nb;
        logic.sendTimeOther = DateUtil.formatDateMs(
            TimeZoneUtils.convertTimeToTimestamp(nb[0].sendTimeOther,
                    formatIndex: 4,
                    isMilliseconds: true,
                    returnMilliseconds: true) ??
                0,
            format: LocaleKeys.time12.tr,
            isUtc: true);
      }



      if(logic.typeIndex==0){
        logic.yIndex = 0;
        for (int i = 0; i < nb.length; i++) {
          if (nb[i].orderInfo.id.isNotEmpty) {
            for (int e = 0; e < nb[i].orderInfo.detailList.length; e++){

              String orderText = nb[i].context;
              String orderText1;
              /// 1 赔率增值 {投注时间}{注单ID}{增值前赔率}>>{增值后赔率}  {赛事阶段}{玩法名称}[{盘口类型}]{开赛时间}投注额：{投注额} 最高可赢：{最高可赢}
              /// 2 预约单  [{注单类型}]{投注时间}{注单ID}{投注项}{赔率}{赛事阶段}{玩法名称}[{盘口类型}]{开赛时间}投注额：{投注额} 最高可赢：{最高可赢}
              /// 3 合买单  [{注单类型}]{投注时间}{注单ID}{投注项名称}{赔率}{赛事阶段}{玩法名称}[{盘口类型}]{开赛时间}投注额：{投注额} 最高可赢：{最高可赢}
              /// 4 单关 [{注单类型}]{投注时间}{注单ID}{投注项}{赔率}{赛事阶段}{玩法名称}[{盘口类型}]{开赛时间}投注额：{投注额} 最高可赢：{最高可赢}
              /// 5 串关 [{注单类型}]{投注时间}{注单ID}{串关方式}{赔率}{赛事阶段}{玩法名称}[{盘口类型}]{开赛时间}投注额：{投注额} 最高可赢：{最高可赢}

              ///投注类型
              String   seriesValue = nb[i].orderInfo.seriesValue;
              ///投注时间
              String betTime = DateUtil.formatDateMs(TimeZoneUtils.convertTimeToTimestamp(nb[i].orderInfo.betTime, isMilliseconds: true, returnMilliseconds: true) ?? 0, format: LocaleKeys.time6.tr, isUtc: true) + "  (" + TimeZoneUtils.getTimeZoneString() + ")  ";
              ///注单ID
              String orderNo = nb[i].orderInfo.orderNo;
              ///投注项
              String marketValue = nb[i].orderInfo.detailList[e].marketValue;
              ///赔率
              String oddFinally = "@${nb[i].orderInfo.detailList[e].oddFinally}";
              ///赛事阶段-玩法名称
              String getPlayName = getPlayNames(i,e);
              ///盘口类型
              String marketType = oddsConstant.firstWhereOrNull((s) => s.value == nb[i].orderInfo.detailList[e].marketType)?.label.tr ?? nb[i].orderInfo.detailList[e].marketType ;
              ///开赛时间
              String beginTime = DateUtil.formatDateMs(TimeZoneUtils.convertTimeToTimestamp(nb[i].orderInfo.detailList[e].beginTime, isMilliseconds: true, returnMilliseconds: true) ?? 0, format: LocaleKeys.time6.tr, isUtc: true) + "  (" + TimeZoneUtils.getTimeZoneString() + ")  ";;
              ///投注额
              String orderAmountTotal = LocaleKeys.zr_cp_Lottery_Bet_Slips_bet_amount.tr+' ：' +setAmount(nb[i].orderInfo.orderAmountTotal.toString()) ;
              ///最高可赢
              String maxWinAmount = LocaleKeys.bet_total_win2.tr+' ：' +setAmount(nb[i].orderInfo.maxWinAmount.toString()) ;
              ///串关方式
              String marketTypes = nb[i].orderInfo.seriesValue;
              ///   预约单 1
              ///   单关 2
              ///   串关 3
              ///   赔率增值 4
              ///   合买单 5
              int orderType = determineOrderType(nb[i].orderInfo);
              print('订单类型---'+orderType.toString());

              ///单关
              String bookSingle = '[${LocaleKeys.bet_bet.tr}] $betTime $orderNo $marketValue $oddFinally $getPlayName [$marketType] $beginTime $orderAmountTotal $maxWinAmount';
              ///预约单
              String reserve = '[${LocaleKeys.bet_bet_book_confirm.tr}] $betTime $orderNo $marketValue $oddFinally $getPlayName [$marketType] $beginTime $orderAmountTotal $maxWinAmount';
              ///串关
              String parlay = '[${LocaleKeys.new_menu_1016.tr}] $betTime $orderNo $marketTypes $oddFinally $getPlayName [$marketType]  $beginTime $orderAmountTotal $maxWinAmount';
              ///赔率增值
              String img = '<img src="${OssUtil.getServerPath('assets/images/plzz.svg',)}" width="14" height="14" alt="">';
              String odds = '@<del>${nb[i].orderInfo.detailList[e].eov}</del> >> ${nb[i].orderInfo.detailList[e].oddFinally}';
              String oddsIncrease = '$betTime $orderNo  $getPlayName [$marketType] $odds  $img $beginTime $orderAmountTotal $maxWinAmount';
              ///合买单
              String groupPurchase = '[$seriesValue] $betTime $orderNo $marketValue $oddFinally $getPlayName [$marketType] $beginTime $orderAmountTotal $maxWinAmount';
              if(orderType==1){
                orderText1 = reserve;
              }else if(orderType == 2){
                orderText1 = bookSingle ;
              }else if(orderType == 3){
                orderText1 = parlay;
              }else if(orderType == 4){
                orderText1 = oddsIncrease;
              }else if(orderType == 5){
                orderText1 = groupPurchase;
              }else {
                orderText1 = bookSingle;
              }


              nb[i].context1 = orderText;
              nb[i].context2 = orderText1;
            }
            nbs.add(nb[i]);
          }
        }
        logic.yIndex = nbs.length;
        nb = nbs;
      }
      nbList = nb;

    }


    logic.updateList = false;

    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    nbList = nb.where((item) {
      if (searchControllerText.isEmpty) {
        return true;
      }
      return keywords.every((keyword) {
        var lowerKeyword = keyword.toLowerCase();
        return logic.typeIndex == 0 ? (item.context1.toLowerCase().contains(lowerKeyword) || item.context2.toLowerCase().contains(lowerKeyword)) : item.context.toLowerCase().contains(lowerKeyword);
      });
    }).toList();
    update();
  }

  ///订单类型
   determineOrderType(GetNoticeFrontListNewDataNbOrderInfo orderInfo) {
      /// 根据订单信息判断订单类型 优先级高到低
      /// 赔率增值    1级
      ///预约单      2级
      ///合买单      3级
      ///单关        4级
      ///串关        5级

     /// 预约
     if (orderInfo.orderClass == 2) {
       /// 判断是否有赔率增值
       if (orderInfo.detailList.isNotEmpty) {
         /// 判断是否为赔率增值
         if (orderInfo.detailList.any((item) => item.eov != '')) {
           return 4; // 赔率增值
         }
       }
       return 1; /// 预约单
     }

     /// 合买
     if (orderInfo.orderClass == 3) {
       /// 判断是否有赔率增值
       if (orderInfo.detailList.isNotEmpty) {
         /// 判断是否为赔率增值
         if (orderInfo.detailList.any((item) => item.eov != '')) {
           return 4; /// 赔率增值
         }
       }
       return 5; /// 合买单
     }

     /// 常规单
     if (orderInfo.orderClass == 1) {
       /// 判断是否有赔率增值
       if (orderInfo.detailList.isNotEmpty) {
         /// 判断是否为赔率增值
         if (orderInfo.detailList.any((item) => item.eov != '')) {
           return 4; /// 赔率增值
         } else {
           /// 判断是否是串关 单关
           if (orderInfo.seriesType == '1') {
             return 2; /// 单关
           } else {
             return 3; /// 串关
           }
         }
       }
     }

     return 0; // 默认返回值（可根据需要调整）
  }

  ///头部打开关闭日期筛选
  onOpenDate() {
    logic.openDate = !logic.openDate;
    update();
  }

  ///关闭删选
  onCloseData() {
    logic.openDate = false;
    update();
  }

}
