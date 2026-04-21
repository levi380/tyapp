import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/game/gameinit/draggable_icon.dart';
import 'package:filbet/src/game/gameinit/game_init_controller.dart';
import 'package:filbet/widgets/common_button.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:filbet/widgets/loadinng_view.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'guideOverlay.dart';
import 'package:filbet/services/user/user_service.dart';
import 'VenueSwitchSheet.dart';

class GameVenueOverlay extends StatefulWidget {
  const GameVenueOverlay({super.key});

  @override
  State<GameVenueOverlay> createState() => _GameVenueOverlayState();
}

class _GameVenueOverlayState extends State<GameVenueOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final curved = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim =
        Tween(begin: const Offset(0, -1), end: Offset.zero).animate(curved);
    _fadeAnim = Tween(begin: 0.0, end: 1.0).animate(curved);

    // 弹出时播放出现动画
    _animCtrl.forward();
  }

  /// 执行关闭动画
  Future<void> _dismiss() async {
    await _animCtrl.reverse(); // 播放关闭动画
    GameInitController.to.showGameVenue.value = false; // 再隐藏Widget
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Align(
            alignment: Alignment.topCenter,
            child:  Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffE6F1FE), Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: GameVenuePanel(
                      type: GameInitController.to.categoryType ??
                          CategoryType.video,
                      categories: GlobalService.to.state.allCategoryConfig,
                      onComplete: (type) {
                   //再隐藏Widget
                        GameInitController.to.onComplete(type);
                      },
                      platform_id: GameInitController.to.platform_id ?? "",
                      ongotogame: (venue, category) {
                      // 再隐藏Widget
                        GameInitController.to.ongotogame(venue, category);
                      },
                    ),
                  ),

                  // 底部关闭按钮（点击触发动画关闭）
                  Positioned(
                    bottom: -1,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _dismiss,
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          Assets.homeGameBottom,
                          width: 79,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        
      
    );
  }
}
