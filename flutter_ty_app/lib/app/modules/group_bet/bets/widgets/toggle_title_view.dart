
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

class ToggleTitleView extends StatelessWidget {
  const ToggleTitleView({
    required this.type,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final int type;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _state(type, 0),
        SizedBox(width: 16.w),
        _state(type, 1),
      ],
    );
  }

  Widget _state(int type, int which) {
    bool selected = type == which;
    return InkWell(
      onTap: () => {
        onChanged(which),
      },
      child: Container(
        height: 40.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Text(
              which == 0 ? '我发起的' : '我参与的',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(selected ? 0xFF303442 : 0xFF7981A3),
                fontSize: 16.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              width: 64.w,
              height: selected ? 2.h : 1.h,
              decoration: ShapeDecoration(
                color: selected ? Color(0xFF179CFF) : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.r)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
