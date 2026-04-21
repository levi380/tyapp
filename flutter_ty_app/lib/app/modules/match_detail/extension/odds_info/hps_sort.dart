// 非置顶的玩法项冒泡排序
import '../../../../services/models/res/match_entity.dart';

List<MatchHps> listSortNormal(List<MatchHps> hpsList) {
  List<MatchHps> listNormal = [];
  for (var i = 0; i < hpsList.length; i++) {
    if (hpsList[i].hton == '0') {
      listNormal.add(hpsList[i]);
    }
  }
  if (listNormal.isNotEmpty) {
    var len = listNormal.length - 1;
    for (var i = 0; i < len; i++) {
      for (var k = 0; k < len - i; k++) {
        if (listNormal[k].hpon > listNormal[k + 1].hpon) {
          MatchHps t = listNormal[k];
          listNormal[k] = listNormal[k + 1];
          listNormal[k + 1] = t;
        }
      }
    }
  }
  return listNormal;
}

//  冒泡排序(原来地址顺序不发生变化---保持原来的顺序不变,返回新的列表但是子项使用原来的地址)
List<MatchHps> listSortNew(List<MatchHps> hpsList) {
  List<MatchHps> listTop = [];
  for (var i = 0; i < hpsList.length; i++) {
    if (hpsList[i].hton != "0") {
      listTop.add(hpsList[i]);
    }
  }
  if (listTop.isNotEmpty) {
    var len = listTop.length - 1;

    for (var i = 0; i < len; i++) {
      for (var k = 0; k < len - i; k++) {
        if ((int.tryParse(listTop[k].hton) ?? 0) <
            (int.tryParse(listTop[k + 1].hton) ?? 0)) {
          MatchHps t = listTop[k];
          listTop[k] = listTop[k + 1];
          listTop[k + 1] = t;
        }
      }
    }
  }
  return listTop;
}