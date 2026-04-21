
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
///电竞-冠军专用赔率布局，冠军不用变赔逻辑
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞-冠军专用赔率布局，冠军不用变赔逻辑 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞-冠军专用赔率布局，冠军不用变赔逻辑
    】】】
 *
 */
class DJOddButton extends StatefulWidget {

  DJOddButton({super.key, required this.height, required this.width,required this.hps,required this.odd_item,required this.matchEntity});
  final double height;
  final double width;
  final MatchHps hps;
  final MatchHpsHlOl? odd_item;
  final MatchEntity matchEntity;
  @override
  State<DJOddButton> createState() => _DJOddButtonState();
}

class _DJOddButtonState extends State<DJOddButton> {
  int status = 0; // 10 升  -10降
  int oldOv = 0;
  @override
  void initState() {
    if (widget.odd_item != null) {
      oldOv = widget.odd_item!.ov;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  GetBuilder<DataStoreController>(
        id: OID + widget.odd_item!.oid,
        builder: (controller) {
          MatchHpsHlOl ol =
              DataStoreController.to.getOlById(widget.odd_item!.oid) ?? widget.odd_item!;
          oddsAnimate(ol);

          return Container(
              height: widget.height,
              width: widget.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:context.isDarkMode? Colors.white.withValues(alpha:0.03999999910593033): const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(4.w),
              ),
              child:buildHorizon()
          );
        });
  }


  Widget buildHorizon() {

    return Row(
      children: [
        SizedBox(width: 10.w),
      Expanded(
        child: Text(
          widget.odd_item!.on,
        
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10.sp.scale,
            color:context.isDarkMode? Colors.white.withValues(alpha:0.9): Colors.black,
          ),
          textAlign: TextAlign.left,
        ),
      ),
        SizedBox(width: 10.w),
      Text(
        formatNumber(widget.odd_item!.ov),
        style: TextStyle(
          fontSize: 12.sp.scale,
          color:context.isDarkMode? Colors.white.withValues(alpha:0.9): const Color(0xff303442),
          fontWeight: FontWeight.w700,
          fontFamily: 'DIN Alternate',
        ),
        textAlign: TextAlign.center,
      ),
        SizedBox(width: 10.w),
    ],);
  }




  void oddsAnimate(MatchHpsHlOl ol) {
    if (ol.ov != oldOv  &&  oldOv != 0) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          setState(() {
            if ((ol.ov / 1000).ceil() > (oldOv / 1000).ceil()) {
              status = 10;
              oldOv = ol.ov;
            } else if ((ol.ov / 1000).ceil() < (oldOv / 1000).ceil()) {
              status = -10;
              oldOv = ol.ov;
            } else {
              status = 0;
            }
          });
          3.seconds.delay(() {
            if (mounted) {
              // 三秒后清除相关符号
              setState(() {
                status = 0;
              });
            }
          });
        }
      });
    }
  }

  /// 只显示三位有效数字
  String formatNumber(int number) {
    double result = number / 100000;
    String resultStr;
      resultStr = result.toStringAsFixed(3);
    return resultStr;
  }

}
