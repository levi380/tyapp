import 'package:flutter_ty_app/app/modules/zr/road_paper/BaseRoadInfo.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/RoadPaperCharacterMapping.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/common.dart';
import 'dart:math';
class BaccaratResultInfo extends BaseRoadInfo {
  // constructor() {
  //   super();
  // }

  /// 结果对象
  var _result;

  /// 和局数量
 var _tieNumber = 0;

  /// 对子索引
  /// 0无对，1闲对，2庄对，3庄闲对
  late int _pairIndex;

  /// 直杀 0没直杀 1直杀
  var _zhisha;

  /// 对子值 对子类型 0非庄闲对 1非庄对闲对 2庄对非闲对 3庄闲对
  var _pair;

  /// 是否龙宝
  var _isDragonBouns;

  /// 点数
  var _point;

  /// 是否是问路
  var _isAskRoad = false;

  /// 设置和局数量
  set tieNumber(value) {
    _tieNumber = value;
  }

  /// 获取和局数量
  get tieNumber {
    return _tieNumber;
  }


      /// 0 无对
      /// 1 闲对
      /// 2 庄对
      /// 3 庄闲对
  get pairIndex {
    return _pairIndex;
  }

  set pairIndex(value) {
    _pairIndex = value;
  }
  /// 直杀 0没直杀 1直杀
  get zhisha {
    return _zhisha;
  }

  set zhisha(value) {
    _zhisha = value;
  }

  /// 设置结果
  set result(value) {
    _result = value;
  }

  /// 获取结果
  get result {
    return _result;
  }

  /// 设置对子值
  set pair(pairValue) {
    _pair = pairValue;
  }

  /// 获取对子值
  get pair {
    return _pair;
  }

  /// 设置是否龙宝
  set isDragonBouns(value) {
    _isDragonBouns = value;
  }

  /// 获取是否龙宝
  get isDragonBouns {
    return _isDragonBouns;
  }

  /// 设置点数
  set point(value) {
    _point = value;
  }

  /// 获取点数
  get point {
    return _point;
  }

  var _isBig = false;
  /// 设置大小值
  set isBig(value) {
    _isBig = value;
  }

  /// 获取大小值
  get isBig {
    return _isBig;
  }

  /// 设置是否问路
  set isAskRoad(value) {
    _isAskRoad = value;
  }

  /// 获取是否问路
  get isAskRoad {
    return _isAskRoad;
  }

  /// 转成字符串
  toString() {
    switch (roadPaperType) {
      case RoadPaperType.MAIN_ROAD:
        return getMainRoadContent();
      case RoadPaperType.DRAG_BOUNS:
        return getDragonBounsRoad();
      case RoadPaperType.WIN_POINT:
        return getWinPointRoad();
      case RoadPaperType.BIG_SMALL:
        return getBigSmallRoad();
      case RoadPaperType.BIG_ROAD:
        return getBigRoad();
      case RoadPaperType.BIG_PAIR_ROAD:
        return getBigPairRoad();
      case RoadPaperType.BIG_PAIR_AND_SUPER_SIX_ROAD:
        return getBigPairAndSuperSixRoad();
      case RoadPaperType.BIG_EYE_ROAD:
        return getBigEyeRoad();
      case RoadPaperType.SMALL_ROAD:
        return getSmallRoad();
      case RoadPaperType.SMALL_Q_ROAD:
        return getSmallQRoad();
      case RoadPaperType.ZHISHA:
        return getZhishaRoad();
    }
    return "";
  }



  /// 庄闲珠盘路
  getMainRoadContent() {
    var result = "";
    switch (_result) {
      case BaccaratResult.BANKER_WIN:
        result = (gameType == 2006) ? RoadPaperCharacterMapping.mainRoadOtherList[0] : RoadPaperCharacterMapping.mainRoadBankerWin[pair];
        return result;
      case BaccaratResult.PLAYER_WIN:
        result = (gameType == 2006) ? RoadPaperCharacterMapping.mainRoadOtherList[1] : RoadPaperCharacterMapping.mainRoadPlayerWin[pair];
        return result;
      case BaccaratResult.BANKER_SIX:
        result = RoadPaperCharacterMapping.mainRoadBankerSix[pair];
        return result;
      case BaccaratResult.TIE:
        result = RoadPaperCharacterMapping.mainRoadTie[pair];
        return result;
      case BaccaratResult.DRAGON_WIN:
        result = RoadPaperCharacterMapping.mainRoadOtherList[2];
        return result;
      case BaccaratResult.TIGER_WIN:
        result = RoadPaperCharacterMapping.mainRoadOtherList[3];
        return result;
      case BaccaratResult.PHENIX_WIN:
        result = RoadPaperCharacterMapping.mainRoadOtherList[4];
        return result;
      case BaccaratResult.EMPTY:
        return result;
    }
    return result;
  }

  /// 龙宝珠盘路
  getDragonBounsRoad() {
    var result = "";
    switch (_result) {
      case BaccaratResult.BANKER_WIN:
        result = isDragonBouns ? RoadPaperCharacterMapping.dragonRoadBankerWinList[pair] : RoadPaperCharacterMapping.dragonRoadBankerWinList[pair + 4];
        return result;
      case BaccaratResult.BANKER_SIX:
        result = isDragonBouns ? RoadPaperCharacterMapping.dragonRoadBankerWinList[pair] : RoadPaperCharacterMapping.dragonRoadBankerSixList[pair];
        return result;
      case BaccaratResult.PLAYER_WIN:
        result = isDragonBouns ? RoadPaperCharacterMapping.dragonRoadPlayerWinList[pair] : RoadPaperCharacterMapping.dragonRoadPlayerWinList[pair + 4];
        return result;
      case BaccaratResult.TIE:
        result = RoadPaperCharacterMapping.dragonRoadPlayerTieList[pair];
        return result;
      case BaccaratResult.EMPTY:
        return result;
    }
    return result;
  }

  /// 点数珠盘路
  getWinPointRoad() {
    var result = "";
    switch (_result) {
      case BaccaratResult.BANKER_WIN:
      case BaccaratResult.BANKER_SIX:
        result = (pair == 0 && _isAskRoad) ? "庄" : RoadPaperCharacterMapping.winPointRoadBankerWinList[pair];
        return result.substring(point, 1);
      case BaccaratResult.PLAYER_WIN:
        result = (pair == 0 && _isAskRoad) ? "闲" : RoadPaperCharacterMapping.winPointRoadPlayerWinList[pair];
        return result.substring(point, 1);
      case BaccaratResult.TIE:
        result = RoadPaperCharacterMapping.winPointRoadTieList[pair];
        return result.substring(point, 1);
      case BaccaratResult.EMPTY:
        return result;
    }
    return result;
  }

  /// 大小珠盘路
  getBigSmallRoad() {
    if (_isAskRoad) {
      return _result == BaccaratResult.BANKER_WIN ? "庄" : "闲";
    }
    if (_isBig) {
      return RoadPaperCharacterMapping.bigSmallRoadBigList[pair];
    }
    return RoadPaperCharacterMapping.bigSmallRoadSmallList[pair];
  }


  /// 大路带对子以及超级6路纸
  getBigPairAndSuperSixRoad() {
    var result;
    var index = 0;
    var pairIndex = min(_pairIndex, 3);
    if (_result == BaccaratResult.BANKER_SIX || _result == BaccaratResult.BANKER_WIN) {
      result = _result == BaccaratResult.BANKER_SIX ? RoadPaperCharacterMapping.bigRoadBankerSixWin : RoadPaperCharacterMapping.bigRoadBankerWin;
      index = (tieNumber >= result.length) ? (result.length - 1) : tieNumber;
      if(!result[index]) {
        return "";
      }
      return result[index][pairIndex];
    } else {
      switch (_result) {
        case BaccaratResult.PLAYER_WIN:
          result = RoadPaperCharacterMapping.bigRoadPlayerWin;
          index = (tieNumber >= result.length) ? (result.length - 1) : tieNumber;
          if(!result[index]) {
            return "";
          }
          return result[index][pairIndex];
        case BaccaratResult.TIE:
          result = RoadPaperCharacterMapping.bigRoadTie;
          index = (tieNumber >= result.length) ? (result.length - 1) : tieNumber;
          if(!result[index]) {
            return "";
          }
          return result[index][pairIndex];
        case BaccaratResult.EMPTY:
          return RoadPaperCharacterMapping.getBacaratRoadPaperEmpty(0);
      }
    }
    return "";
  }

  /// 大路带对子路纸
  getBigPairRoad() {
    var result;
    var index = 0;
    var pairIndex = min(_pairIndex, 3);
    switch (_result) {
      case BaccaratResult.BANKER_SIX:
      case BaccaratResult.BANKER_WIN:
        result = RoadPaperCharacterMapping.bigRoadBankerWin;
        index = (tieNumber >= result.length) ? (result.length - 1) : tieNumber;
        if(result[index] == null) {
          return "";
        }
        return result[index][pairIndex];
      case BaccaratResult.PLAYER_WIN:
        result = RoadPaperCharacterMapping.bigRoadPlayerWin;
        index = (tieNumber >= result.length) ? (result.length - 1) : tieNumber;
        if(result[index] == null) {
          return "";
        }
        return result[index][pairIndex];
      case BaccaratResult.TIE:
        result = RoadPaperCharacterMapping.bigRoadTie;
        index = (tieNumber >= result.length) ? (result.length - 1) : tieNumber;
        if(result[index] == null) {
          return "";
        }
        return result[index][pairIndex];
      case BaccaratResult.EMPTY:
        return RoadPaperCharacterMapping.getBacaratRoadPaperEmpty(0);
    }
    return "";
  }
  /// 直杀
  getZhishaRoad() {
    var result;
    result = RoadPaperCharacterMapping.zhisha;
    if(zhisha == 1) {
      return result[1];
    }
    return result[0];
  }

  /// 大路
  getBigRoad() {
    var result;
    var index = 0;
    switch (_result) {
      case BaccaratResult.BANKER_SIX:
      case BaccaratResult.BANKER_WIN:
        result = RoadPaperCharacterMapping.bigRoadBankerWin;
        index = (tieNumber >= result.length) ? (result.length - 1) : tieNumber;
        if(!result[index]) {
          return "";
        }
        return result[index][0];
      case BaccaratResult.PLAYER_WIN:
        result = RoadPaperCharacterMapping.bigRoadPlayerWin;
        index = (tieNumber >= result.length) ? (result.length - 1) : tieNumber;
        if(!result[index]) {
          return "";
        }
        return result[index][0];
      case BaccaratResult.TIE:
        result = RoadPaperCharacterMapping.bigRoadTie;
        index = (tieNumber >= result.length) ? (result.length - 1) : tieNumber;
        if(!result[index]) {
          return "";
        }
        return result[index][0];
      case BaccaratResult.EMPTY:
        return RoadPaperCharacterMapping.getBacaratRoadPaperEmpty(0);
    }
    return "";
  }

  /// 大眼路
  getBigEyeRoad() {
    var result = "";
    switch (_result) {
      case BaccaratResult.BANKER_WIN:
        return RoadPaperCharacterMapping.bigEyeRoadList[0];
      case BaccaratResult.PLAYER_WIN:
        return RoadPaperCharacterMapping.bigEyeRoadList[1];
      case BaccaratResult.EMPTY:
        return RoadPaperCharacterMapping.getBacaratRoadPaperEmpty(1);
    }
    return result;
  }

  /// 小路
  getSmallRoad() {
    var result = "";
    switch (_result) {
      case BaccaratResult.BANKER_WIN:
        return RoadPaperCharacterMapping.smallRoadList[0];
      case BaccaratResult.PLAYER_WIN:
        return RoadPaperCharacterMapping.smallRoadList[1];
      case BaccaratResult.EMPTY:
        return RoadPaperCharacterMapping.getBacaratRoadPaperEmpty(1);
    }
    return result;
  }


  /// 小强路
  getSmallQRoad() {
    var result = "";
    switch (_result) {
      case BaccaratResult.BANKER_WIN:
        return RoadPaperCharacterMapping.smallQRoadList[0];
      case BaccaratResult.PLAYER_WIN:
        return RoadPaperCharacterMapping.smallQRoadList[1];
      case BaccaratResult.EMPTY:
        return RoadPaperCharacterMapping.getBacaratRoadPaperEmpty(1);
    }
    return result;
  }

}