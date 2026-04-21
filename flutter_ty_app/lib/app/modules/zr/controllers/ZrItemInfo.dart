import 'package:flutter_ty_app/app/services/models/res/zr_list_entity.dart';


///
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-18253eb3-5a09-49ef-95c2-d1a3f865fd27-zr 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人列表-解析后组装的实体类】】】
    【【【 AUTOMATIC_GENERATE_DOCUMENT_PARAGRAPH_CONTENT
    - 真人列表-解析后组装的实体类
    】】】
 *
 */
class ZrItemInfo {
  ///游戏状态
  String? gameStatus;
  ///在线人数
  String? onlineNumberImg;
  ///庄数量
  int? zhuangNum;
  ///闲数量
  int? xianNum;
  ///和数量
  int? heNum;
  ///庄对 数量
  int? zhuangduiNum;
  ///闲对 数量
  int? xianduiNum;
  ///路纸类型数据
  List<String>? roadPaperTypeImg;
  ///游戏类型
  String? gameTypeImg;
  ///国家图
  String? flagImgSrc;
  String? zhuangImg;
  String? xianImg;
  String? heImg;
  Map<String, dynamic>? statuInfo;
  ///台桌名字
  String? tableName;
  ///路纸数据，圈圈
  List<List<Map<String, dynamic>>>? mRoadList;

  ///源数据
  ZrListEntity? originData;


}
