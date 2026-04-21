import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';

class LotteryBettingNomalButton extends StatelessWidget {
  const LotteryBettingNomalButton({
    Key? key,
    required this.childrenTitles,
    required this.selIndex,
    required this.onChanged,
  }) : super(key: key);

  final List<String> childrenTitles;
  final int selIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      constraints: const BoxConstraints(minHeight: 24),
      clipBehavior: Clip.antiAlias,
      decoration: context.isDarkMode
          ? ShapeDecoration(
              color: Colors.white.withValues(alpha:0.03999999910593033),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    'assets/images/home/switch_sports.png',
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final width = constraints.maxWidth / childrenTitles.length;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              childrenTitles.length,
              (index) {
                final title = childrenTitles[index];
                final bool isSelected = selIndex == index;
                return InkWell(
                  onTap: () {
                    onChanged(index);
                  },
                  child: DefaultTextStyle(
                    style: isSelected
                        ? TextStyle(
                            fontSize: 11,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                            color: context.isDarkMode
                                ? Colors.white.withValues(alpha:0.699999988079071)
                                : const Color(0xff303442),
                          )
                        : TextStyle(
                            fontSize: 11,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                            color: context.isDarkMode
                                ? Colors.white.withValues(alpha:0.30000001192092896)
                                : const Color(0xff7981A4),
                          ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: (isSelected && context.isDarkMode)
                          ? ShapeDecoration(
                              gradient: LinearGradient(
                                begin: const Alignment(0.00, -1.00),
                                end: const Alignment(0, 1),
                                colors: [
                                  Colors.white.withValues(alpha:0.05000000074505806),
                                  Colors.white.withValues(alpha:0.10000000149011612),
                                  Colors.white.withValues(alpha:0.029999999329447746)
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            )
                          : isSelected
                              ? ShapeDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [
                                      Colors.white,
                                      Color(0xFFEEF1F8),
                                      Color(0xFFF8FDFF)
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x337981A3),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                      spreadRadius: 0,
                                    )
                                  ],
                                )
                              : null,
                      width: width,
                      height: 24,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
