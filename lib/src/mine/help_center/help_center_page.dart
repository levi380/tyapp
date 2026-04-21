import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/src/mine/help_center/help_center_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/utils/webview_ios_http_auth.dart'
    show tyWebViewRejectHttpAuth, tyWebViewSetNavigationDelegateForIosUnawaited;
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'dart:io';
import 'dart:developer';

class HelpCenterPage extends GetView<HelpCenterController> {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        canPop: controller.selectedCategoryIndex.value == -1 &&
            controller.selectedItemIndex.value == -1,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            controller.goBack();
          }
        },
        child: CustomScffold(
          showBgTexture: false,
          backgroundColor: appnewColors.bg15,
          appBar: _buildAppBar(),
          body: SafeArea(
            child: Obx(() {
              if (controller.selectedCategoryIndex.value == -1) {
                // 显示分类列表
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserGreeting(),
                      _buildHelpCategories(),
                      _buildHumanServiceTip(),
                    ],
                  ),
                );
              } else if (controller.selectedItemIndex.value == -1) {
                // 显示子项列表
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserGreeting(),
                      _buildCategoryItems(),
                      _buildHumanServiceTip(),
                    ],
                  ),
                );
              } else {
                // 显示详细内容 - 使用 Column 让 WebView 可以滚动
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserGreeting(),
                    Expanded(
                      child: _buildItemDetail(),
                    ),
                    _buildHumanServiceTip(),
                  ],
                );
              }
            }),
          ),
        ),
      );
    });
  }

  // 构建 AppBar
  PreferredSizeWidget _buildAppBar() {
    return _DynamicAppBar(controller: controller);
  }

  // 用户问候区域
  Widget _buildUserGreeting() {
    return Container(
      color: appnewColors.textWhite,
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      child: Column(
        children: [
          Row(
            children: [
              // 头像占位符
              Obx(() {
                return Container(
                  width: 60.r,
                  height: 60.r,
                  decoration: BoxDecoration(
                    color: appnewColors.bg2,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      UserService.to.state.avatarImgUrl,
                      width: 60.r,
                      height: 60.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
              SizedBox(width: 12.w),
              // 问候文字
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, 尊敬的会员用户',
                      style: TextStyle(
                        color: appnewColors.text1,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${controller.getTimeGreeting()},欢迎来到帮助中心',
                      style: TextStyle(
                        color: appnewColors.text1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // 分割线
          Container(
            height: 1,
            color: appnewColors.colorLine,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Text(
              '若相关问题仍未解决,可咨询在线客服',
              style: TextStyle(
                color: appnewColors.text38,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }

  // 帮助分类列表
  Widget _buildHelpCategories() {
    return Container(
      margin: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 0),
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: List.generate(
          controller.helpCategories.length,
          (index) {
            final category = controller.helpCategories[index];
            return _buildCategoryItem(category, index);
          },
        ),
      ),
    );
  }

  // 分类项
  Widget _buildCategoryItem(HelpCategory category, int index) {
    final isLast = index == controller.helpCategories.length - 1;
    return InkWell(
      onTap: () => controller.onCategoryTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: appnewColors.colorLine,
                    width: 1,
                  ),
                ),
        ),
        child: Row(
          children: [
            // 图标
            Image.asset(
              category.icon,
              width: 32.r,
              height: 32.r,
            ),
            SizedBox(width: 12.w),
            // 标题
            Expanded(
              child: Text(
                category.title,
                style: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // 右箭头
            Image.asset(
              Assets.mineIconArrowR,
              width: 16.r,
              height: 16.r,
            ),
          ],
        ),
      ),
    );
  }

  // 构建分类子项列表
  Widget _buildCategoryItems() {
    return Container(
      margin: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 0),
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Obx(() {
        final items = controller.currentItems;
        if (items.isEmpty) {
          return SizedBox();
        }

        return Column(
          children: List.generate(
            items.length,
            (index) {
              return _buildItemRow(items[index], index);
            },
          ),
        );
      }),
    );
  }

  // 构建列表项行
  Widget _buildItemRow(HelpItem item, int index) {
    final items = controller.currentItems;
    final isLast = index == items.length - 1;

    return InkWell(
      onTap: () => controller.onItemTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: appnewColors.colorLine,
                    width: 1,
                  ),
                ),
        ),
        child: Row(
          children: [
            // 标题
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // 右箭头
            Image.asset(
              Assets.mineIconArrowR,
              width: 16.r,
              height: 16.r,
            ),
          ],
        ),
      ),
    );
  }

  // 构建详细内容视图
  Widget _buildItemDetail() {
    return Obx(() {
      final item = controller.currentSelectedItem;
      if (item == null || item.content == null || item.content!.isEmpty) {
        return Container(
          padding: EdgeInsets.all(40.h),
          alignment: Alignment.center,
          child: Text(
            '暂无内容'.tr,
            style: TextStyle(
              color: appnewColors.text2,
              fontSize: 14.sp,
            ),
          ),
        );
      }

      return Container(
        margin: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 0),
        child: _HelpContentWebView(
          htmlContent: item.content!,
          controller: controller,
        ),
      );
    });
  }

  // 人工客服提示
  Widget _buildHumanServiceTip() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 32.h),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: appnewColors.text37,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(text: '没有找到解决办法?请联系'),
            TextSpan(
              text: '人工客服',
              style: TextStyle(
                color: appnewColors.textBlue,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  controller.onHumanServiceTap();
                  AppNavigator.gotoseveice();
                },
            ),
            TextSpan(text: '解决'),
          ],
        ),
      ),
    );
  }
}

// 动态 AppBar 组件
class _DynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HelpCenterController controller;

  const _DynamicAppBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomAppbar.normalTitle(
          bgColor: appnewColors.textWhite,
          title: controller.selectedCategoryIndex.value == -1
              ? '帮助中心'
              : (controller.selectedItemIndex.value != -1
                  ? controller.currentSelectedItem?.title ?? '帮助中心'
                  : controller
                      .helpCategories[controller.selectedCategoryIndex.value]
                      .title),
          onTap: (controller.selectedCategoryIndex.value != -1 ||
                  controller.selectedItemIndex.value != -1)
              ? () => controller.goBack()
              : null,
          actions: [
            GestureDetector(
              onTap: () {
                controller.onServiceIconTap();
                AppNavigator.gotoseveice();
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                padding: EdgeInsets.only(right: 16.w),
                child: Image.asset(
                  "assets/images/mine/help/icon_service.webp",
                  width: 24.r,
                  height: 24.r,
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + Get.mediaQuery.padding.top);
}

// WebView 组件用于显示帮助内容
class _HelpContentWebView extends StatefulWidget {
  final String htmlContent;
  final HelpCenterController controller;

  const _HelpContentWebView({
    required this.htmlContent,
    required this.controller,
  });

  @override
  State<_HelpContentWebView> createState() => _HelpContentWebViewState();
}

class _HelpContentWebViewState extends State<_HelpContentWebView> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    final NavigationDelegate nav = NavigationDelegate(
      onNavigationRequest: (NavigationRequest request) {
        // 允许所有导航请求，包括图片加载
        return NavigationDecision.navigate;
      },
      onHttpAuthRequest: tyWebViewRejectHttpAuth,
    );
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent);
    tyWebViewSetNavigationDelegateForIosUnawaited(
      controller: webViewController,
      navigationDelegate: nav,
    );

    // 异步加载 HTML 内容（包含本地图片处理）
    _loadHtmlContent();

    if (Platform.isAndroid) {
      final androidController =
          webViewController.platform as AndroidWebViewController;
      androidController.setOnShowFileSelector((params) async {
        return [];
      });
    }
  }

  Future<void> _loadHtmlContent() async {
    final String html =
        await widget.controller.buildHtmlContent(widget.htmlContent);
    log("object123456 html=$html");
    webViewController.loadHtmlString(html);
  }

  @override
  void didUpdateWidget(_HelpContentWebView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.htmlContent != widget.htmlContent) {
      _loadHtmlContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      return WebViewWidget.fromPlatformCreationParams(
        params: AndroidWebViewWidgetCreationParams(
          controller: webViewController.platform,
          displayWithHybridComposition: false,
        ),
      );
    } else {
      return WebViewWidget(
        controller: webViewController,
      );
    }
  }
}
