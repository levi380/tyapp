import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../generated/locales.g.dart';
import '../../utils/ty_text_scaler.dart';
import 'token_expired_logic.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-79f99259-4a57-43da-8cf8-4bf260562931-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APPToken失效页面】】】
    【【【 AUTO_PARAGRAPH_TITLE APPToken失效页面 视图 TokenExpiredPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - APPToken失效页面 视图 TokenExpiredPage
    - TokenExpiredPage
    】】】
 *
 */
class TokenExpiredPage extends StatefulWidget {
  const TokenExpiredPage({Key? key}) : super(key: key);

  @override
  State<TokenExpiredPage> createState() => _TokenExpiredPageState();
}

class _TokenExpiredPageState extends State<TokenExpiredPage> {
  final logic = TokenExpiredLogic.to;
  final state = TokenExpiredLogic.to.state;

  @override
  Widget build(BuildContext context) {
    return oBContext != null
        ? Stack(
            children: [
              ImageView(
                state.imgKey,
                width: double.maxFinite,
              ),
              SafeArea(
                child: SizedBox(
                  height: 48.h,
                  child: Container(
                    margin: EdgeInsets.only(left: 14.w, right: 14.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => oBContext != null
                              ? Navigator.pop(oBContext!)
                              : Get.back(),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20.w,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          LocaleKeys.app_loginInvalid.tr.replaceAll(' ！', ''),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: TyTextScaler.instance().scale(16.sp),
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          width: 30.w,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        : ImageView(
            state.imgKey,
            width: double.maxFinite,
          );
  }

  @override
  void dispose() {
    Get.delete<TokenExpiredLogic>();
    super.dispose();
  }
}
