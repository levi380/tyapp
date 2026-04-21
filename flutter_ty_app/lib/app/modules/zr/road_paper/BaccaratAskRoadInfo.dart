
import 'package:flutter_ty_app/app/modules/zr/road_paper/BaseRoadInfo.dart';

class BaccaratAskRoadInfo extends BaseRoadInfo {
  /// 结果
  var _result = "";

  /// 设置结果
  set result(value) {
    _result = value;
  }

  /// 获取结果
  get result {
    return _result.substring(0,_result.length);
  }

  var _isBankerWin;

  set isBankerWin(value){
    _isBankerWin = value;
  }

  get isBankerWin{
    return _isBankerWin;
  }

  var _isPlayerWin;


  set isPlayerWin(value){
    _isPlayerWin = value;
  }

  get isPlayerWin{
    return _isPlayerWin;
  }

  // constructor() {
  //   super();
  // }
}