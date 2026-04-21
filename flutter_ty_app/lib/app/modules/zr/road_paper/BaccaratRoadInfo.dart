import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/BaseRoadInfo.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/RoadPaperCharacterMapping.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/common.dart';


/// 不要问我为什么不写注释，代码从真人那边拿来的，我也是改的。
class BaccaratRoadInfo extends BaseRoadInfo {
  var _bankerAskRoadColumn = 0;

  set bankerAskRoadColumn(value) {
    _bankerAskRoadColumn = value;
  }

  get bankerAskRoadColumn {
    return _bankerAskRoadColumn;
  }

  var _bankerAskRoadRow = 0;

  set bankerAskRoadRow(value) {
    _bankerAskRoadRow = value;
  }

  get bankerAskRoadRow {
    return _bankerAskRoadRow;
  }

  /// 庄问路结果
  var _bankerAskRoadResult = "";
  set bankerAskRoadResult(value) {
    _bankerAskRoadResult = value;
  }

  get bankerAskRoadResult {
    return _bankerAskRoadResult;
  }

  var _bankerAskRoadIsBankerWin = false;

  set bankerAskRoadIsBankerWin(value) {
    _bankerAskRoadIsBankerWin = value;
  }

  var _bankerAskRoadIsPlayerWin = false;

  set bankerAskRoadIsPlayerWin(value) {
    _bankerAskRoadIsPlayerWin = value;
  }

  get bankerAskRoadStatus {
    if (!_bankerAskRoadIsBankerWin && !_bankerAskRoadIsPlayerWin) return null;
    return _bankerAskRoadIsBankerWin;
  }

  var _playerAskRoadColumn = 0;

  set playerAskRoadColumn(value) {
    _playerAskRoadColumn = value;
  }

  get playerAskRoadColumn {
    return _playerAskRoadColumn;
  }

  var _playerAskRoadRow = 0;

  set playerAskRoadRow(value) {
    _playerAskRoadRow = value;
  }

  get playerAskRoadRow {
    return _playerAskRoadRow;
  }

  getColumeByIndex(index) {
    return _roadList[index];
  }

  /// 闲问路结果
  var _playerAskRoadResult = "";
  set playerAskRoadResult(value) {
    _playerAskRoadResult = value;
  }

  get playerAskRoadResult {
    return _playerAskRoadResult;
  }

  var _playerAskRoadIsBankerWin = false;
  var _playerAskRoadIsPlayerWin = false;

  set playerAskRoadIsBankerWin(value) {
    _playerAskRoadIsBankerWin = value;
  }

  set playerAskRoadIsPlayerWin(value) {
    _playerAskRoadIsPlayerWin = value;
  }

  get playerAskRoadStatus {
    if (!_playerAskRoadIsBankerWin && !_playerAskRoadIsPlayerWin) return null;
    return _playerAskRoadIsBankerWin;
  }

  set roadList(value) {
    _roadList = value;
  }

  get roadList {
    return _roadList;
  }

  /// 路纸列表
  var _roadList = [];

  get roadListColumn {
    return _roadList.length;
  }

  isHaveData() {
    return _roadList.isNotEmpty;
  }

  ///此方法是兜底的方法，从上层逻辑可知，content为空字符串时使用该方法，但是调用逻辑content是不为空的，所以该方法没有被调用
  ///由于前端中有该逻辑，所以暂时先保留
  makeDefaultAskRoadInfo(gameType, roadPaperType) {
    if (roadPaperType == RoadPaperType.MAIN_ROAD ||
        roadPaperType == RoadPaperType.BIG_SMALL ||
        roadPaperType == RoadPaperType.DRAG_BOUNS ||
        roadPaperType == RoadPaperType.WIN_POINT ||
        roadPaperType == RoadPaperType.BIG_ROAD ||
        roadPaperType == RoadPaperType.BIG_PAIR_ROAD ||
        roadPaperType == RoadPaperType.BIG_PAIR_AND_SUPER_SIX_ROAD) {
      bankerAskRoadColumn = bankerAskRoadRow = 0;
      playerAskRoadColumn = playerAskRoadRow = 0;
      AppLogger.debug("makeDefaultAskRoadInfo roadPaperType = $roadPaperType");
      if (roadPaperType == RoadPaperType.BIG_ROAD ||
          roadPaperType == RoadPaperType.BIG_PAIR_ROAD ||
          roadPaperType == RoadPaperType.BIG_PAIR_AND_SUPER_SIX_ROAD) {
        bankerAskRoadResult = RoadPaperCharacterMapping.bigRoadBankerWin[0][0];
        playerAskRoadResult = RoadPaperCharacterMapping.bigRoadPlayerWin[0][0];
      } else {
        AppLogger.debug("makeDefaultAskRoadInfo gameType = $gameType");
        // if (App.CommonUtils.isBaccaratGame(gameType)) {//TODO 沒找到
        ///外层已经把roadPaperType指定为 GameType.BACCARAT，所以只走这个分支
        if (true) {
          if (roadPaperType == RoadPaperType.MAIN_ROAD) {
            bankerAskRoadResult = RoadPaperCharacterMapping.baccaratAskRoad[0];
            playerAskRoadResult = RoadPaperCharacterMapping.baccaratAskRoad[1];
          } else {
            bankerAskRoadResult =
                RoadPaperCharacterMapping.baccaratDWAskRoad[0];
            playerAskRoadResult =
                RoadPaperCharacterMapping.baccaratDWAskRoad[1];
          }
        }
      }
    }
  }

  /// 添加一列
  addColumn(List<String> list) {
    _roadList.add(list);
  }

  ///根据下标获取元素
  getResultByIndex(xIndex, yIndex) {
    var list = _roadList[xIndex];
    if (list) return list[yIndex];
  }

  /// 添加单局结果
  addRoundResult(column, row, result) {
    int addNum = 0;
    if (_roadList.length <= column) {
      addNum = column - _roadList.length + 1;
      for (var i = 0; i < addNum; ++i) {
        _roadList.addAll([]);
      }
    }
    List<dynamic> list = _roadList[column]!;
    int count = (list.length);
    addNum = 6 - count;
    for (var i = 0; i < addNum; ++i) {
      list.add("");
    }
    if (row <= 5) {
      list[row] = result;
    }
    var isSame = true;
    for (var i = 0; i < list.length; ++i) {
      if (list[i] != "") {
        isSame = false;
        break;
      }
    }
    if (isSame) {
      _roadList.sublist(column, 1);
    }
  }

  /// 添加单局结果
  addSingleResult(singleRoundRoadInfo, {isOtherRoad = false}) {
    addRoundResult(singleRoundRoadInfo.column, singleRoundRoadInfo.row,
        singleRoundRoadInfo.result);

    bankerAskRoadColumn = singleRoundRoadInfo.bankerAskRoadInfo.column;
    bankerAskRoadRow = singleRoundRoadInfo.bankerAskRoadInfo.row;
    bankerAskRoadResult = singleRoundRoadInfo.bankerAskRoadInfo.result;
    _bankerAskRoadIsBankerWin =
        singleRoundRoadInfo.bankerAskRoadInfo.isBankerWin;
    _bankerAskRoadIsPlayerWin =
        singleRoundRoadInfo.bankerAskRoadInfo.isPlayerWin;

    playerAskRoadColumn = singleRoundRoadInfo.playerAskRoadInfo.column;
    playerAskRoadRow = singleRoundRoadInfo.playerAskRoadInfo.row;
    playerAskRoadResult = singleRoundRoadInfo.playerAskRoadInfo.result;
    _playerAskRoadIsBankerWin =
        singleRoundRoadInfo.playerAskRoadInfo.isBankerWin;
    _playerAskRoadIsPlayerWin =
        singleRoundRoadInfo.playerAskRoadInfo.isPlayerWin;

    var flag;
    if (!isOtherRoad) {
      flag = (singleRoundRoadInfo.version - version == 1) ||
          (!singleRoundRoadInfo.version && !version);
    } else {
      flag = (singleRoundRoadInfo.version > 1 && version == 0) ||
          (singleRoundRoadInfo.version - version == 1) ||
          (!singleRoundRoadInfo.version && !version);
    }
    if (!flag) return flag;
    version = singleRoundRoadInfo.version;
    return true;
  }

  /// 结果转string
  tostring(int viewColumn, {autoAddColumn = false}) {
    var emptyContent;
    if (roadPaperType == RoadPaperType.MAIN_ROAD ||
        roadPaperType == RoadPaperType.BIG_SMALL ||
        roadPaperType == RoadPaperType.DRAG_BOUNS ||
        roadPaperType == RoadPaperType.WIN_POINT) {
      emptyContent = "";
    } else if (roadPaperType == RoadPaperType.BIG_ROAD ||
        roadPaperType == RoadPaperType.BIG_PAIR_ROAD ||
        roadPaperType == RoadPaperType.BIG_PAIR_AND_SUPER_SIX_ROAD) {
      emptyContent = RoadPaperCharacterMapping.getBacaratRoadPaperEmpty(0);
    } else {
      emptyContent = RoadPaperCharacterMapping.getBacaratRoadPaperEmpty(1);
    }
    var startIndex = 0;
    var addColumn = 0;
    if (_roadList.length >= viewColumn) {
      startIndex = _roadList.length - viewColumn + 1;
      addColumn = 1;
    } else if (autoAddColumn) {
      addColumn = viewColumn - _roadList.length;
    }
    var content = "";
    for (var j = 0; j < 6; ++j) {
      for (var i = startIndex; i < _roadList.length + addColumn; ++i) {
        var tList = _roadList[i];
        content += (tList == null)
            ? emptyContent
            : ((tList[j] == null || tList[j] == "") ? emptyContent : tList[j]);
      }
      content += "\n";
    }
    return content;
  }

  /// 结果转string
  toAskRoadString(int viewColumn) {
    var emptyContent;
    if (roadPaperType == RoadPaperType.MAIN_ROAD ||
        roadPaperType == RoadPaperType.BIG_SMALL ||
        roadPaperType == RoadPaperType.DRAG_BOUNS ||
        roadPaperType == RoadPaperType.WIN_POINT) {
      emptyContent = "";
    } else if (roadPaperType == RoadPaperType.BIG_ROAD ||
        roadPaperType == RoadPaperType.BIG_PAIR_ROAD ||
        roadPaperType == RoadPaperType.BIG_PAIR_AND_SUPER_SIX_ROAD) {
      emptyContent = RoadPaperCharacterMapping.getBacaratRoadPaperEmpty(0);
    } else {
      emptyContent = RoadPaperCharacterMapping.getBacaratRoadPaperEmpty(1);
    }
    var startIndex = 0;
    if (_roadList.length >= viewColumn) {
      startIndex = _roadList.length - viewColumn;
    }
    var content = "";
    for (var j = 0; j < 6; ++j) {
      for (var i = startIndex; i < _roadList.length; ++i) {
        var tList = _roadList[i];
        content += (tList == null)
            ? emptyContent
            : ((tList[j] == null || tList[j] == "") ? emptyContent : tList[j]);
      }
      content += "\n";
    }
    return content;
  }

  clear() {
    super.clear();
    _roadList = [];
    column = 0;
    row = 0;
    version = 0;
    bankerAskRoadColumn = bankerAskRoadRow = 0;
    playerAskRoadColumn = playerAskRoadRow = 0;
    bankerAskRoadResult = playerAskRoadResult = "";
    _bankerAskRoadIsBankerWin = _bankerAskRoadIsPlayerWin = false;
    _playerAskRoadIsBankerWin = _playerAskRoadIsPlayerWin = false;
  }
}
