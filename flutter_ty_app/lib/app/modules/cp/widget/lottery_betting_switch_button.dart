
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';


class LotteryBettingSwitchButton extends StatelessWidget {
  const LotteryBettingSwitchButton({
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
      padding:  EdgeInsets.all(CpState.switchBtnPadding),
      constraints:  BoxConstraints(minHeight: CpState.switchBtnMinHeight),
      clipBehavior: Clip.antiAlias,
      decoration: context.isDarkMode
          ? ShapeDecoration(
              color: CpState.switchBtnBgColorDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    CpState.switchBtnBgImage,
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
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                            color: context.isDarkMode
                                ? CpState.switchBtnSelTextColorDark
                                : CpState.switchBtnSelTextColorLight,
                          )
                        : TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                            color: context.isDarkMode
                                ? CpState.switchBtnUnselTextColorDark
                                : CpState.switchBtnUnselTextColorLight,
                          ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: (isSelected && context.isDarkMode)
                          ? ShapeDecoration(
                              gradient: LinearGradient(
                                begin: const Alignment(0.00, -1.00),
                                end: const Alignment(0, 1),
                                colors: CpState.switchBtnSelGradientDark,
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
                                    colors: CpState.switchBtnSelGradientLight,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: CpState.switchBtnShadowColor,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                      spreadRadius: 0,
                                    )
                                  ],
                                )
                              : null,
                      width: width,
                      height: 24.h,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w500,height: 1.0),
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
