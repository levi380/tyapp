
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-986a10e2-8038-4187-b36c-717a79579d9c-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  电竞赛果 GamingResultslogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  电竞赛果 GamingResultslogic
    - GamingResultslogic
    ```
    int dateIndex = 0;
    int typeFilterIndex = 0;

    String md = '';

    bool downloadData = false;
    bool noData = false;
    bool returnToFirst = false;
    bool isExpandAll = true;
    String typePicture = 'assets/images/detail/bg/esports_n.png';
    String euid = '100';
    String tid = '';

    RxBool loading = false.obs;

    /// 记录请求次数
    int requestCount = 0;

    /// 通知图片展示
    bool isIcon = false;
    /// 通知mid
    String mid = '';
    ```
    】】】
 *
 */
class GamingResultslogic {

  int dateIndex = 0;
  int typeFilterIndex = 0;

  String md = '';

  bool downloadData = false;
  bool noData = false;
  bool returnToFirst = false;
  bool isExpandAll = true;
  String typePicture = 'assets/images/detail/bg/esports_n.png';
  String euid = '100';
  String tid = '';

  RxBool loading = false.obs;

  /// 记录请求次数
  int requestCount = 0;

  /// 通知图片展示
  bool isIcon = false;
  /// 通知mid
  String mid = '';

  GamingResultslogic() {
    ///Initialize variables
  }
  // 国际化todo
  static Map nameMap = {
    '100':'英雄联盟',
    '101':'Dota2',
    '103':'王者荣耀',
    '102':'CS:GO/CS2',
    '105':'无畏契约',
  };
  static List<TypeModel> getMenu(){

    // todo 国际化
    List<TypeModel> list = [
      // TypeModel(LocaleKeys.app_lol.tr, 100,2100,'assets/images/detail/bg/details-LOL.jpg'), // 2100
      // TypeModel('Dota2', 101,2101,'assets/images/detail/bg/DOTA.jpg'), // 2101
      // TypeModel(LocaleKeys.sport2_103.tr, 103,2103,'assets/images/detail/bg/details-KPL.jpg'), // 2103
      // TypeModel('CS2', 102,2102,'assets/images/detail/bg/CS_GO.jpg'),

      TypeModel(LocaleKeys.app_lol.tr, 100,2100,'assets/images/detail/bg/esports.png'), // 2100
      TypeModel('Dota2', 101,2101,'assets/images/detail/bg/esports.png'), // 2101
      TypeModel(LocaleKeys.sport2_103.tr, 103,2103,'assets/images/detail/bg/esports.png'), // 2103
      TypeModel('CS2', 102,2102,'assets/images/detail/bg/esports.png'), // 2102
      TypeModel(LocaleKeys.new_menu_2105.tr, 105,2105,'assets/images/detail/bg/esports.png'), // 2102
    ];
    return list;
  }
}

class TypeModel {
  late String name;
  late int euid;
  late int miid;
  late String image;

  TypeModel(this.name,this.euid,this.miid,this.image);
}