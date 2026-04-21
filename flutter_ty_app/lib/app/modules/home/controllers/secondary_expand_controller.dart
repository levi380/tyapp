/// 子玩法管理

class SecondaryController {
  /// 子玩法存取
  static int index = 0; //子玩法翻页

  static Map<String, dynamic> map = {};

  /*
  是否翻页
  */
  static int setIndex(int indexs) {
    index = indexs;
    return index;
  }

  static void clearMap() {
    map.clear();
  }
}
