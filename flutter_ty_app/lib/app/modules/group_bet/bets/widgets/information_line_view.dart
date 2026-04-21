
import '../../../../../main.dart';
import '../../../login/login_head_import.dart';

class InformationLineView extends StatelessWidget {
  const InformationLineView({
    Key? key,
    required this.information,
    this.Type = 0,
    this.multiLine = true,
  }) : super(key: key);

  final String information;
  final int Type;
  final bool multiLine;

  @override
  Widget build(BuildContext context) {
    List<Color> listColor = [
       Color(0xFF303442),
       Color(0xFFAFB3C8),
    ];
    if (context.isDarkMode) {
      listColor[0] = Colors.white.withValues(alpha:0.8999999761581421);
      listColor[1] = Colors.white.withValues(alpha:0.30000001192092896);
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: multiLine
                ? Text(
                    information,
                    style: TextStyle(
                      color: listColor[Type],
                      fontSize: isIPad?14.sp:12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : Text(
                    information,
                    style: TextStyle(
                      color: listColor[Type],
                      fontSize: isIPad?14.sp:12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ],
      ),
    );
  }
}
