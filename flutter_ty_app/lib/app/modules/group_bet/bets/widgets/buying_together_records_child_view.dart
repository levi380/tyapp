
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
class BuyingTogetherRecordsChildView extends StatelessWidget {
  BuyingTogetherRecordsChildView({
    Key? key,
  }) : super(key: key);


 // final managerCode = TYUserController.to.currCurrency();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Color(0xFFF3FAFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '投注单号',
                  style: TextStyle(
                    color: Color(0xFF303442),
                    fontSize: 12,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 16,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '17892222215651203',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF303442),
                            fontSize: 12,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                        ),
                        Container(
                          width: 14,
                          height: 14,
                          child: FlutterLogo(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).marginOnly(bottom: 6.h),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '投注时间',
                  style: TextStyle(
                    color: Color(0xFF303442),
                    fontSize: 12,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 17,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '2023-08-17 03:00',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF303442),
                            fontSize: 12,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '(香港盘)',
                          style: TextStyle(
                            color: Color(0xFF616783),
                            fontSize: 10,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).marginOnly(bottom: 6.h),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '投注额',
                  style: TextStyle(
                    color: Color(0xFF303442),
                    fontSize: 12,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '50.00元',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF303442),
                    fontSize: 12,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ).marginOnly(bottom: 6.h),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '可赢额',
                  style: TextStyle(
                    color: Color(0xFF179CFF),
                    fontSize: 12,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '50.00元',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF179CFF),
                    fontSize: 12,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
