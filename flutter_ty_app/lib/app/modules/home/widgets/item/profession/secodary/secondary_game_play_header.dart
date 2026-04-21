import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart'; // 假设这是原来的路径
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/secodary/secodaryItemWidget.dart'; // 路径需对应
import '../../../../models/play_info.dart'; // 路径需对应
import '../../../../../../services/models/res/match_entity.dart'; // 路径需对应
import 'package:flutter_ty_app/generated/locales.g.dart'; // 假设这是国际化文件

/// 拆分出的头部组件：负责显示常规玩法的横向列表及“更多”弹窗
class SecondaryGamePlayHeader extends StatefulWidget {
  final MatchEntity match;
  final List<PlayInfo> plays;
  final PlayInfo currentPlayInfo;
  final bool isSelect;
  final bool isMoreSelect;

  /// 回调：当选中某个玩法时触发
  /// [playInfo] 选中的玩法
  /// [isSelect] 是否选中状态
  /// [isMoreSelect] 是否是更多菜单中的选项
  final Function(PlayInfo playInfo, bool isSelect, bool isMoreSelect) onPlaySelected;

  const SecondaryGamePlayHeader({
    Key? key,
    required this.match,
    required this.plays,
    required this.currentPlayInfo,
    required this.isSelect,
    required this.isMoreSelect,
    required this.onPlaySelected,
  }) : super(key: key);

  @override
  State<SecondaryGamePlayHeader> createState() => _SecondaryGamePlayHeaderState();
}

class _SecondaryGamePlayHeaderState extends State<SecondaryGamePlayHeader> {
  final ScrollController scrollController = ScrollController();
  final GlobalKey _menuItemKey = GlobalKey(); // 更多按钮的Key
  final GlobalKey _menuItemKey2 = GlobalKey(); // 列表容器的Key

  double x = 0;
  double y = 0;
  int moreleng = 5;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /// 显示更多玩法的弹窗 (逻辑保持不变)
  Future showMoreItem(BuildContext context, List<PlayInfo> plays, details) {
    List<PlayInfo> morePlays = plays.sublist(moreleng, plays.length);

    ///计算对应点击位置 弹窗
    final RenderBox button =
    _menuItemKey.currentContext!.findRenderObject() as RenderBox;
    var leftoffset = button.localToGlobal(Offset.zero);
    var topoffset = button.localToGlobal(Offset(0, button.size.height));

    return showMenu(
      constraints: const BoxConstraints(
          minHeight: 30, maxHeight: 100, minWidth: 70, maxWidth: 150),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      position: RelativeRect.fromLTRB(
          leftoffset.dx,
          topoffset.dy - 15.h - (25 * (morePlays.length + 1)),
          MediaQuery.of(context).size.width,
          0),
      items: List.generate(
          morePlays.length,
              (index) => PopupMenuItem(
            height: 25.h.scale,
            padding: EdgeInsets.only(left: 8.h),
            value: index,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textAlign: TextAlign.start,
                    morePlays[index].title,
                    style: TextStyle(
                      fontSize: 8.sp.scale,
                      fontWeight: FontWeight.w500,
                      color: widget.isMoreSelect &&
                          widget.currentPlayInfo.playId == morePlays[index].playId
                          ? (context.isDarkMode
                          ? Colors.white
                          : Colors.black)
                          : context.isDarkMode
                          ? const Color(0xffAFB3C8)
                          : Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Visibility(
                  visible: widget.isMoreSelect &&
                      widget.currentPlayInfo.playId == morePlays[index].playId,
                  child: Icon(
                    Icons.check,
                    size: 12,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          )),
      elevation: 5.0,
    ).then((value) async {
      // 处理选项菜单返回的值
      if (value != null) {
        // 回调给父组件处理业务逻辑
        widget.onPlaySelected(morePlays[value], false, true); // isSelect=false (被more覆盖), isMoreSelect=true
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    moreleng = 5;
    double headerHeight = widget.plays.isNotEmpty ? 28.h.scale : 0;

    // 注意：原代码中有 isIPad ? headerHeight : headerHeight，这里直接简化
    return Container(
      key: _menuItemKey2,
      height: headerHeight,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      margin: EdgeInsets.only(bottom: 6.h, top: 0.h),
      alignment: Alignment.centerLeft,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        ///去掉ios回弹效果
        physics: const ClampingScrollPhysics(),
        controller: scrollController,
        itemBuilder: (context, index) {
          //计算列表宽度
          final RenderBox? button =
          _menuItemKey2.currentContext?.findRenderObject() as RenderBox?;
          PlayInfo playInfo = widget.plays[index];

          return index < moreleng
              ? SecodaryItemWidget(
            title: widget.plays[index].title,
            isSelected: (playInfo.playId == widget.currentPlayInfo.playId && widget.isSelect),
            isHot: playInfo.playId == '1015',
            showEight: moreleng >= 8 && widget.match.csid == '2',
            onTap: () async {
              if (button != null && button.size.width > Get.width - 40) {
                double itemW = 80.w;
                scrollController.animateTo(
                  (index * itemW) - (Get.width - itemW) * 0.5,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }

              if (playInfo.playId != widget.currentPlayInfo.playId) {
                // 选中新玩法
                widget.onPlaySelected(playInfo, true, false); // isSelect=true, isMoreSelect=false
              } else {
                // 再次点击取消选中
                // 传递空对象，由父组件处理 "取消" 的逻辑
                // 这里 isSelect 传 !widget.isSelect 模拟原逻辑
                if (widget.isSelect) {
                  // 原逻辑：PlayInfo(title: '', playId: '', pids: '')
                  widget.onPlaySelected(
                      PlayInfo(title: '', playId: '', pids: ''),
                      false,
                      false
                  );
                } else {
                  // 理论上不会进这里，因为上面 !widget.isSelect 已经处理，保留逻辑完整性
                  widget.onPlaySelected(playInfo, true, false);
                }
              }
            },
          )
              : Container(
              key: _menuItemKey,
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              height: 28.h,
              child: InkWell(
                onTapDown: (details) {
                  x = details.globalPosition.dx;
                  y = details.globalPosition.dy;
                  showMoreItem(context, widget.plays, details.globalPosition);
                },
                child: Row(
                  children: [
                    if (widget.isMoreSelect == false)
                      Icon(
                        Icons.add,
                        size: 8.w,
                        color: const Color(0xffC9CDDB),
                      ),

                    ///更多玩法 切花语言 没有刷新模型  根据playid 重新获取国际化标题
                    Text(
                      widget.currentPlayInfo.title.isNotEmpty && widget.isMoreSelect
                          ? widget.plays
                          .where((PlayInfo info) {
                        return info.playId == widget.currentPlayInfo.playId;
                      })
                          .toList()
                          .first
                          .title
                          : LocaleKeys.app_more_play.tr,
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        fontSize: 10.sp.scale,
                        fontWeight: FontWeight.w500,
                        color: widget.isMoreSelect
                            ? const Color(0xff3AA6FC)
                            : context.isDarkMode
                            ? Colors.white.withValues(alpha: 0.9)
                            : const Color(0xff949AB6),
                      ),
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    if (widget.isMoreSelect)
                      Icon(
                        Icons.keyboard_arrow_up,
                        size: 10.w,
                        color: const Color(0xff3AA6FC),
                      ),
                  ],
                ),
              ));
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 4.w);
        },
        itemCount: widget.plays.length > moreleng ? moreleng + 1 : widget.plays.length,
      ),
    );
  }
}