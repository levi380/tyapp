import 'dart:io';

import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/deposit_activity/views/actuicity_venue_sel.dart';
import 'package:filbet/src/deposit_activity/views/actuicity_venue_type_sel.dart';
import 'package:filbet/src/mine/transfer/widgets/title_and_amount.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/base_util.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/utils/webview_ios_http_auth.dart'
    show tyWebViewBindNavigationAndLoadUnawaited, tyWebViewRejectHttpAuth;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../controllers/first_deposit_activity_controller.dart';

// 首存活动
class FirstDepositActivityView extends GetView<FirstDepositActivityController> {
  const FirstDepositActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: appnewColors.bg15,
        appBar: CustomAppbar.normalTitle(
          bgColor: Colors.white,
          title: controller.detail.value?.name ?? "",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 10.h),
              // _buildHtmlWidget(),
              // SizedBox(height: 10.h),
              _buildRules(),
              SizedBox(height: 20.h),
              _walletCard(),
              SizedBox(height: 16.h),
              _formCard(),
              SizedBox(height: 16.h),
              _resultCard(),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      );
    });
  }

  Widget recycleView() {
    return InkWell(
      onTap: () {
        controller.oneKeyRecycle();
      },
      child: Container(
        height: 30.r,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.r),
        decoration: BoxDecoration(
          color: Color(0xFF79AFFF),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          'one_recycle'.tr,
          style: TextStyle(
            color: appnewColors.text4,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (controller.imageTop.value.isNotEmpty) {
      return SizedBox(
        width: double.infinity,
        child: Image.network(
          staticImageResolver(controller.imageTop.value ?? ""),
          fit: BoxFit.fitWidth,
        ),
      );
    } else {
      return Text("");
    }
    // return Container(
    //   width: double.infinity,
    //   height: 260.h,
    //   child: SKNetworkImage(
    //     fit: BoxFit.cover,
    //     imageUrl: controller.imageTop.value ?? "",
    //     borderRadius: 5.r,
    //     placeholderType: 2,
    //   ),
    // );
  }

  Widget _buildHtmlWidget() {
    return _cardWrapper(
      Column(
        children: [
          Text(
            controller.detail.value?.name ?? "",
            style: TextStyle(color: appnewColors.textBlue, fontSize: 22.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Html(
                  shrinkWrap: true,
                  data: controller.detail.value?.summary ?? '',
                  onLinkTap: (
                    String? url,
                    Map<String, String> attributes,
                    element,
                  ) {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRules() {
    return _cardWrapper(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // _sectionTitle('活动规则', 'Activity rules'),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff9BC2FF), width: 1.w),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Html(
              shrinkWrap: true,
              data: controller.detail.value?.h5Summary ?? "",
              onLinkTap: (
                String? url,
                Map<String, String> attributes,
                element,
              ) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardWrapper(Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String title, String subTiele) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 左线
                  Container(
                    width: 50.w,
                    height: 2.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: appnewColors.bg9),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 4.h),
                    height: 2.h,
                    decoration: BoxDecoration(color: appnewColors.bg18),
                  ),
                ],
              )),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: appnewColors.text34,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  // mainAxisAlignment:,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50.w,
                      height: 2.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: appnewColors.bg9,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.h),
                      height: 2.h,
                      decoration: BoxDecoration(color: appnewColors.bg18),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              subTiele,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: appnewColors.text35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletCard() {
    return Container(
      height: 79.h,
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: appnewColors.bg16.withAlpha(20),
            blurRadius: 5.r,
            offset: const Offset(0, 7),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: const BoxDecoration(
              color: Color(0xFF4C8DFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.account_balance_wallet, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  titleAndAmount(
                      titleColor: appnewColors.text40,
                      iconColor: appnewColors.bgBlue,
                      isRotating: controller.isRefreshing.value,
                      '中心钱包',
                      controller.centerAmount.value.toFixed2(),
                      titleIcon2: Assets.mineIconRefresh, onIconTap: () {
                    controller.financeWallet();
                  })
                ],
              ),
            ],
          ),
          Spacer(),
          recycleView(),
        ],
      ),
    );
  }

  Widget _formCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: appnewColors.bg16.withAlpha(20),
            blurRadius: 5.r,
            offset: const Offset(0, 7),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          _label('选择场馆'),
          InkWell(
            onTap: () {
              Get.bottomSheet(
                ActivityVenueSel(
                  activityList: controller.platformList,
                  callback: (item) {
                    controller.walletSel.value = item;
                    controller.selWalletName.value = item.name ?? "";
                  },
                  cancelCallback: () {},
                ),
                isScrollControlled: true,
              ).then((value) {});
            },
            child: _selectBox(controller.selWalletName.isEmpty ? '请选择场馆' : controller.selWalletName.value),
          ),
          const SizedBox(height: 16),
          _label('选择类型'),
          InkWell(
            onTap: () {
              var grantMode = controller.detail.value?.grantMode;
              var requireAmount = controller.detail.value?.requireAmount;
              var giftRatio = controller.detail.value?.giftRatio;
              var grantLimit = controller.detail.value?.grantLimit;
              var multiple = controller.detail.value?.multiple;
              String hint = "";

              if (grantMode == 1) {
                //赠送模式 1比例 2固定
                hint = "存$requireAmount元及以上送$giftRatio%，最高送$grantLimit元，$multiple倍流水";
              } else {
                hint = "存$requireAmount元及以上送$grantLimit元，$multiple倍流水";
              }

              Get.bottomSheet(
                ActivityVenueTypeSel(
                  text: hint,
                  callback: (text) {
                    controller.selType.value = text;
                  },
                  cancelCallback: () {},
                ),
                isScrollControlled: true,
              ).then((value) {});
            },
            child: _selectBox(controller.selType.isEmpty ? '请选择类型' : controller.selType.value),
          ),
          const SizedBox(height: 16),
          _label('申请金额'),
          _inputBox('请输入转入场馆申请优惠的金额（元）'),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: appnewColors.text1),
        ),
      ),
    );
  }

  Widget _selectBox(String hint) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: appnewColors.bg17),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              hint,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: appnewColors.text1),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 16.w,
          ),
        ],
      ),
    );
  }

  Widget _inputBox(String hint) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller.amountController,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: false,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d*\.?\d*'),
          ),
        ],
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: appnewColors.text33),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: const BorderSide(color: Color(0xFFE5E6EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: const BorderSide(color: Color(0xFFE5E6EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: const BorderSide(color: Color(0xFF4C8DFF)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
        ),
      ),
    );
  }

  Widget _resultCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: appnewColors.bg16.withAlpha(20),
            blurRadius: 5.r,
            offset: const Offset(0, 7),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          // 首存活动 流水要求金额 = （本金 + 红利）* 流水倍数要求
         // controller.detail.value?.multiple;

          // todo 更加公式计算
          _amountRow('可得彩金:', '${controller.amountAvailable} 元'),
          SizedBox(height: 8.h),
          _amountRow('流水要求:', '${controller.getFlowingWater ?? ""} 元'),
          SizedBox(height: 18.h),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              onPressed: () {
                controller.promoApply();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appnewColors.bgBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '立即参与',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 19.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info, color: appnewColors.tip1, size: 16),
                  SizedBox(width: 6),
                  Text(
                    '温馨提示：',
                    style: TextStyle(color: appnewColors.text1, fontSize: 12.sp),
                  ),
                ],
              ),
              Text(
                '首存活动，每个账户仅可参与一次，不可重复',
                style: TextStyle(color: appnewColors.text1, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  Widget _amountRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: appnewColors.text1),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: appnewColors.textBlue),
        ),
      ],
    );
  }
}

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewViewState();
}

class _WebViewViewState extends State<WebView> {
  final FirstDepositActivityController controller = Get.find<FirstDepositActivityController>();
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    final String html = controller.detail.value?.h5Summary ?? '';
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final NavigationDelegate nav = NavigationDelegate(
      onProgress: (int progress) {},
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        return NavigationDecision.navigate;
      },
      onHttpError: (HttpResponseError error) {},
      onUrlChange: (UrlChange change) {
        debugPrint('url change to ${change.url}');
      },
      onHttpAuthRequest: tyWebViewRejectHttpAuth,
    );
    final WebViewController cl = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      );
    tyWebViewBindNavigationAndLoadUnawaited(
      controller: cl,
      navigationDelegate: nav,
      loadHtmlString: _wrapHtml(html ?? ""),
    );

    if (!Platform.isMacOS) {
      cl.setBackgroundColor(Colors.transparent);
    }

    if (cl.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (cl.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
    webViewController = cl;
  }

  @override
  Widget build(BuildContext context) {
    final String html = controller.detail.value?.h5Summary ?? '';
    webViewController.loadHtmlString(_wrapHtml(html ?? '' ?? ""));
    webViewController.setBackgroundColor(Colors.transparent);
    return WebViewWidget(
      controller: webViewController,
    );
  }

  String _wrapHtml(String html) {
    html = html.replaceAll('\n', '<br>');
    return """
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
      <style>
        html,body {
          background: transparent; /* 网页背景透明 */
          font-size: 14px;
          line-height: 1.5;
          word-break: break-all;
          overflow-wrap: break-word;
          white-space: normal;
          margin: 0;
          padding: 10px;
        }

        /* 图片自适应屏幕 */
        img {
          max-width: 100%;
          height: auto;
          display: block;
          margin: 5px 0;
        }

        /* 表格自适应屏幕 */
        table {
          width: 100% !important;
          border-collapse: collapse;
          table-layout: fixed; /* 防止超出 */
          word-break: break-word;
        }
        table, th, td {
          border: 1px solid #ddd;
          padding: 6px;
        }
        th {
          background-color: #f2f2f2;
        }
        
        /* 链接高亮 */
        a {
          color: #0000ff;
          text-decoration: none;
          word-break: break-all;
        }

        /* div 强制换行 */
        body,div {
          word-break: break-all;
          color: "#383B42;
          overflow-wrap: break-word;
          white-space: normal;
        }
      </style>
       <script>
      document.addEventListener("DOMContentLoaded", function() {
        const body = document.body;
        // 正则匹配 URL
        const urlPattern = /((https?:\\/\\/|www\\.)[\\w\\-]+(\\.[\\w\\-]+)+([\\w\\-.,@?^=%&:/~+#]*[\\w@?^=%&/~+#])?)/gi;
        
        // 将纯文本链接替换为 <a> 标签
        function linkify(node) {
          if (node.nodeType === 3) { // 文本节点
            const text = node.nodeValue;
            const replaced = text.replace(urlPattern, function(url) {
              let href = url;
              if (!href.startsWith('http')) href = 'https://' + href;
              return '<a href="' + href + '" target="_blank">' + url + '</a>';
            });
            if (replaced !== text) {
              const span = document.createElement('span');
              span.innerHTML = replaced;
              node.replaceWith(span);
            }
          } else if (node.nodeType === 1 && node.tagName.toLowerCase() !== 'a') {
            Array.from(node.childNodes).forEach(linkify);
          }
        }

        linkify(body);
      });
    </script>
    </head>
    <body>
      ${html}
    </body>
    </html>
    """;
  }
}
