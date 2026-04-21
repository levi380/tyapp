import 'dart:math';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/controllers/ZrItemInfo.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_login_entity.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/BaccaratRoadInfo.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/RoadPaperHelper.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/common.dart';
import 'package:flutter_ty_app/app/services/api/zr_api.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_list_entity.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/api_res.dart';
import '../states/zr_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-18253eb3-5a09-49ef-95c2-d1a3f865fd27-zr 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 控制器】】】
    【【【 AUTOMATIC_GENERATE_DOCUMENT_PARAGRAPH_CONTENT
    - 真人列表-控制器
    - 获取台桌信息（接口请求）
    - 筛选出开启的台桌
    - 处理多语言的台桌信息
    】】】
 *
 */
class ZrController extends GetxController {
  static ZrController get to => Get.find();
  ZrState state = ZrState();
  late Timer timer;

  @override
  void onInit() {
    state.isLoading = true;
    getDataList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    timer = Timer.periodic(const Duration(milliseconds: 10000), (timer) {
      // AppLogger.debug("Timer value = ");
      getDataList();
    });
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  Future<void> getDataList() async {
    /** 0-全部 1-历史 默认全部 */
    int tableInfoType = state.isAll ? 0 : 1;
    doudi();
    ZrApi.instance().getGameTableInfo(tableInfoType).then((value) {
      state.processList.clear();
      if (value.data != null) {
        List<ZrItemInfo> tempList = [];
        value.data?.forEach((element) {
          if (element.tableOpen == true) {
            ///筛选出开启的台桌
            ZrItemInfo info = getInfo(element);
            info.originData = element;

            tempList.add(info);
          }
        });
        state.processList.addAll(tempList);
      }
      state.isLoading = false;
      update();
    }).catchError((e) {
      AppLogger.debug("zr --- getDataList :$e");
      state.isLoading = false;
      update();
    });
  }

  ///跳转webview，打开游戏
  toGame(String tableId) async {
    Map<String, dynamic> map = {'terminal': 'h5', 'tableId': tableId};
    ApiRes<ZrLoginEntity> res = await ZrApi.instance().zrUserLogin(map);
    String? dataUrl = res.data?.url;
    String theme = Get.isDarkMode ? 'theme-2' : 'theme-1';
    String url = '$dataUrl&n_theme=$theme-2&hide_return=0';
    // String url = '$dataUrl&n_theme=$theme-2&n_lang=$lang&hide_return=0';

    if (res.code == '200') {
      Get.toNamed(Routes.webGames, arguments: [
        {"title": LocaleKeys.menu_itme_name_zr_menu.tr},
        {"url": url},
      ]);
    }
  }

  ZrItemInfo getInfo(ZrListEntity zrData) {
    ZrItemInfo info = ZrItemInfo();
    /**游戏状态 */
    info.gameStatus = GAME_STATUS[zrData.gameStatus];
    /**国旗图片 - img -- dealerCountry */

    if (ObjectUtil.isNotEmpty(zrData.dealerCountry)) {
      var flagName = IDictItemCountry[zrData.dealerCountry]?['src'];
      if (flagName == null || flagName == "null" || flagName == "") {
        info.flagImgSrc = '';
      } else {
        info.flagImgSrc = 'assets/images/zr/flag/${flagName}.png';
      }
    }
    if (zrData.bootReport != null &&
        zrData.bootReport?.items != null &&
        zrData.bootReport!.items.isNotEmpty) {
      for (int i = 0; i < zrData.bootReport!.items.length; i++) {
        ZrListBootReportItems item = zrData.bootReport!.items[i];
        if (item.betPointId == 3001) {
          //庄

          info.zhuangNum = item.winCount;
        } else if (item.betPointId == 3002) {
          //闲

          info.xianNum = item.winCount;
        } else if (item.betPointId == 3003) {
          //和
          info.heNum = item.winCount;
        } else if (item.betPointId == 3004) {
          //庄对
          info.zhuangduiNum = item.winCount;
        } else if (item.betPointId == 3005) {
          //闲对
          info.xianduiNum = item.winCount;
        }
      }
    }
    /**游戏连玩状态图片 goodRoadPoints 连庄状态字段，可能为空，为数组时，是有多个字段 {"goodRoadType":1,"goodRoadFlag":true,"betPoint":true,"putPoint":true,"sort":2,"num":4}
     * 一个桌台可能同时属于多个好路类型，根据sort排序做一次，sort越小优先级越高，取最小的一个，属于什么好路类型取goodRoadType
     * 枚举在：ROAD_PAPER_TYPE_INFO
     */

    List<ZrListGoodRoadPoints> roadPointList = [];
    //数字可能会大9，对数字进行分割，然后组成一个数组
    List<String> list = [];
    if (zrData.goodRoadPoints is List<ZrListGoodRoadPoints> &&
        zrData.goodRoadPoints!.isNotEmpty) {
      List<ZrListGoodRoadPoints> points = zrData.goodRoadPoints ?? [];
      roadPointList = points..sort((a, b) => a.sort.compareTo(b.sort));

      ZrListGoodRoadPoints roadPoint = roadPointList[0];
      if (roadPoint.num != null) {
        if (roadPoint.num! > 9) {
          (roadPoint.num.toString().split('')).forEach((n) {
            // AppLogger.debug("n = ${n}"),
            list.add('assets/images/zr/road_paper/${n}.png');
          });
        } else {
          list.add('assets/images/zr/road_paper/${roadPoint.num}.png');
        }
      }

      String pngName = '';

      if (StringKV.language.get() == 'CN') {
        pngName =
            'assets/images/zr/road_paper/${ROAD_PAPER_TYPE_INFO[roadPoint.goodRoadType]}.png';
      } else if (StringKV.language.get() == 'GB') {
        pngName =
            'assets/images/zr/road_paper/en_${ROAD_PAPER_TYPE_INFO[roadPoint.goodRoadType]}.png';
      } else if (StringKV.language.get() == 'TW') {
        pngName =
            'assets/images/zr/road_paper/tc_${ROAD_PAPER_TYPE_INFO[roadPoint.goodRoadType]}.png';
      } else if (StringKV.language.get() == 'VN') {
        pngName =
            'assets/images/zr/road_paper/vi_${ROAD_PAPER_TYPE_INFO[roadPoint.goodRoadType]}.png';
      } else if (StringKV.language.get() == 'TH') {
        pngName =
            'assets/images/zr/road_paper/th_${ROAD_PAPER_TYPE_INFO[roadPoint.goodRoadType]}.png';
      } else if (StringKV.language.get() == 'KR') {
        pngName =
            'assets/images/zr/road_paper/kr_${ROAD_PAPER_TYPE_INFO[roadPoint.goodRoadType]}.png';
      } else if (StringKV.language.get() == 'PT') {
        pngName =
            'assets/images/zr/road_paper/en_${ROAD_PAPER_TYPE_INFO[roadPoint.goodRoadType]}.png';
      }
      list.add(pngName);
    }

    info.roadPaperTypeImg = list;
    /**游戏厅类型图片 gameCasinoId 厅类型 */
    var targetId = zrData.gameCasinoId;
    if (targetId == 8) {
      //8、新旗舰厅 也显示为旗舰厅
      targetId = 1;
    }
    if (targetId == 3) {
      //3、亚太厅 也显示为国际厅
      targetId = 5;
    }
    if (targetId == 9) {
      //9、新主播厅 也显示为主播厅
      targetId = 6;
    }
    if (GAME_TYPE_IMG_INFO[targetId] != null) {
      String tag = Get.locale!.toLanguageTag();
      String lang = tag.replaceAll("-", "_");
      if (lang == 'ar_AE' ||
          lang == 'ru_RU' ||
          lang == 'hi_IN' ||
          lang == 'my_MM' ||
          lang == 'es_ES' ||
          lang == 'id_ID' ||
          lang == 'hi_IN' ||
          lang == 'ru_RU') {
        info.gameTypeImg =
            'assets/images/zr/road_paper/en_${GAME_TYPE_IMG_INFO[targetId]}.png';
      } else if (lang == 'en_GB') {
        info.gameTypeImg =
            'assets/images/zr/road_paper/en_${GAME_TYPE_IMG_INFO[targetId]}.png';
      } else if (lang == 'ko_KR') {
        info.gameTypeImg =
            'assets/images/zr/road_paper/kr_${GAME_TYPE_IMG_INFO[targetId]}.png';
      } else if (lang == 'zh_TW') {
        info.gameTypeImg =
            'assets/images/zr/road_paper/tc_${GAME_TYPE_IMG_INFO[targetId]}.png';
      } else if (lang == 'th_TH') {
        info.gameTypeImg =
            'assets/images/zr/road_paper/th_${GAME_TYPE_IMG_INFO[targetId]}.png';
      } else if (lang == 'vi_VN') {
        info.gameTypeImg =
            'assets/images/zr/road_paper/vi_${GAME_TYPE_IMG_INFO[targetId]}.png';
      } else if (lang == 'pt_PT') {
        info.gameTypeImg =
            'assets/images/zr/road_paper/en_${GAME_TYPE_IMG_INFO[targetId]}.png';
      } else {
        info.gameTypeImg =
            'assets/images/zr/road_paper/${GAME_TYPE_IMG_INFO[targetId]}.png';
      }
    }

    /**庄 */
    info.zhuangImg =
        'assets/images/zr/road_paper/${BOOT_TYPE_MAP[3001]}-cn.png';

    /**闲 */
    info.xianImg = 'assets/images/zr/road_paper/${BOOT_TYPE_MAP[3002]}-cn.png';

    /**和 */
    info.heImg = 'assets/images/zr/road_paper/${BOOT_TYPE_MAP[3003]}-cn.png';
    /**状态文字提醒 */

    var imgUrl = 'assets/images/zr/info/maintain_icon.png';
    if (Get.isDarkMode) {
      imgUrl = 'assets/images/zr/info/maintain_icon_dark.png';
    }
    info.statuInfo = {
      'flag': zrData.gameStatus == 6,
      'text': zrData.gameStatus == 6 ? '维护中' : '',
      'imgUrl': imgUrl,
    };

    /**多语言 简体 繁体 英文 葡萄牙 韩语 越南 （葡萄牙接口缺失）*/

    String tag = Get.locale!.toLanguageTag();
    String lang = tag.replaceAll("-", "_");
    if (lang == 'ar_AE' ||
        lang == 'ru_RU' ||
        lang == 'hi_IN' ||
        lang == 'my_MM' ||
        lang == 'es_ES' ||
        lang == 'id_ID' ||
        lang == 'hi_IN' ||
        lang == 'ru_RU') {
      info.tableName = zrData.tableNameLanguageMap.en.content;
    } else if (lang == 'en_GB') {
      info.tableName = zrData.tableNameLanguageMap.en.content;
    } else if (lang == 'ko_KR') {
      info.tableName = zrData.tableNameLanguageMap.kr.content;
    } else if (lang == 'zh_TW') {
      info.tableName = zrData.tableNameLanguageMap.tc.content;
    } else if (lang == 'zh_CN') {
      info.tableName = zrData.tableNameLanguageMap.cn.content;
    } else if (lang == 'th_TH') {
      info.tableName = zrData.tableNameLanguageMap.th.content;
    } else if (lang == 'vi_VN') {
      info.tableName = zrData.tableNameLanguageMap.vi.content;
    } else {
      info.tableName = zrData.tableNameLanguageMap.en.content;
    }

    if (zrData.roadPaper != null) {
      List<List<Map<String, dynamic>>> mRoadList = [];
      mRoadList.addAll(roadDataList(zrData.roadPaper!));
      info.mRoadList = mRoadList;
    } else {
      ///如果路纸图为空，创建占位的列表
      info.mRoadList = [];
      for (int i = 0; i < MaxRow; i++) {
        List<Map<String, dynamic>> listRow = [];
        for (int j = 0; j < colNum; j++) {
          var imgSrc = '';
          var newImgSrc = '';
          var name1 = '';
          var name2 = '';

          listRow.add({
            'name': '$name1$name2',
            'imgSrc': imgSrc,
            'newImgSrc': newImgSrc,
          });
        }

        info.mRoadList?.add(listRow);
      }
    }
    return info;
  }

  var colNum = 6;
  int MaxRow = 22;

  /// 获取图片
  getRoadIcon(name) {
    if (name == null || name == "null" || name == "") {
      return '';
    }
    return 'assets/images/zr/road_icon/$name.png';
  }

  /// 根据解析的路纸信息拼接列表数据
  List<List<Map<String, dynamic>>> getCanvasList(dataList, newRoadPaperList) {
    List<List<Map<String, dynamic>>> list = [];

    //将最大列数逻辑改为，两个列表的最大数
    MaxRow = max(dataList.length, newRoadPaperList.length);

    for (int i = 0; i < MaxRow; i++) {
      List<Map<String, dynamic>> listRow = [];
      var rowDataArr = i < dataList.length ? dataList[i] : null;
      var newRowDataArr =
          i < newRoadPaperList.length ? newRoadPaperList[i] : null;
      for (int j = 0; j < colNum; j++) {
        var imgSrc = '';
        var newImgSrc = '';
        var name1 = '';
        var name2 = '';
        if (rowDataArr is List && rowDataArr[j] != null) {
          name1 = rowDataArr[j];
          imgSrc = getRoadIcon(rowDataArr[j]);
        }
        if (newRowDataArr is List && newRowDataArr[j] != null) {
          name2 = newRowDataArr[j];
          newImgSrc = getRoadIcon(newRowDataArr[j]);
        }
        listRow.add({
          'name': '$name1$name2',
          'imgSrc': imgSrc,
          'newImgSrc': newImgSrc,
        });
      }

      list.add(listRow);
    }
    return list;
  }

  /// 获取大对子路纸,返回路纸信息
  getBigPairRoadData(type, ZrListRoadPaper? roadPaperData,
      {roadType = RoadPaperType.BIG_PAIR_ROAD}) {
    BaccaratRoadInfo resInfo = BaccaratRoadInfo();
    resInfo.roadPaperType = roadType ?? RoadPaperType.BIG_PAIR_ROAD;
    var gameTypeId = GameType.BACCARAT;
    if (roadPaperData == null) {
      return resInfo;
    }

    resInfo = RoadPaperHelper.parseBaccaratSingleBootRoadPaper(resInfo,
        gameType: gameTypeId,
        content: type == 'bigPairRoad'
            ? roadPaperData.bigPairRoad
            : (type == 'newBigPairRoad' ? roadPaperData.newBigPairRoad : ''));
    return resInfo;
  }

  /// 路纸信息列表
  roadDataList(ZrListRoadPaper roadPaperData) {
    BaccaratRoadInfo resInfo = getBigPairRoadData('bigPairRoad', roadPaperData);
    BaccaratRoadInfo newResInfo = getBigPairRoadData(
        'newBigPairRoad', roadPaperData,
        roadType: RoadPaperType.ZHISHA);

    List<dynamic> roadPaperList = resInfo.roadList ?? [];
    List<dynamic> newRoadPaperList = newResInfo.roadList ?? [];

    return getCanvasList(roadPaperList, newRoadPaperList);
  }

  ///12秒无数据返回，显示暂无数据
  void doudi() {
    12.seconds.delay(() {
      if (state.isLoading == true) {
        state.isLoading = false;
        update();
      }
    });
  }
}
