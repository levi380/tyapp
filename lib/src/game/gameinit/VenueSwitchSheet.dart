import 'package:filbet/api/api.dart';
import 'package:filbet/utils/app_config.dart';
import 'package:filbet/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/widgets/network_image.dart';

/// 顶部快捷操作类型
enum TopActionType {
  home, // 返回主页
  deposit, // 存款
  reload, // 重新加载
  support, // 专属客服
}

/// 封装一个 model，包含类型 + 显示文本 + 图标
class TopAction {
  final TopActionType type;
  final String label;
  final String icon;

  const TopAction({
    required this.type,
    required this.label,
    required this.icon,
  });
}

/// 快捷操作列表
final List<TopAction> topActions = [
  TopAction(
      type: TopActionType.home,
      label: "back_home".tr,
      icon: Assets.homeGameHome),
  TopAction(
      type: TopActionType.deposit,
      label: "deposit".tr,
      icon: Assets.homeGameQianbao),
  TopAction(
      type: TopActionType.reload,
      label: "reload".tr,
      icon: Assets.homeGameShuaxin),
  TopAction(
      type: TopActionType.support,
      label: "exclusive_service".tr,
      icon: Assets.homeGameKefu),
];

Future<void> showGameVenueDialog(
  BuildContext context,
  List<CategoryModel> categories, {
  Function(TopActionType)? onComplete,
  Function(VenueModel venue, CategoryModel category)? ongotogame,
  required CategoryType type,
  required String platform_id,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "Dismiss",
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      final curved = CurvedAnimation(parent: anim1, curve: Curves.easeOut);
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
            .animate(curved),
        child: Align(
          alignment: Alignment.topCenter,
          child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: const Color(0xffE6F1FE),

                      gradient: LinearGradient(
                        colors: [Color(0xffE6F1FE), Colors.white], // 渐变颜色
                        begin: Alignment.topCenter, // 渐变开始位置
                        end: Alignment.bottomCenter, // 渐变结束位置
                      ),
                      // color: Colors.red,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: GameVenuePanel(
                        type: type,
                        categories: categories,
                        onComplete: onComplete,
                        platform_id: platform_id,
                        ongotogame: ongotogame),
                  ),
                  Positioned(
                    bottom: -1,
                    right: 0,
                    left: 0,
                    // right: 12.w,
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        Assets.homeGameBottom,
                        width: 79,
                        height: 20,
                      ),
                    ).toBtn(
                      onTap: () {
                        // controller.showsheet();
                      },
                    ),
                  ),
                ],
              )),
        ),
      );
    },
  );
}

class GameVenuePanel extends StatefulWidget {
  final List<CategoryModel> categories;
  CategoryType type;
  String platform_id;
  Function(TopActionType)? onComplete;
  Function(VenueModel venue, CategoryModel category)? ongotogame;

  GameVenuePanel(
      {super.key,
      required this.categories,
      this.onComplete,
      this.ongotogame,
      required this.type,
      required this.platform_id});

  @override
  State<GameVenuePanel> createState() => _GameVenuePanelState();
}

class _GameVenuePanelState extends State<GameVenuePanel> {
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // 默认选中第一个分类
    if (widget.categories.isNotEmpty) {
      // _selectedCategory = widget.categories.first;

      final CategoryModel? found = widget.categories.firstWhere(
        (e) => e.id == widget.type.id,
        orElse: () => null as CategoryModel, // 👈 这招让返回值能是 null
      );

      _selectedCategory = found!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final venues = _selectedCategory?.venues ?? [];

    Language languagemodel = GlobalService.to.state.language;

    return SafeArea(
        bottom: false, // ⬅️ 关闭底部安全区
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 12.w, left: 12.w, right: 12.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTopActions(),
              SizedBox(height: 16.w),

              /// 切换游戏
              _SectionCard(
                isbottom: true,
                title: "switchGame".tr,
                children: [
                  Container(
                      // height: 12.w,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      padding: EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffF7F9FF),
                        borderRadius: BorderRadius.circular(8), // 四个角都圆角
                      ),
                      child: _GridWrap<CategoryModel>(
                        items: widget.categories,
                        ismaintained: (cat) =>
                            GlobalService.to.state.categoryStatus[cat.id] ==
                            false,
                        isSelected: (cat) => cat == _selectedCategory,
                        label: (cat) => cat.name ?? "",
                        image: (v) =>
                            Api.imageurl + "/game/type/${v.id}.webp" ?? "",
                        Selectedimage: (v) =>
                            Api.imageurl + "/game/type/${v.id}_light.webp" ??
                            "",
                        onTap: (cat) {
                          if (cat.id == _selectedCategory?.id) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = cat;
                          });
                          debugPrint("select_game_category"
                              .tr
                              .replaceAll("{{categoryName}}", cat.name ?? ""));
                        },
                      )),
                ],
              ),

              /// 切换场馆 (根据选择的分类变化)
              if (venues.isNotEmpty)
                _SectionCard(
                  isbottom: false,
                  title: "switchVenue".tr + "-${_selectedCategory?.name}",
                  children: [
                    Container(
                      // height: 12.w,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      padding: EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffF7F9FF),
                        borderRadius: BorderRadius.circular(8), // 四个角都圆角
                      ),

                      child: _GridWrap<VenueModel>(
                        items: venues,
                        isSelected: (v) => v.id == widget.platform_id,
                        label: (v) => v.name ?? "",
                        ismaintained: (v) => v.maintained == 2,
                        Selectedimage: (v) =>
                            Api.imageurl +
                                "/game/platform/h5/${languagemodel.code}/${v.id}_light.webp" ??
                            "",
                        image: (v) =>
                            Api.imageurl +
                                "/game/platform/h5/${languagemodel.code}/${v.id}.webp" ??
                            "",
                        onTap: (v) {
                          if (v.id == widget.platform_id) {
                            return;
                          }

                          widget.ongotogame?.call(v, _selectedCategory!);
                        },
                      ),
                    ),
                  ],
                ),

              SizedBox(height: 34.w),
            ],
          ),
        ));
  }

  Widget _buildTopActions() {
    List<TopAction> actions = topActions;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: actions
          .map((e) => InkWell(
              onTap: () {
                widget.onComplete?.call(e.type);
              },
              child: Container(
                width: 77.w,
                height: 77.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(e.icon), // 本地图片
                    fit: BoxFit.cover, // 填充方式（cover/contain/fill等）
                  ),
                ),
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      e.label,
                      style:
                          TextStyle(fontSize: 12.sp, color: Color(0xff3B5078)),
                    )
                  ],
                ),
              )))
          .toList(),
    );
  }
}

/// 区块卡片
class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  bool isbottom;

  _SectionCard(
      {required this.title, required this.children, required this.isbottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isbottom ? 13.w : 0),
      padding: EdgeInsets.only(top: 12.w, bottom: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 让高度自适应

        children: [
          Row(
            children: [
              Container(
                height: 19,
                width: 2,
                color: Color(0xff2986FB),
              ),
              SizedBox(
                width: 10,
              ),
              Text(title,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff3B5078),
                      fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          ...children,
        ],
      ),
    );
  }
}

/// 自适应网格
class _GridWrap<T> extends StatelessWidget {
  final List<T> items;
  final bool Function(T) isSelected;

  final bool Function(T) ismaintained;
  final String Function(T) label;
  final String Function(T) image;
  final String Function(T) Selectedimage;
  final void Function(T) onTap;

  const _GridWrap({
    required this.items,
    required this.isSelected,
    required this.label,
    required this.onTap,
    required this.image,
    required this.ismaintained,
    required this.Selectedimage,
  });

  @override
  Widget build(BuildContext context) {
    const crossAxisCount = 4;
    const double crossAxisSpacing = 20;
    const double mainAxisSpacing = 0;
    const double aspectRatio = 1; // 1:1 正方形

    return LayoutBuilder(
      builder: (context, constraints) {
        // 可用总宽度（父容器给到 Grid 的宽）
        final totalWidth = constraints.maxWidth;

        // 每个格子的“内容宽度”（要扣掉列间距）
        final cellWidth =
            (totalWidth - crossAxisSpacing * (crossAxisCount - 1)) /
                crossAxisCount;

        // 1:1 ⇒ 高度 = 宽度；若不是 1:1，用 cellWidth / aspectRatio
        final cellHeight = cellWidth / aspectRatio;

        // 行数
        final rows = (items.length / crossAxisCount).ceil();

        // Grid 实际需要的总高度 = 行高*行数 + 行间距*(行数-1)
        final gridHeight = cellHeight * rows + mainAxisSpacing * (rows - 1);

        return Container(
          height: gridHeight,
          color: Color(0xffF7F9FC),
          // 关键：把 GridView 高度钉死为实际需要的高度
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              childAspectRatio: aspectRatio, // 仍然 1:1
            ),
            itemBuilder: (_, i) {
              final item = items[i];
              final selected = isSelected(item);

              final maintained = ismaintained(item);
              return GestureDetector(
                onTap: () {
                  if (maintained == false) {
                    onTap(item);
                  }
                },
                child: Container(
                  // color: Colors.red,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // 或 .end 贴底
                    children: [
                      Container(
                          width: 36.w, // 用格子宽自适应
                          height: 36.w, // 保持方形
                          alignment: Alignment.center,
                          child: Stack(children: [
                            SKNetworkImage(
                              fit: BoxFit.cover,
                              width: 36.w,
                              // 用格子宽自适应
                              height: 36.w,
                              // 保持方形
                              imageUrl:
                                  selected ? Selectedimage(item) : image(item),
                              // borderRadius: 5.r,
                              placeholderType: 2,
                            ),
                            maintained == true
                                ? Positioned.fill(
                                    child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff000000).withOpacity(0.6),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        Assets.homeTMaintenance,
                                        width: 20.w,
                                        height: 20.w,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ))
                                : SizedBox.shrink()
                          ])),
                      Text(
                        label(item),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color:
                              selected ? Color(0xff239BFC) : Color(0xff79839D),
                          fontWeight:
                              selected ? FontWeight.w500 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
