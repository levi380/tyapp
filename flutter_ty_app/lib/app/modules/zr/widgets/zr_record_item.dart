import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';

///每个路纸图的布局，圈圈,将方法抽成控件
class ZrRecordItem extends StatelessWidget {
  final int i;
  final List<Map<String, dynamic>> listRow;
  final int parentIndex;
  ZrRecordItem(
      {super.key,
      required this.i,
      required this.listRow,
      required this.parentIndex});

  var blockColor = ZrState.switchOffColor;
  var boxColor = Colors.transparent;
  var blockBorderWidth = ZrState.roadPaperBorderWidth;
  var blockSize = ZrState.roadPaperBlockSize;
  var iconSize = ZrState.roadPaperIconSize;

  @override
  Widget build(BuildContext context) {
    blockColor = context.isDarkMode
        ? ZrState.whiteAlpha008
        : ZrState.switchOffColor;
    Map<String, dynamic> map = listRow[i];

    return Container(
      width: blockSize,
      height: blockSize,
      color: boxColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: blockSize,
            height: blockBorderWidth,
            color: blockColor,
          ),
          Expanded(
            child: Row(
              children: [
                parentIndex == 0
                    ? Container(
                        width: blockBorderWidth,
                        height: blockSize,
                        color: blockColor,
                      )
                    : const SizedBox.shrink(),
                Expanded(
                  child:
                      /**每个路纸图由imgSrc和newImgSrc字段决定，叠加显示*/
                      Stack(
                    alignment: Alignment.center,
                    children: [
                      imageWidget(map['imgSrc']),
                      imageWidget(map['newImgSrc']),
                    ],
                  ),
                ),
                Container(
                  width: blockBorderWidth,
                  height: blockSize,
                  color: blockColor,
                ),
              ],
            ),
          ),
          i == listRow.length - 1
              ? Container(
                  width: blockSize,
                  height: blockBorderWidth,
                  color: blockColor,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  ///每个路纸图的布局，圈圈
  imageWidget(map) {
    return map == null || map == ""
        ? SizedBox(
            width: iconSize,
            height: iconSize,
          )
        : SizedBox(
            width: iconSize,
            height: iconSize,
            child: ImageView(
              map,
              width: iconSize,
              height: iconSize,
            ));
  }
}
