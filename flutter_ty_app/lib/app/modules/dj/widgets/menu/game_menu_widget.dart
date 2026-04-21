import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/global/conif_controller_ext_s.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/dj/states/dj_state.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import '../../../../global/config_controller_ext.dart';
import '../../../../utils/csid_util.dart';
import '../../../home/widgets/menu/menu_item.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-409e307b-dbbb-44b3-97fa-a03a45f3b225-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞头部 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞头部 顶部游戏按钮 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 顶部游戏按钮
    # `列表数据补偿角标数目

    ```
    if (controller.DJState.gameId == sportInfo.mi) {
    count = controller.DJState.djListEntity.length;
    AppLogger.debug("列表補償 count = "+count.toString());
    }
    ```
    】】】
 *
 */
class GameMenuWidget extends StatefulWidget {
  const GameMenuWidget(
      {super.key,
      required this.onValueChanged,
      required this.gameList,
      required this.gameId});

  final List<Game> gameList;
  final ValueChanged<String> onValueChanged;
  final String gameId;

  @override
  State<GameMenuWidget> createState() => _GameMenuWidgetState();
}

class _GameMenuWidgetState extends State<GameMenuWidget> {
  late Timer periodicTimer;

  ValueNotifier<List<SportConfigInfo>> sportMenuList = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    sportMenuList.value = DJController.to.getMenuData();
    periodicTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (Get.isRegistered<DJController>()) {
        sportMenuList.value = DJController.to.getMenuData();
      }
    });
  }

  @override
  void didUpdateWidget(GameMenuWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gameId != widget.gameId) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    periodicTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DJController>(builder: (controller) {
      sportMenuList.value = DJController.to.getMenuData();

      return ValueListenableBuilder(
          valueListenable: sportMenuList,
          builder: (context, value, child) {
            return Container(
              height: 50.h,
              alignment: Alignment.center,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: value.length,
                itemBuilder: (BuildContext context, int index) {
                  final sportInfo = value[index];
                  int position =
                      SpriteImagesPosition.data[(sportInfo.mi.toNum())] ?? 0;
                  if (sportInfo.mi ==
                      SportConfig.FavoritesPage.sportId.toString()) {
                    position = 1;
                  }
                  int? count = 0;
                  if (sportInfo.mi ==
                      SportConfig.FavoritesPage.sportId.toString()) {
                    position = 1;
                    count = CollectionController.to.collectionCountDJ;
                    // count = CollectionController.to.getDJCollectCount();
                  } else {
                    count = ConfigController.to.getCount(sportInfo.mi,
                        SportConfig.EsportsPage.sportId.toString());

                    // 刷新中的数据还是之前的，要等到刷新之后
                    if (controller.DJState.gameId == sportInfo.mi &&
                        !controller.DJState.isLoading) {
                      count = controller.DJState.tempList.length;
                      // 更新电竞菜单数量
                      ConfigController.to
                          .updateDjMenuCount(sportInfo.mi, count);
                    }
                  }

                  ///单个按钮控件
                  return MenuItem(
                    title: ConfigController.to.getName(sportInfo.mi),
                    index: position,
                    count: count,
                    isSelected: sportInfo.mi == widget.gameId,
                    onTap: () {
                      DJController.to.isSearch = false;
                      DJController.to.searchKeyWord = '';
                      widget.onValueChanged(sportInfo.mi);
                    },
                  );
                },
              ),
            );
          });
    });
  }
}
