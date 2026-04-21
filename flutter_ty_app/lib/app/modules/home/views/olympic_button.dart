
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/conif_controller_ext_s.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../main.dart';
import '../../../global/config_controller.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../../utils/systemchrome.dart';
import '../controllers/home_controller.dart';
import '../states/home_state.dart';

// 创建奥运会动画按钮
class OlympicAnimationButton extends StatefulWidget {
  const OlympicAnimationButton(this.context, {super.key});

  final BuildContext context;

  @override
  _OlympicAnimationButtonState createState() => _OlympicAnimationButtonState();
}

// 奥运会动画按钮的状态
class _OlympicAnimationButtonState extends State<OlympicAnimationButton>
    with SingleTickerProviderStateMixin {
  Animation<Offset>? animation;
  AnimationController? animationController;
  bool appThemeisDark = false;

  bool _isVisible = false;

  // 当依赖关系发生变化时调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppLogger.debug("OlympicAnimationButton = didChangeDependencies");
    animationController?.reverse();
  }

  // 释放资源
  @override
  void dispose() {
    AppLogger.debug("OlympicAnimationButton = dispose");
    animationController?.dispose();
    super.dispose();
  }

  // 初始化状态
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: HomeState.olympicAnimationDuration);
    animation = Tween(
            begin: const Offset(HomeState.olympicAnimationOffsetBegin, 0),
            end: const Offset(HomeState.olympicAnimationOffsetEnd, 0))
        .animate(animationController!);
    super.initState();
  }

  // 构建奥运会动画按钮
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SlideTransition(
                position: animation!,
                child: Container(
                  // color: Colors.red,
                  margin: EdgeInsets.only(
                      right:
                          _isVisible ? HomeState.olympicButtonMarginRight : 0),
                  height: HomeState.olympicButtonHeight,
                  width: HomeState.olympicButtonWidth,
                  child: Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          // animationController?.forward();
                          animationController?.reverse();
                          HomeState.olympicAnimationDuration.inMilliseconds
                              .milliseconds
                              .delay(() {
                            if (mounted) {
                              setState(() {
                                _isVisible = false;
                              });
                            }
                          });
                        },
                        child: SizedBox(
                          // color: Colors.yellow,
                          height: HomeState.olympicCloseButtonHeight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(child: Container()),
                              const ImageView(
                                HomeState.olympicCloseButtonAsset,
                                width: HomeState.olympicCloseButtonWidth,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          if (_isVisible) {
                            ///展开奥运会图标 点击跳转奥运会专题页
                            /// 68499 【SIT】【奥运会】【APP】常规选择夜间，进入专题页返回，自动变成日间模式
                            /// 1.保存当前app 风格模式
                            appThemeisDark = Get.isDarkMode;
                            olympicGamesSetting = true;
                            Get.toNamed(
                              Routes.olympicGames,
                              arguments: appThemeisDark,
                            );

                            String tag = Get.locale!.toLanguageTag();
                            String lang = tag.split('-')[0];
                            if (lang.contains('zh')) {
                              Get.updateLocale(const Locale('zh', 'CN'));
                              StringKV.language.save('CN');
                              await ConfigController.to
                                  .loadNameList(switchLanguages: true);
                              Bus.getInstance().emit(EventType.changeLang);
                            } else {
                              Get.updateLocale(const Locale('en', 'GB'));
                              StringKV.language.save('GB');
                              await ConfigController.to
                                  .loadNameList(switchLanguages: true);
                              Bus.getInstance().emit(EventType.changeLang);
                            }

                            /// 2.切换日间
                            Get.changeThemeMode(ThemeMode.light);
                            BoolKV.theme.save(Get.isDarkMode);
                            TyHomeController.to.homeState.isLight = true;
                            SystemUtils.isDarkMode(false);
                            TyHomeController.to.update();

                            setState(() {
                              _isVisible = false;
                              animationController?.reverse();
                            });
                          } else {
                            if (mounted) {
                              setState(() {
                                _isVisible = true;
                                // animationController?.reverse();
                                animationController?.forward();
                              });
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: !_isVisible ? 28 : 0),
                          width: 70,
                          height: 68,
                          child: ImageView(
                              boxFit: BoxFit.fitHeight,
                              _isVisible
                                  ? 'assets/images/home/olympicApear.png'
                                  : 'assets/images/home/olympicHide.png',
                              width: _isVisible ? 68 : 40),
                        ),
                      )
                    ],
                  ),
                )),
            const SizedBox(height: 100),
          ],
        ));
  }
}
