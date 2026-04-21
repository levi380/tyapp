import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-注单预约提前兑现键盘Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能注单预约提前兑现键盘
    - **数字键盘布局**：展示一个数字键盘，包括数字 `0-9`、小数点 `.` 和删除键 `*`。
    - **响应用户输入**：用户点击数字或功能键时，调用 `compute` 方法处理输入逻辑。
    - **动态样式**：根据当前主题（深色模式或浅色模式）调整键盘的颜色和样式。
    - `EarlyAppointmentSettlementKeyboardView`：接收一个 `data` 参数，类型为 `GetH5OrderListDataRecordxData`，用于存储和更新结算金额。
    - 构建键盘的 UI，包含多个行，每行显示三个按键。
    - 生成一行按键的布局。
    - 生成单个按键的布局，包括点击事件和样式设置。
    - 处理按键的逻辑，包括输入数字、小数点和删除操作。
    】】】
 *
 */
class EarlyAppointmentSettlementKeyboardView extends StatelessWidget {
  EarlyAppointmentSettlementKeyboardView({
    Key? key,
    required this.data,
  }) : super(key: key);

  final GetH5OrderListDataRecordxData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color:
            context.isDarkMode ? Colors.transparent : const Color(0xFFF3FAFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          _party('1', '2', '3', context).marginOnly(
            bottom: 4.h,
          ),
          _party('4', '5', '6', context).marginOnly(
            bottom: 4.h,
          ),
          _party('7', '8', '9', context).marginOnly(
            bottom: 4.h,
          ),
          _party('.', '0', '*', context),
        ],
      ),
    );
  }

  Widget _party(String keyboard1, String keyboard2, String keyboard3,
      BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _single(keyboard1, context),
        ),
        SizedBox(
          width: 4.h,
        ),
        Expanded(
          flex: 1,
          child: _single(keyboard2, context),
        ),
        SizedBox(
          width: 4.h,
        ),
        Expanded(
          flex: 1,
          child: _single(keyboard3, context),
        ),
      ],
    );
  }

  Widget _single(String keyboard, BuildContext context) {
    return InkWell(
      onTap: () => {
        compute(keyboard),
      },
      child: Container(
        alignment: Alignment.center,
        height: 36.h,
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 6.h,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.03999999910593033)
              : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            8.r,
          )),
        ),
        ///键盘按钮样式
        child: _content(keyboard, context),
      ),
    );
  }

  ///键盘按钮样式
  Widget _content(String keyboard, BuildContext context) {
    Widget widget = Container();
    if (keyboard == '*') {
      widget = ImageView(
        context.isDarkMode
            ? 'assets/images/bets/system_icon_cancel_night.png'
            : 'assets/images/bets/system_icon_cancel_daytime.png',
        width: 32.w,
        height: 23.h,
      );
    } else {
      widget = Text(
        keyboard,
        style: TextStyle(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.8999999761581421)
              : const Color(0xFF303442),
          fontSize: 22.sp,
          fontFamily: 'Akrobat',
          fontWeight: FontWeight.w800,
        ),
      );
    }
    return widget;
  }

  compute(String keyboard) {
    var amount = data.earlyAppointmentSettlementAmount.value;
    switch (keyboard) {
      case '.':
        if (amount.isNotEmpty && !amount.contains('.')) {
          data.earlyAppointmentSettlementAmount.value += keyboard;
        }
        break;

      ///删除
      case '*':
        if (amount.isNotEmpty && amount.length == 1) {
          data.earlyAppointmentSettlementAmount.value = '';
        } else if (amount.isNotEmpty) {
          data.earlyAppointmentSettlementAmount.value =
              amount.substring(0, amount.length - 1);
        }
        break;
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':

        ///限制输入的内容长度
        if (amount.isEmpty || amount.length < 14) {
          if (amount != '0') {
            if (!amount.contains('.')) {
              data.earlyAppointmentSettlementAmount.value += keyboard;
            } else {
              var split = amount.split('.')[1];
              if (split.isEmpty || split.length < 2) {
                data.earlyAppointmentSettlementAmount.value += keyboard;
              }
            }
          }
        }
      default:
        break;
    }
  }
}
