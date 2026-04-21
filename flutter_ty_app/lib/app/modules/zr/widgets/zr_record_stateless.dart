import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/controllers/zr_controller.dart';
import 'package:flutter_ty_app/app/modules/zr/road_paper/common.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';
import 'package:flutter_ty_app/app/modules/zr/widgets/zr_record_item.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_setting_menu/zr_setting_menu_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_list_entity.dart';

///路纸布局
class ZrRecordLess extends StatelessWidget {
  ZrRecordLess(
      {super.key,
      required this.bean,
      this.blockSize = 14,
      this.mRoadList = const []});

  int allW = 100;
  int allH = 72;
  int colW = 12;
  int colH = 12;

  ZrListRoadPaper? roadPaperData;
  var gameTypeId = GameType.BACCARAT;
  final String roadPaperBgStyle = '';

  ZrListEntity? bean;
  List<List<Map<String, dynamic>>> mRoadList = [];

  initState() {
    roadPaperData = bean!.roadPaper;
  }

  var blockColor = Colors.transparent;
  // var blockColor = const Color(0xffE4E6ED);
  var boxColor = Colors.transparent;
  var blockBorderWidth = ZrState.roadPaperBorderWidth;
  var blockSize = ZrState.roadPaperBlockSize;
  var iconSize = ZrState.roadPaperIconSize;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ZrSettingMenuController());

    return GestureDetector(
      onTap: () {
        final zrController = Get.find<ZrController>();
        zrController.toGame(bean!.tableId);
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          ///获取路纸图控件在设备上占用的宽度
          var maxWidth = constraints.maxWidth;
          var columnCount = mRoadList.length + 2;

          ///求出路纸图最多显示的列数
          int maxLength = (maxWidth / blockSize - 0.5).round();
          if (maxLength > mRoadList.length) {
            ///如果最大显示列数大于数据源的长度，取最大显示列数
            ///否则取数据源长度+2
            columnCount = maxLength;
          }

          /// 如果数据长度大于页面显示面板长度，则加截掉前面的数据
          if (mRoadList.length > maxLength - 3) {
            int startIndex = (mRoadList.length - maxLength + 3).abs().toInt();
            mRoadList = mRoadList.sublist(startIndex, mRoadList.length);
          }
          return GetBuilder<ZrSettingMenuController>(builder: (controller) {
            blockColor = context.isDarkMode
                ? (controller.pathPaperMode == 2
                    ? ZrState.whiteAlpha008
                    : ZrState.switchOffColor)
                : ZrState.switchOffColor;
            boxColor = context.isDarkMode
                ? (controller.pathPaperMode == 2
                    ? Colors.transparent
                    : Colors.white)
                : Colors.white;

            if (bean == null) {
              return Container(color: boxColor);
            }

            return ListView.builder(
              itemCount: columnCount,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                ///mRoadList为List<List<Map<String, dynamic>>> 类型，对应路纸图的列和行
                if (index < mRoadList.length) {
                  List<Map<String, dynamic>> listRow = mRoadList[index];

                  return RepaintBoundary(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, i) {
                          ///将方法抽成控件
                          return ZrRecordItem(
                              i: i, listRow: listRow, parentIndex: index);
                        },
                        itemCount: listRow.length,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemExtent: blockSize),
                  );
                } else {
                  /// 剩余的为空格暂位符
                  List<Map<String, dynamic>> listRow = [{}, {}, {}, {}, {}, {}];
                  return RepaintBoundary(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, i) {
                          ///将方法抽成控件
                          return ZrRecordItem(
                              i: i, listRow: listRow, parentIndex: index);
                        },
                        itemCount: listRow.length,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemExtent: blockSize),
                  );
                }
              },
              itemExtent: blockSize,
            );
          });
        },
      ),
    );
  }
}
