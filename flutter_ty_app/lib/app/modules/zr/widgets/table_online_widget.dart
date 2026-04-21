import '../../../services/models/res/zr_list_entity.dart';
import '../../../utils/ty_text_scaler.dart';
import '../../login/login_head_import.dart';

class TableOnlineWidget extends StatelessWidget {
  ZrListEntity? bean;

  TableOnlineWidget({super.key, required ZrListEntity bean}) {
    this.bean = bean;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            child: ImageView(
          "assets/images/zr/ic_people.svg",
          width: 12.w,
          height: 12.w,
        )),
        Text(
          bean?.tableOnline.onlineNumber ?? "0",
          style: TextStyle(
            fontSize: TyTextScaler.instance().scale(10.sp),
            fontFamily: 'PingFang SC',
            color: Colors.white.withValues(
              alpha: 0.8,
            ),
          ),
        ),
      ],
    );
  }
}
