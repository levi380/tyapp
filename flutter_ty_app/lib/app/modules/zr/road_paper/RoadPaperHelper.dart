import 'package:flutter_ty_app/app/modules/zr/road_paper/BaccaratAskRoadInfo.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/BaccaratResultInfo.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/BaccaratRoadInfo.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/RoadUtils.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/common.dart';

class RoadPaperHelper {
  /// 解析问路数据
  static final BaccaratAskRoadInfo _askRoadInfo = BaccaratAskRoadInfo();
  static parseAskRoadInfo(gameType, roadPaperType, roadUtils) {
    _askRoadInfo.row = roadUtils.getNextInteger(8); //庄问路行数
    _askRoadInfo.column = roadUtils.getNextInteger(8); //庄问路列数
    var flag = roadUtils.getNextInteger(1);
    _baccaratResultInfo.result = (flag == 1) ? BaccaratResult.BANKER_WIN : BaccaratResult.PLAYER_WIN;
    if (roadPaperType == RoadPaperType.MAIN_ROAD ||
        roadPaperType == RoadPaperType.DRAG_BOUNS ||
        roadPaperType == RoadPaperType.WIN_POINT) {
      ///外层已经把roadPaperType指定为 GameType.BACCARAT，所以该分支没调用
      // _askRoadInfo.result = getResult(gameType, roadPaperType, flag);//TODO 找不到方法
    } else {
      _askRoadInfo.result = _baccaratResultInfo.toString();
    }
    _askRoadInfo.isBankerWin = _baccaratResultInfo.result == BaccaratResult.BANKER_WIN;
    _askRoadInfo.isPlayerWin = _baccaratResultInfo.result == BaccaratResult.PLAYER_WIN;
    return _askRoadInfo;
  }

  /// 唯一对象一直复用 动态赋值 最后tostring
  static final BaccaratResultInfo _baccaratResultInfo = BaccaratResultInfo();
  /// 解析百家乐整靴路纸数据
  static parseBaccaratSingleBootRoadPaper(BaccaratRoadInfo baccaratRoadInfo, {gameType = 2001, content}) {
    baccaratRoadInfo.gameType = gameType;
    var roadPaperType = baccaratRoadInfo.roadPaperType;
    if (baccaratRoadInfo.content == content) {
      if (content == '') {
        baccaratRoadInfo.makeDefaultAskRoadInfo(gameType, roadPaperType);
      }
      return baccaratRoadInfo;
    }
    baccaratRoadInfo.content = content;
    if (content == '') {
      baccaratRoadInfo.makeDefaultAskRoadInfo(gameType, roadPaperType);
      return baccaratRoadInfo;
    }
    var roadUtils = RoadUtils(content);
    // var oldVersion = baccaratRoadInfo.version;
    baccaratRoadInfo.version = roadUtils.getNextInteger(8);

    var row = roadUtils.getNextInteger(8); //行数
    var col = roadUtils.getNextInteger(8); //列数
    var totalRound = row * col; //总局数
    var flag = 0;
    _baccaratResultInfo.gameType = gameType;
    _baccaratResultInfo.roadPaperType = roadPaperType;
    _baccaratResultInfo.isAskRoad = false;
    List<String>? list;
    while (totalRound > 0) {
      _baccaratResultInfo.result = BaccaratResult.EMPTY;
      _baccaratResultInfo.point = 0;
      _baccaratResultInfo.pair = 0;
      _baccaratResultInfo.isDragonBouns = false;
      _baccaratResultInfo.tieNumber = 0;
      _baccaratResultInfo.zhisha = 0;

      flag = roadUtils.getNextInteger(1);

      if (list == null || list.length >= 6) {
        list = [];
        baccaratRoadInfo.addColumn(list);
      }
      switch (roadPaperType) {
        case RoadPaperType.MAIN_ROAD:
          if (flag == 1) {
            _baccaratResultInfo.result = roadUtils.getNextInteger(2);
            if (gameType != GameType.WIN_THREE_CARDS) {
              _baccaratResultInfo.pair = roadUtils.getNextInteger(2);
            } else {
              var tempList = [BaccaratResult.DRAGON_WIN, BaccaratResult.PHENIX_WIN, BaccaratResult.TIE];
              _baccaratResultInfo.result = tempList[_baccaratResultInfo.result];
            }
          } else {
            (gameType != GameType.WIN_THREE_CARDS) ? roadUtils.getNextInteger(4) : roadUtils.getNextInteger(2);
          }
          break;
        case RoadPaperType.BIG_SMALL:
          //大小珠盘路
          if (flag == 1) {
            _baccaratResultInfo.isBig = roadUtils.getNextInteger(2) == 1;
            _baccaratResultInfo.result = roadUtils.getNextInteger(2);
            _baccaratResultInfo.pair = roadUtils.getNextInteger(2);
          } else {
            roadUtils.getNextInteger(6);
          }
          break;
        case RoadPaperType.DRAG_BOUNS:
          //龙宝珠盘路
          if (flag == 1) {
            //是否有龙宝
            _baccaratResultInfo.isDragonBouns = roadUtils.getNextInteger(1) == 1;
            _baccaratResultInfo.result = roadUtils.getNextInteger(2);
            _baccaratResultInfo.pair = roadUtils.getNextInteger(2);
          } else {
            roadUtils.getNextInteger(5);
          }
          break;
        case RoadPaperType.WIN_POINT:
          //点数珠盘路
          if (flag == 1) {
            _baccaratResultInfo.point = roadUtils.getNextInteger(4);
            _baccaratResultInfo.result = roadUtils.getNextInteger(2);
            _baccaratResultInfo.pair = roadUtils.getNextInteger(2);
          } else {
            roadUtils.getNextInteger(8);
          }
          break;
        case RoadPaperType.BIG_ROAD:
          //大路
          if (flag == 1) {
            _baccaratResultInfo.result = roadUtils.getNextInteger(2);
            _baccaratResultInfo.tieNumber = roadUtils.getNextInteger(4);
          } else {
            roadUtils.getNextInteger(6);
          }
          break;
        case RoadPaperType.BIG_PAIR_AND_SUPER_SIX_ROAD:
        case RoadPaperType.BIG_PAIR_ROAD:
          //大路带对
          if (flag == 1) {
            _baccaratResultInfo.result = roadUtils.getNextInteger(2);
            _baccaratResultInfo.tieNumber = roadUtils.getNextInteger(4);
            _baccaratResultInfo.pairIndex = roadUtils.getNextInteger(2);
          } else {
            roadUtils.getNextInteger(8);
          }
          break;
        case RoadPaperType.ZHISHA:
          //大路带对
          if (flag == 1) {
            _baccaratResultInfo.result = roadUtils.getNextInteger(2);
            _baccaratResultInfo.tieNumber = roadUtils.getNextInteger(4);
            _baccaratResultInfo.pairIndex = roadUtils.getNextInteger(2);
            _baccaratResultInfo.zhisha = roadUtils.getNextInteger(1);
          } else {
            roadUtils.getNextInteger(9);
          }
          break;
        case RoadPaperType.SMALL_ROAD:
        case RoadPaperType.BIG_EYE_ROAD:
        case RoadPaperType.SMALL_Q_ROAD:
          var resultValue = roadUtils.getNextInteger(1);
          _baccaratResultInfo.result = (flag == 1) ? resultValue : _baccaratResultInfo.result;
          break;
      }
      if (_baccaratResultInfo.result == BaccaratResult.EMPTY) {
        list.add("");
      } else {
        list.add(_baccaratResultInfo.toString());
      }
      totalRound--;
    }

    _baccaratResultInfo.result = BaccaratResult.EMPTY;
    _baccaratResultInfo.point = 0;
    _baccaratResultInfo.pair = 0;
    _baccaratResultInfo.isDragonBouns = false;
    _baccaratResultInfo.tieNumber = 0;
    _baccaratResultInfo.isAskRoad = true;
    _baccaratResultInfo.pairIndex = 0;
    _baccaratResultInfo.zhisha = 0;

    var askRoadInfo = parseAskRoadInfo(gameType, roadPaperType, roadUtils);
    //庄问路
    baccaratRoadInfo.bankerAskRoadColumn = askRoadInfo.column;
    baccaratRoadInfo.bankerAskRoadRow = askRoadInfo.row;
    baccaratRoadInfo.bankerAskRoadResult = askRoadInfo.result;
    baccaratRoadInfo.bankerAskRoadIsBankerWin = askRoadInfo.isBankerWin;
    baccaratRoadInfo.bankerAskRoadIsPlayerWin = askRoadInfo.isPlayerWin;

    //闲问路
    askRoadInfo = parseAskRoadInfo(gameType, roadPaperType, roadUtils);
    baccaratRoadInfo.playerAskRoadColumn = askRoadInfo.column;
    baccaratRoadInfo.playerAskRoadRow = askRoadInfo.row;
    baccaratRoadInfo.playerAskRoadResult = askRoadInfo.result;
    baccaratRoadInfo.playerAskRoadIsBankerWin = askRoadInfo.isBankerWin;
    baccaratRoadInfo.playerAskRoadIsPlayerWin = askRoadInfo.isPlayerWin;
    return baccaratRoadInfo;
  }


}
