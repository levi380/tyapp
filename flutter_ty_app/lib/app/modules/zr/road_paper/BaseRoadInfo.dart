
/**真人那边的代码，没有注释 */
class BaseRoadInfo {
  var _content;

  get content{
    return _content;
  }

  set content(value){
    _content = value;
  }

  /// 游戏类型
  var _gameType;
  /// 路纸类型
  int? _roadPaperType;

  /// 列数
  var _column = 0;
  /// 行数
 var _row = 0;
  /// 总局数
 var _version = 0;

  /// 设置游戏类型
  set gameType(value) {
    _gameType = value;
  }

  /// 获取游戏类型
  get gameType {
    return _gameType;
  }

  /// 设置路纸类型
  set roadPaperType(value) {
    _roadPaperType = value;
  }

  /// 获取路纸类型
  get roadPaperType {
    return _roadPaperType;
  }


  /// 设置列数
  set column(value) {
    _column = value;
  }

  /// 获取列数
  get column {
    return _column;
  }

  /// 设置行数
  set row(value) {
    _row = value;
  }

  /// 获取列数
  get row {
    return _row;
  }


  /// 获取总局数
  get version {
    return _version;
  }
  /// 设置总局数
  set version(value) {
    _version = value;
  }

  var _list =[];
  /// 给轮盘这种 三行路纸的解析用
  var _list3 = [];


  constructor() {

  }

  destroy() {

  }
  clear() {
    _list3 = [];
    _list = [];
    _list3 = [];
    version = 0;
    row = 0;
    column = 0;
    _content = "";
  }

  String toString1(int realColumn) {
    var emptyContent = "";
    var startIndex = 0;
    var addColumn = 0;
    if (_list.length < realColumn) {
      addColumn = realColumn - _list.length;
    } else {
      startIndex = _list.length - realColumn + 1;
      addColumn++;
    }
    var content = "";
    for (var j = 0; j < row; ++j) {
      for (var i = startIndex; i < _list.length + addColumn; ++i) {
        var tList = _list[i];
        content += (/*tList == undefined ||*/ tList == null) ? emptyContent : (!tList[j] ? emptyContent : tList[j]);
      }
      content += "\n";
    }
    return content;
  }

  toStringRow3(int realColumn) {
    var emptyContent = "";
    var startIndex = 0;
    var addColumn = 0;
    if (_list3.length < realColumn) {
      addColumn = realColumn - _list3.length;
    } else {
      startIndex = _list3.length - realColumn + 1;
      addColumn++;
    }
    var content = "";
    for (var j = 0; j < row; ++j) {
      for (var i = startIndex; i < _list3.length + addColumn; ++i) {
        var tList = _list3[i];
        content += (/*tList == undefined || */tList == null) ? emptyContent : (!tList[j] ? emptyContent : tList[j]);
      }
      content += "\n";
    }
    return content;
  }

  /// 下三行的路纸
  toStringSicbo3(int realColumn) {
    var emptyContent = "";
    var startIndex = 0;
    var addColumn = 0;
    if (_list.length < realColumn) {
      addColumn = realColumn - _list.length;
    } else {
      startIndex = _list.length - realColumn + 1;
      addColumn++;
    }
    var content = "";
    for (var j = 3; j < 6; ++j) {
      for (var i = startIndex; i < _list.length + addColumn; ++i) {
        var tList = _list[i];
        content += (/*tList == undefined || */tList == null) ? emptyContent : (!tList[j] ? emptyContent : tList[j]);
      }
      content += "\n";
    }
    return content;
  }
}
