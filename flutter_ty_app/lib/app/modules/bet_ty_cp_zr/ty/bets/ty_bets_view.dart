import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/booking/booking_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/booking/booking_bets_view.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/settled/settled_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/settled/settled_bets_view.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/ty_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/unsettled/unsettled_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/unsettled/unsettled_bets_view.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../../main.dart';
import '../../../../utils/oss_util.dart';
import '../../../login/login_head_import.dart';

class TyBetsWidget extends StatefulWidget {
  const TyBetsWidget({super.key});

  @override
  State<TyBetsWidget> createState() => _TyBetsPageWidget();
}

class _TyBetsPageWidget extends State<TyBetsWidget> {
  final logic = Get.find<TyBetsLogic>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(
        45.w,
        isIPad ? 120.h : 50.h,
        45.w,
        0.h,
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
      content: _body(),
    );
  }

  ///关闭按钮
  Widget _buildCloseButton() {
    return InkWell(
      onTap: () {
        Get.delete<UnsettledBetsLogic>();
        Get.delete<BookingBetsLogic>();
        Get.delete<SettledBetsLogic>();
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
                  : Colors.white.withValues(alpha: 0.30000001192092896),
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
    return GetBuilder<TyBetsLogic>(
      builder: (logic) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          child: Container(
            width: 600.w,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///已结算 未结算 预约中
                  _title(),
                  //列表
                  _contentBetsView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //导航部分
  Widget _title() {
    List<double> radiusList = getRadiusList();
    return SizedBox(
      height: 40.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///已结算 未结算 预约中
          _state(context, 0, LocaleKeys.bet_record_no_account.tr, radiusList[0],
              radiusList[1], radiusList[2], radiusList[3]),
          _state(context, 1, LocaleKeys.bet_record_account.tr, radiusList[4],
              radiusList[5], radiusList[6], radiusList[7]),
          _state(context, 2, LocaleKeys.app_book_bet.tr, radiusList[8],
              radiusList[9], radiusList[10], radiusList[11]),
        ],
      ),
    );
  }

  ///按钮角度
  List<double> getRadiusList() {
    if (logic.state.type == 0) {
      return [16, 16, 0, 0, 0, 0, 16, 0, 0, 16, 0, 0];
    } else if (logic.state.type == 1) {
      return [16, 0, 0, 16, 16, 16, 0, 0, 0, 16, 16, 0];
    } else if (logic.state.type == 2) {
      return [16, 0, 0, 0, 0, 0, 0, 16, 16, 16, 0, 0];
    }
    return [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  }

  //头部切换Widget
  Widget _state(BuildContext context, int type, String name, double topLeft,
      double topRight, double bottomLeft, double bottomRight) {
    bool Selected = (logic.state.type == type);
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          logic.setType(type);
        },
        child: Container(
          color: Selected
              ? context.isDarkMode
                  ? null
                  : const Color(0xFFE4E6ED)
              : null,
          child: Container(
            decoration: ShapeDecoration(
              color: context.isDarkMode
                  ? Selected
                      ? null
                      : const Color(0xFF1E2029)
                  : Color(Selected ? 0xFFF2F2F6 : 0xFFE4E6ED),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topLeft),
                  topRight: Radius.circular(topRight),
                  bottomLeft: Radius.circular(bottomLeft),
                  bottomRight: Radius.circular(bottomRight),
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14.5.sp,
                fontFamily: 'PingFang SC',
                fontWeight: Selected ? FontWeight.w600 : FontWeight.w400,
                color: Selected
                    ? context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.8999999761581421)
                        : const Color(0xFF303442)
                    : context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.4000000059604645)
                        : const Color(0xff949AB6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  ///内容视图
  Widget _contentBetsView() {
    Widget item = Container();

    ///未结算
    if (logic.state.type == 0) {
      Get.delete<BookingBetsLogic>();
      Get.delete<SettledBetsLogic>();
      Get.lazyPut(
        () => UnsettledBetsLogic(),
      );
      item = UnsettledBetsPage();

      ///已结算
    } else if (logic.state.type == 1) {
      Get.delete<UnsettledBetsLogic>();
      Get.delete<BookingBetsLogic>();
      Get.lazyPut(
        () => SettledBetsLogic(),
      );
      item = SettledBetsPage();

      ///预约注单
    } else if (logic.state.type == 2) {
      Get.delete<UnsettledBetsLogic>();
      Get.delete<SettledBetsLogic>();
      Get.lazyPut(
        () => BookingBetsLogic(),
      );
      item = BookingBetsPage();
    }
    return item;
  }

  @override
  void dispose() {
    Get.delete<TyBetsLogic>();
    Get.delete<BookingBetsLogic>();
    Get.delete<SettledBetsLogic>();
    Get.delete<UnsettledBetsLogic>();
    super.dispose();
  }
}
