import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:flutter_ty_app/generated/locales.g.dart';

/// 视频信息规则说明弹窗组件
class VideoInfoDialog extends StatelessWidget {
  VideoInfoDialog({
    super.key,
  });

  /// 规则说明数据列表
  /// 使用国际化文案，并处理换行符
  final List<String> dataList = [
    "1." +
        LocaleKeys.app_info_rules_rule1.tr.replaceAll("\n", " ") +
        LocaleKeys.app_info_rules_rule2.tr.replaceAll("\n", " "),
    "\n2." + LocaleKeys.app_info_rules_rule3.tr.replaceAll("\n", " "),
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        // 容器装饰：白色背景+网络图片背景+圆角
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        // 外边距：水平方向55.w
        margin: EdgeInsets.symmetric(horizontal: 55.w),
        // 内边距：水平12.w，垂直6.w
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
        child: Stack(
          children: [
            // 主要内容区域（规则文本+滚动）
            Container(
              // 底部留出44.w空间给按钮
              padding: EdgeInsets.only(bottom: 44.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: ScrollController(),
                child: Column(
                  children: [
                    Text(
                      dataList[0],
                      style: TextStyle(
                          fontSize: (12.sp), color: AppColor.color303442),
                    ),
                    // 顶部间距
                    SizedBox(
                      height: 16.w,
                    ),
                    // 第一条规则文本
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        dataList[0],
                        style: TextStyle(
                            fontSize: (12.sp), color: AppColor.color303442),
                      ),
                    ),
                    // 规则间间距
                    SizedBox(
                      height: 4.w,
                    ),
                    // 第二条规则文本
                    Container(
                      child: Text(
                        dataList[1],
                        style: TextStyle(
                            fontSize: (12.sp), color: AppColor.color303442),
                      ),
                    ),
                    // 底部间距
                    20.verticalSpace
                  ],
                ),
              ),
            ),
            // 底部确认按钮
            Positioned(
                bottom: 15.w,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    // 点击按钮关闭弹窗
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 36.w,
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    // 按钮样式：蓝色背景+圆角
                    decoration: const BoxDecoration(
                      color: Color(0xff179CFF),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                      // 按钮文本使用国际化
                      LocaleKeys.app_h5_bet_confirm.tr,
                      style: TextStyle(fontSize: (14.sp), color: Colors.white),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
