import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/zr/settled_zr_bets_logic.dart';
import 'package:flutter_ty_app/app/utils/text_Utitl.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../../main.dart';
import '../../../../services/models/res/get_order_list_zr_entity.dart';
import '../../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-bd58c8a0-e850-406d-82ea-e9d19c8f5403-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人注单历史回放UI页面 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    # `zrBetsLiveHistory` 组件

    ## 概述
    - **类型**: StatefulWidget
    - **功能**: 显示真人注单历史回放，包括视频播放和下注记录。

    ## 属性
    - `GetOrderListZrDataList itemData`: 注单数据。
    - `SettledZrBetsLogic logic`: 处理逻辑。

    ## 状态管理
    ### `_zrBetsLiveHistoryState`
    - **变量**:
    - `List<String> bankerList`: 庄家下注列表。
    - `List<String> playerList`: 玩家下注列表。
    - `FijkPlayer player`: 视频播放器实例。
    - `bool isIPad`: 判断是否为iPad。

    ### 生命周期方法
    - `initState()`:
    - 初始化变量。
    - 根据`itemData`的`roundResult`设置`bankerList`和`playerList`。

    - `dispose()`:
    - 释放播放器和WebView资源。

    ## UI构建
    ### `build(BuildContext context)`
    - **主要布局**: 使用`Scaffold`和`Center`进行布局。
    - **标题**: 显示视频回放标题和返回按钮。
    - **视频播放**: 使用`InAppWebView`展示视频。
    - **下注信息**: 显示下注单号、庄家和玩家的下注记录。
    - **结果显示**: 根据`roundResult2`显示分数和赢家信息。

    ## 关键功能
    - **视频播放**: 加载视频并处理权限请求。
    - **下注记录展示**: 动态渲染玩家和庄家的下注图标。
    - **国际化支持**: 使用`LocaleKeys`进行文本国际化处理。

    】】】
 *
 */

///真人注单历史回放
class zrBetsLiveHistory extends StatefulWidget {
  final GetOrderListZrDataList itemData;
  final SettledZrBetsLogic logic;

  const zrBetsLiveHistory(
      {super.key, required this.itemData, required this.logic});

  @override
  State<zrBetsLiveHistory> createState() => _zrBetsLiveHistoryState();
}

class _zrBetsLiveHistoryState extends State<zrBetsLiveHistory> {
  List<String> bankerList = [];
  List<String> playerList = [];

  // final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          ///分类
          if (widget.itemData.roundResult.isNotEmpty) {
            bankerList = widget.logic
                .getHand(widget.itemData.roundResult, "banker");
            playerList = widget.logic
                .getHand(widget.itemData.roundResult, "player");
          }
        });

        /*      ///如果是安卓 直接播放视频
        if (Platform.isAndroid) {
          AppLogger.debug("value.data2:${widgets.logic.roundVideoData.first.videoPath}");
          player.setDataSource(
              widgets.logic.roundVideoData.isNotEmpty
                  ? widgets.logic.roundVideoData.first.videoPath
                  : "",
              autoPlay: false );
        }*/
      }
    });
  }

  late InAppWebViewController inappwebviewcontroller;

  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: false,
      mediaPlaybackRequiresUserGesture: true,
      allowsInlineMediaPlayback: false,
      iframeAllow: "camera; microphone",
      underPageBackgroundColor: Colors.black,
      forceDark: ForceDark.ON,
      iframeAllowFullscreen: false);

  @override
  void dispose() {
    ///关闭播放器
    InAppWebViewController.clearAllCache();
    inappwebviewcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///视频回放
                Text(
                  LocaleKeys.zr_cp_Lottery_Bet_Slips_video_recording.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //返回
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (!Platform.isIOS) {
                      // player.stop();
                    } else {
                      InAppWebViewController.clearAllCache();

                      inappwebviewcontroller.dispose();
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 28.h,
                        width: 28.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha:0.30000001192092896),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.close_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ).paddingOnly(left: 12.w, right: 12.w),

            ///不区分Android iOS播放器
            SizedBox(
              height: isIPad ? 350.h : 220.h,
              child: InAppWebView(
                initialSettings: settings,
                initialUrlRequest: URLRequest(
                    //Ios地址
                    url: WebUri(widget.logic.roundVideoData.isNotEmpty
                        ? widget.logic.roundVideoData.first.videoPath
                        : "")),
                onWebViewCreated: (controller) {
                  inappwebviewcontroller = controller;
                },
                //申请权限
                onPermissionRequest: (controller, request) async {
                  return PermissionResponse(
                      resources: request.resources,
                      action: PermissionResponseAction.GRANT);
                },
                onConsoleMessage: (controller, consoleMessage) {
                  if (kDebugMode) {
                    print(consoleMessage.message);
                  }
                },
                onCloseWindow: (InAppWebViewController controller) {
                  print("关闭窗口");
                },
                onLoadStop: (InAppWebViewController controller, WebUri? url) {},
              ),
            ).marginOnly(bottom: 60.h, top: 16.h),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
              decoration: ShapeDecoration(
                color: Colors.white.withValues(alpha:0.10000000149011612),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              //单号
              child: TextUtitls.normalText(
                  "${LocaleKeys.zr_cp_Lottery_Bet_Slips_game_number.tr}："
                  "${widget.itemData.roundNo}",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ).marginOnly(bottom: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 45.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: playerList.length,
                          shrinkWrap: true,

                          ///倒叙数据
                          reverse: true,
                          itemBuilder: (BuildContext context, int index) {
                            return playerList.length > 2
                                ? Row(
                                    children: [
                                      index == playerList.length - 1
                                          ? Transform.rotate(
                                              angle: 90 *
                                                  3.14159 /
                                                  180, // 逆时针旋转90度
                                              child: Container(
                                                  child: ImageView(
                                                "assets/images/bets/${playerList[playerList.length - 1]}.png",
                                                boxFit: BoxFit.contain,
                                                width: 27.w,
                                                height: 41.h,
                                              )))
                                          : Container(
                                              padding: EdgeInsets.only(
                                                  right: index != 0 ? 4.w : 0,
                                                  left: index ==
                                                          playerList.length - 2
                                                      ? 10.w
                                                      : 0),
                                              child: ImageView(
                                                "assets/images/bets/${playerList[index]}.png",
                                                boxFit: BoxFit.contain,
                                                width: 27.w,
                                                height: 41.h,
                                              ))
                                    ],
                                  )
                                : Container(

                                    /// 因为数据倒叙所以0索引在第一位
                                    padding: EdgeInsets.only(
                                        right: index != 0 ? 4.w : 0),
                                    child: ImageView(
                                      "assets/images/bets/${playerList[index]}.png",
                                      boxFit: BoxFit.contain,
                                      width: 27.w,
                                      height: 41.h,
                                    ));
                          }),
                    ).marginZero.marginOnly(bottom: 4.h),
                    if (widget.itemData.roundResult2.isNotEmpty)
                      TextUtitls.normalText(
                        widget.logic.getScore(
                            Get.locale!.toLanguageTag().contains('zh-CN') ||
                                    Get.locale!
                                        .toLanguageTag()
                                        .contains('zh-TW')
                                ? widget.itemData.roundResult2
                                : widget.itemData.roundResult2
                                        .replaceAll('庄', 'B')
                                        .replaceAll('闲', 'P'),
                            "player"),
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                  ],
                ),
                if (widget.itemData.roundResult2.isNotEmpty)
                  TextUtitls.normalText(
                    widget.logic.getWinner(widget.itemData.roundResult2),
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 45.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bankerList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return bankerList.length > 2
                                ? Row(
                                    children: [
                                      index == bankerList.length - 1
                                          ? Transform.rotate(
                                              angle: 90 *
                                                  3.14159 /
                                                  180, // 逆时针旋转90度
                                              child: Container(

                                                  /// 因为数据倒叙所以0索引在第一位
                                                  child: ImageView(
                                                "assets/images/bets/${bankerList[bankerList.length - 1]}.png",
                                                boxFit: BoxFit.contain,
                                                width: 27.w,
                                                height: 41.h,
                                              )))
                                          : Container(
                                              padding: EdgeInsets.only(
                                                  right: index ==
                                                          bankerList.length - 2
                                                      ? 10.w
                                                      : 4.w),
                                              child: ImageView(
                                                "assets/images/bets/${bankerList[index]}.png",
                                                boxFit: BoxFit.contain,
                                                width: 27.w,
                                                height: 41.h,
                                              ))
                                    ],
                                  )
                                : Container(
                                    padding: EdgeInsets.only(
                                        right: index != bankerList.length - 1
                                            ? 4.w
                                            : 0),
                                    child: ImageView(
                                      "assets/images/bets/${bankerList[index]}.png",
                                      boxFit: BoxFit.contain,
                                      width: 27.w,
                                      height: 41.h,
                                    ),
                                  );
                          }),
                    ).marginZero.marginOnly(bottom: 4.h),
                    if (widget.itemData.roundResult2.isNotEmpty)
                      TextUtitls.normalText(
                        widget.logic.getScore(
                            Get.locale!.toLanguageTag().contains('zh-CN') ||
                                    Get.locale!
                                        .toLanguageTag()
                                        .contains('zh-TW')
                                ? widget.itemData.roundResult2
                                : widget.itemData.roundResult2
                                        .replaceAll('庄', 'B')
                                        .replaceAll('闲', 'P'),
                            "banker"),
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
