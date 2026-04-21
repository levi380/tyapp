import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';
import '../../../../main.dart';

///显示庄对，闲对数量布局，真人-荷官，路纸使用到
class TextRow extends StatelessWidget {
  final Color color;
  final String text;
  final int? count;

  TextRow(
      {super.key,
      required this.color,
      required this.text,
      required this.count});

  @override
  Widget build(BuildContext context) {
    String realText = text;
    if (realText.characters.length > 3) {
      realText = realText.characters.take(3).toString() + '...';
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: isIPad
              ? const BoxConstraints(maxWidth: double.infinity)
              : BoxConstraints(maxWidth: 35.w),
          child: Padding(
            padding: EdgeInsets.only(right: ZrState.space2),
            child: Text(
              realText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              style: TextStyle(
                fontSize: ZrState.font10,
                color: color,
              ),
            ),
          ),
        ),
        Text(
          "${count ?? 0}",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
          style: TextStyle(
              fontSize: ZrState.font10,
              color: context.isDarkMode
                  ? ZrState.whiteAlpha09
                  : ZrState.textColorPrimary),
        ),
      ],
    );
  }
}
