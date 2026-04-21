
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/settled_cp_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/unsettled_records/unsettled_records_logic.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/unsettled_records/unsettled_records_view.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../main.dart';
import '../../../utils/oss_util.dart';
import '../../login/login_head_import.dart';
import 'additional_records/additional_records_logic.dart';
import 'additional_records/additional_records_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票注单主界面视图层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - GetBuilder控制视图最外层状态
    - 视图支持全屏，全屏不可设置.h .w
    - 主要是彩票注单投注视图
    】】】
 *
 */
class settledCpBetsPage extends StatefulWidget {
  final int settled;

  const settledCpBetsPage({super.key, required this.settled});

  @override
  State<settledCpBetsPage> createState() => _settledCpBetsPageState();
}

class _settledCpBetsPageState extends State<settledCpBetsPage> {
  final logic = Get.find<SettledCpBetsLogic>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(
        55.w,
        isIPad ? 120.h : 80.h,
        55.w,
        80.h,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        0,
      ),
      titlePadding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        0,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: _buildCloseButton(),
      //SingleChildScrollView

      content: _body(),
    );
  }

  ///关闭按钮
  Widget _buildCloseButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Row(
        children: [
          const Spacer(),
          Container(
            height: isIPad ? 30.w : 28.w,
            width: isIPad ? 30.w : 28.w,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white.withAlpha(85)
                  : Colors.white.withValues(alpha:0.30000001192092896),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: const Icon(
              Icons.close_outlined,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
      ),
    ).marginZero.marginOnly(bottom: 10.h);
  }

  Widget _body() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
      child: Container(
        width: 450.w,
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            image: context.isDarkMode
                ? DecorationImage(
                    image: NetworkImage(
                      OssUtil.getServerPath(
                        'assets/images/home/color_background_skin.png',
                      ),
                    ),
                    fit: BoxFit.cover,
                  )
                : null,
            color: context.isDarkMode
                ? const Color(0xFF1E2029)
                : const Color(0xFFF2F2F6),
            borderRadius: BorderRadius.all(
              Radius.circular(16.r),
            ),
          ),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _title(),
                GetBody(logic.type.value),
                // if (logic.type.value == 0) _unsettledRecordsView(),
                // if (logic.type.value == 1) _additionalRecordsView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget GetBody(int type) {
    if (type == 0) {
      return _unsettledRecordsView();
    } else if (type == 1) {
      return _additionalRecordsView();
    } else {
      return Container();
    }
  }

  ///彩票注单
  Widget _additionalRecordsView() {
    Get.delete<UnsettledRecordsLogic>();
    Get.lazyPut(
      () => AdditionalRecordsLogic(
        widget.settled,
      ),
    );
    return AdditionalRecordsView(
      settled: widget.settled,
    );
  }

  ///彩票追号记录
  Widget _unsettledRecordsView() {
    Get.delete<AdditionalRecordsLogic>();
    Get.lazyPut(
      () => UnsettledRecordsLogic(
        widget.settled,
      ),
    );
    return UnsettledRecordsView(
      settled: widget.settled,
    );
  }

  //导航部分
  Widget _title() {
    return SizedBox(
      height: 40.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //已结算 未结算
          _state(0, context),
          _state(1, context),
        ],
      ),
    );
  } //导航部分

  //头部切换Widget
  Widget _state(int type, BuildContext context) {
    AppLogger.debug("=========>${Get.locale?.languageCode}");

    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          ///如果是自定义时间特殊处理
          logic.setType(type);
        },
        child: Container(
          color: logic.type.value == type
              ? context.isDarkMode
                  ? null
                  : const Color(0xFFE4E6ED)
              : null,
          child: Container(
            decoration: logic.type.value == type
                ? BoxDecoration(
                    color: context.isDarkMode ? null : const Color(0xFFF2F2F6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  )
                : ShapeDecoration(
                    color: context.isDarkMode
                        ? const Color(0xFF1E2029)
                        : const Color(0xFFE4E6ED),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(type == 1 ? 12.r : 0.r),
                        bottomRight: Radius.circular(type == 0 ? 12.r : 0.r),
                      ),
                    )),
            alignment: Alignment.center,
            child: Text(
              type == 0
                  ? widget.settled == 0
                      ? LocaleKeys.zr_cp_bet_Window_unsettled_bets.tr
                      : LocaleKeys.zr_cp_bet_Window_settled_record.tr
                  : LocaleKeys.zr_cp_bet_Window_tracks.tr,
              style: TextStyle(
                fontSize: Get.locale?.languageCode == 'zh'
                    ? 13.sp
                    : (Get.locale?.languageCode == 'vi' ? 10.sp : 12.sp),
                fontWeight: logic.type.value == type
                    ? FontWeight.w600
                    : FontWeight.w400,
                height: 1,
                color: logic.type.value == type
                    ? context.isDarkMode
                        ? Colors.white.withValues(alpha:0.8999999761581421)
                        : const Color(0xFF303442)
                    : context.isDarkMode
                        ? Colors.white.withValues(alpha:0.4000000059604645)
                        : const Color(0xff949AB6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SettledCpBetsLogic>();
    super.dispose();
  }
}
