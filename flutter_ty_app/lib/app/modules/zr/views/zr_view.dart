import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';
import 'package:flutter_ty_app/app/modules/zr/views/zr_page_heguan.dart';
import 'package:flutter_ty_app/app/modules/zr/views/zr_page_jijian.dart';
import 'package:flutter_ty_app/app/modules/zr/views/zr_page_luzhi.dart';
import 'package:flutter_ty_app/app/modules/zr/views/zr_page_xianchang.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';
import 'package:flutter_ty_app/app/widgets/loading.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';

import '../controllers/zr_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-18253eb3-5a09-49ef-95c2-d1a3f865fd27-zr 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人列表-tabview内容分发】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人列表-tabview内容分发
    - loading页面
    - 数据为空的页面
    - 现场，荷官，路纸，极简控件
    】】】
 *
 */
class ZrView extends GetView<ZrController> {
  const ZrView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZrController>(
        init: ZrController(),
        builder: (logic) {
          return Column(
            children: [
              Expanded(child: dealListLogic(logic, context)),
            ],
          );
        });
  }

  ///处理数据和不同模块的转换
  dealListLogic(ZrController controller, BuildContext context) {
    if (controller.state.isLoading) {
      ///loading页面区分日间和夜间模式
      return Container(
          decoration: context.isDarkMode
              ? BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      OssUtil.getServerPath(
                        ZrState.zrLoadingBgAsset,
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                )
              : BoxDecoration(color: ZrState.bgColorLightAlt),
          child: const RepaintBoundary(child: Loading()));
    } else if (controller.state.processList.isEmpty) {
      return RepaintBoundary(
          child: NoData(
              content:
                  LocaleKeys.zr_cp_Lottery_Bet_Slips_no_games_available.tr));
    } else {
      if (controller.state.pageIndex == 0) {
        ///现场列表
        return ZrPageXianchang();
      } else if (controller.state.pageIndex == 1) {
        ///荷官列表
        return ZrPageHeGuan();
      } else if (controller.state.pageIndex == 2) {
        ///路纸列表
        return ZrPageLuZhi();
      } else if (controller.state.pageIndex == 3) {
        ///极简列表
        return ZrPageJiJian();
      }
    }
  }
}
