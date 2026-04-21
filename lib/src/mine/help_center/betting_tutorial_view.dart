import 'package:filbet/src/mine/help_center/betting_tutorial_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BettingTutorialView extends GetView<BettingTutorialController> {
  const BettingTutorialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isRealMode = controller.isRealBettingMode.value;
      return CustomScffold(
        showBgTexture: false,
        backgroundColor: isRealMode ? appnewColors.bg15 : appnewColors.bg15,
        appBar: _DynamicTitleAppBar(controller: controller),
        body: Obx(() {
          // 动态计算 currentRule 文本的高度
          final ruleText = controller.currentRule;
          final ruleTextHeight = _calculateTextHeight(
            ruleText,
            fontSize: 14.sp,
            lineHeight: 1.5,
            maxWidth: Get.width - 14.w * 2 - 16.w * 2, // 减去左右 margin 和 padding
          );
          
          return Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: Get.height - 150 - ruleTextHeight-30,
                  width: Get.width,
                  color:isRealMode ?  appnewColors.textWhite:Colors.transparent,
                ),
              ),
              SafeArea(
                child: Container(
                  // color:  isRealMode ? appnewColors.textWhite : appnewColors.bg15,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            // color: isRealMode ? appnewColors.textWhite : Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTabBar(),
                                SizedBox(height: 16.h),
                                _buildRuleText(),
                                SizedBox(height: 20.h),
                                _buildTeamVsSection(),
                                SizedBox(height: 24.h),
                                // 根据是否为实战模式显示不同内容
                                controller.isRealBettingMode.value
                                    ? _buildRealBettingContent()
                                    : _buildExamplesSection(),
                                SizedBox(height: 24.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                      _buildSimulateButton(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      );
    });
  }

  // 计算文本高度
  double _calculateTextHeight(
    String text, {
    required double fontSize,
    required double lineHeight,
    required double maxWidth,
  }) {
    if (text.isEmpty) return 0;
    
    final textStyle = TextStyle(
      fontSize: fontSize,
      height: lineHeight,
    );
    
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: null,
    );
    
    textPainter.layout(maxWidth: maxWidth);
    
    return textPainter.size.height;
  }

  // 构建顶部标签栏
  Widget _buildTabBar() {
    return Obx(() {
      final isRealMode = controller.isRealBettingMode.value;
      final tabs = [
        BettingTutorialType.outrightWin,
        BettingTutorialType.handicap,
        BettingTutorialType.overUnder,
        BettingTutorialType.oddEven,
        BettingTutorialType.corner,
        BettingTutorialType.other,
      ];

      final tabNames = ['独赢', '让球', '大小', '单双', '角球', '波胆'];

      return Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: isRealMode ? appnewColors.textWhite : Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
          ),
        ),
        // margin: EdgeInsets.symmetric(horizontal: 14.w),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tabs.length,
          itemBuilder: (context, index) {
            final type = tabs[index];
            final name = tabNames[index];
            return Obx(() {
              final isSelected = controller.selectedType.value == type;
              return GestureDetector(
                onTap: () => controller.selectType(type),
                child: Container(
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    // border: Border(
                    //   bottom: BorderSide(
                    //     color: isSelected ? appnewColors.bgBlue : Colors.transparent,
                    //     width: 2.h,
                    //   ),
                    // ),
                  ),
                  child: Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        color: isSelected ? appnewColors.text1 : appnewColors.text2,
                        fontSize: 14.sp,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            });
          },
        ),
      );
    });
  }

  // 构建规则说明文本
  Widget _buildRuleText() {
    return Obx(() => Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
      decoration: BoxDecoration(
        // color: appnewColors.bg1,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        controller.currentRule,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: appnewColors.text39,
          fontSize: 14.sp,
          height: 1.5,
          fontWeight: FontWeight.w500
        ),
      ),
    ));
  }

  // 构建主队VS客队区域
  Widget _buildTeamVsSection() {
    return Obx(() {
      final isRealMode = controller.isRealBettingMode.value;
      final selectedType = controller.selectedType.value;
      final isCorner = selectedType == BettingTutorialType.corner;
      
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.w),
                height: 42.h,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFECF5FF).withOpacity(1.0),
                      offset: Offset(0, 0),
                      blurRadius: 4.0,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/mine/help/icon_home.webp",width: 32.w,),
                    SizedBox(width: 8.w),
                    Text(
                      '主队'.tr,
                      style: TextStyle(
                        color: appnewColors.text1,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 中间区域：模拟模式显示VS，实战模式显示比分
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              child: isRealMode
                  ? _buildScoreDisplay(isCorner)
                  : Image.asset(
                      'assets/images/mine/help/icon_vs.webp',
                      width: 24.w,
                    ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.w),
                height:  42.h,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFECF5FF).withOpacity(1.0),
                      offset: Offset(0, 0),
                      blurRadius: 4.0,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/mine/help/icon_away.webp",width: 32.w,),
                    SizedBox(width: 8.w),
                    Text(
                      '客队'.tr,
                      style: TextStyle(
                        color: appnewColors.text1,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // 构建比分显示（实战模式中间区域）
  Widget _buildScoreDisplay(bool isCorner) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
     
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isCorner ? '角球赛果' : '赛果',
            style: TextStyle(
              color: appnewColors.text39,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            isCorner ? '7 - 5' : '2 - 0',
            style: TextStyle(
              color: appnewColors.text1,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // 构建举例说明区域
  Widget _buildExamplesSection() {
    return Obx(() {
      final selectedType = controller.selectedType.value;
      final isHandicap = selectedType == BettingTutorialType.handicap;
      final isOverUnder = selectedType == BettingTutorialType.overUnder;
      final isOddEven = selectedType == BettingTutorialType.oddEven;
      final isOutrightWin = selectedType == BettingTutorialType.outrightWin;
      final isOther = selectedType == BettingTutorialType.other;
      final isCorner = selectedType == BettingTutorialType.corner;
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Text(
              '玩法举例说明',
              style: TextStyle(
                color: appnewColors.text1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // 如果是独赢类型，使用图片显示
          if (isOutrightWin)
            _buildOutrightWinImages()
          // 如果是让球类型，使用图片显示
          else if (isHandicap)
            _buildHandicapImages()
          // 如果是大小球类型，使用图片显示
          else if (isOverUnder)
            _buildOverUnderImage()
          // 如果是单双类型，使用图片显示
          else if (isOddEven)
            _buildOddEvenImage()
          // 如果是角球类型，使用图片显示
          else if (isCorner)
            _buildCornerImages()
          // 如果是波胆类型，使用图片显示
          else if (isOther)
            _buildOtherImage(),
        ],
      );
    });
  }

  // 构建实战投注内容
  Widget _buildRealBettingContent() {
    return Obx(() {
      final selectedType = controller.selectedType.value;
      
      // 独赢类型显示实战投注界面
      if (selectedType == BettingTutorialType.outrightWin) {
        return _buildOutrightWinRealBetting();
      }
      
      // 让球类型显示实战投注界面
      if (selectedType == BettingTutorialType.handicap) {
        return _buildHandicapRealBetting();
      }
      
      // 大小球类型显示实战投注界面
      if (selectedType == BettingTutorialType.overUnder) {
        return _buildOverUnderRealBetting();
      }
      
      // 单双类型显示实战投注界面
      if (selectedType == BettingTutorialType.oddEven) {
        return _buildOddEvenRealBetting();
      }
      
      // 角球类型显示实战投注界面
      if (selectedType == BettingTutorialType.corner) {
        return _buildCornerRealBetting();
      }
      
      // 波胆类型显示实战投注界面
      if (selectedType == BettingTutorialType.other) {
        return _buildOtherRealBetting();
      }
      
      // 其他类型暂时显示图片
      return _buildExamplesSection();
    });
  }

  // 构建独赢类型的实战投注界面
  Widget _buildOutrightWinRealBetting() {
    return Obx(() {
      final selectedOption = controller.selectedBettingOption.value;
      final result = controller.getOutrightWinBettingResult();
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 投注选项区域
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Expanded(
                  child: _buildBettingOptionCard(
                    title: '主胜',
                    odds: '1.98',
                    index: 0,
                    isSelected: selectedOption == 0,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildBettingOptionCard(
                    title: '和局',
                    odds: '1.98',
                    index: 1,
                    isSelected: selectedOption == 1,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildBettingOptionCard(
                    title: '客胜',
                    odds: '1.98',
                    index: 2,
                    isSelected: selectedOption == 2,
                  ),
                ),
              ],
            ),
          ),
          // 如果已选择，显示投注结果
          if (result != null) ...[
            SizedBox(height: 24.h),
            _buildBettingResult(result),
          ],
        ],
      );
    });
  }

  // 构建大小球类型的实战投注界面
  Widget _buildOverUnderRealBetting() {
    return Obx(() {
      final selectedOption = controller.selectedBettingOption.value;
      final result = controller.getOverUnderBettingResult();
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 投注选项区域（2x4网格）
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              children: [
                // 第一行
                Row(
                  children: [
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '大1.5',
                        odds: '1.98',
                        index: 0,
                        isSelected: selectedOption == 0,
                        showUpArrow: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '小1.5',
                        odds: '1.98',
                        index: 1,
                        isSelected: selectedOption == 1,
                        showDownArrow: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // 第二行
                Row(
                  children: [
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '大1.5/2',
                        odds: '1.98',
                        index: 2,
                        isSelected: selectedOption == 2,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '小1.5/2',
                        odds: '1.98',
                        index: 3,
                        isSelected: selectedOption == 3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // 第三行
                Row(
                  children: [
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '大2',
                        odds: '1.98',
                        index: 4,
                        isSelected: selectedOption == 4,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '小2',
                        odds: '1.98',
                        index: 5,
                        isSelected: selectedOption == 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // 第四行
                Row(
                  children: [
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '大2/2.5',
                        odds: '1.98',
                        index: 6,
                        isSelected: selectedOption == 6,
                        showUpArrow: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '小2/2.5',
                        odds: '1.98',
                        index: 7,
                        isSelected: selectedOption == 7,
                        showDownArrow: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 如果已选择，显示投注结果
          if (result != null) ...[
            SizedBox(height: 24.h),
            _buildBettingResult(result),
          ],
        ],
      );
    });
  }

  // 构建让球类型的实战投注界面
  Widget _buildHandicapRealBetting() {
    return Obx(() {
      final selectedOption = controller.selectedBettingOption.value;
      final result = controller.getHandicapBettingResult();
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 投注选项区域（2x4网格）
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              children: [
                // 第一行
                Row(
                  children: [
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '0',
                        odds: '1.98',
                        index: 0,
                        isSelected: selectedOption == 0,
                        showUpArrow: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '0',
                        odds: '1.98',
                        index: 1,
                        isSelected: selectedOption == 1,
                        showDownArrow: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // 第二行
                Row(
                  children: [
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '-0/0.5',
                        odds: '1.98',
                        index: 2,
                        isSelected: selectedOption == 2,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '+0/0.5',
                        odds: '1.98',
                        index: 3,
                        isSelected: selectedOption == 3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // 第三行
                Row(
                  children: [
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '-1',
                        odds: '1.98',
                        index: 4,
                        isSelected: selectedOption == 4,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '+1',
                        odds: '1.98',
                        index: 5,
                        isSelected: selectedOption == 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // 第四行
                Row(
                  children: [
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '-1.5/2',
                        odds: '1.98',
                        index: 6,
                        isSelected: selectedOption == 6,
                        showUpArrow: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '+1.5/2',
                        odds: '1.98',
                        index: 7,
                        isSelected: selectedOption == 7,
                        showDownArrow: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 如果已选择，显示投注结果
          if (result != null) ...[
            SizedBox(height: 24.h),
            _buildBettingResult(result),
          ],
        ],
      );
    });
  }

  // 构建单双类型的实战投注界面
  Widget _buildOddEvenRealBetting() {
    return Obx(() {
      final selectedOption = controller.selectedBettingOption.value;
      final result = controller.getOddEvenBettingResult();
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 投注选项区域
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Expanded(
                  child: _buildBettingOptionCard(
                    title: '单',
                    odds: '1.98',
                    index: 0,
                    isSelected: selectedOption == 0,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildBettingOptionCard(
                    title: '双',
                    odds: '1.98',
                    index: 1,
                    isSelected: selectedOption == 1,
                  ),
                ),
              ],
            ),
          ),
          // 如果已选择，显示投注结果
          if (result != null) ...[
            SizedBox(height: 24.h),
            _buildBettingResult(result),
          ],
        ],
      );
    });
  }

  // 构建角球类型的实战投注界面
  Widget _buildCornerRealBetting() {
    return Obx(() {
      final selectedOption = controller.selectedBettingOption.value;
      final result = controller.getCornerBettingResult();
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 投注选项区域（2x2网格）
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              children: [
                // 第一行
                Row(
                  children: [
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '-1.5',
                        odds: '1.98',
                        index: 0,
                        isSelected: selectedOption == 0,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '+1.5',
                        odds: '1.98',
                        index: 1,
                        isSelected: selectedOption == 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // 第二行
                Row(
                  children: [
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '-1.5/2',
                        odds: '1.98',
                        index: 2,
                        isSelected: selectedOption == 2,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildBettingOptionCard(
                        title: '+1.5/2',
                        odds: '1.98',
                        index: 3,
                        isSelected: selectedOption == 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 如果已选择，显示投注结果
          if (result != null) ...[
            SizedBox(height: 24.h),
            _buildBettingResult(result),
          ],
        ],
      );
    });
  }

  // 构建波胆类型的实战投注界面
  Widget _buildOtherRealBetting() {
    return Obx(() {
      final selectedOption = controller.selectedBettingOption.value;
      final result = controller.getOtherBettingResult();
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 投注选项区域
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Expanded(
                  child: _buildBettingOptionCard(
                    title: '2-0',
                    odds: '1.98',
                    index: 0,
                    isSelected: selectedOption == 0,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildBettingOptionCard(
                    title: '其他比分',
                    odds: '1.98',
                    index: 1,
                    isSelected: selectedOption == 1,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildBettingOptionCard(
                    title: '0-2',
                    odds: '1.98',
                    index: 2,
                    isSelected: selectedOption == 2,
                  ),
                ),
              ],
            ),
          ),
          // 如果已选择，显示投注结果
          if (result != null) ...[
            SizedBox(height: 24.h),
            _buildBettingResult(result),
          ],
        ],
      );
    });
  }

  // 构建投注选项卡片
  Widget _buildBettingOptionCard({
    required String title,
    required String odds,
    required int index,
    required bool isSelected,
    bool showUpArrow = false,
    bool showDownArrow = false,
  }) {
    return GestureDetector(
      onTap: () => controller.selectBettingOption(index),
      child: Container(
        height: 46.h,
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.w),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [Color(0xFFA4D3FF), Color(0xFFD7B2FD)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isSelected ? null : Color(0xFFF3F9FE),
          borderRadius: BorderRadius.circular(8.r),
          border: isSelected ? null : Border.all(color: appnewColors.bg3, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Color(0xFFA0A7BB),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showUpArrow)
                  Text(
                    '▲',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.red,
                      fontSize: 12.sp,
                    ),
                  ),
                if (showDownArrow)
                  Text(
                    '▼',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.green,
                      fontSize: 12.sp,
                    ),
                  ),
                Text(
                  odds,
                  style: TextStyle(
                    color: isSelected ? Colors.white : appnewColors.text1,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建投注结果区域
  Widget _buildBettingResult(Map<String, dynamic> result) {
    final resultType = result['result']; // 'win', 'lose', 'winHalf', 'loseHalf', 'tie'
    
    // 获取印章图标路径
    String getStampIconPath() {
      switch (resultType) {
        case 'win':
          return 'assets/images/mine/help/bet/icon_win.webp';
        case 'lose':
          return 'assets/images/mine/help/bet/icon_lose.webp';
        case 'winHalf':
          return 'assets/images/mine/help/bet/icon_win_half.webp';
        case 'loseHalf':
          return 'assets/images/mine/help/bet/icon_lose_half.webp';
        case 'tie':
          return 'assets/images/mine/help/bet/icon_tie.webp';
        default:
          return 'assets/images/mine/help/bet/icon_lose.webp';
      }
    }
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4.w),
                      width: 2.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFA4D3FF), Color(0xFFD7B2FD)],
                        ),
                      ),
                    ),
                    Text(
                      '投注结果',
                      style: TextStyle(
                        color: appnewColors.text1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Text(
                  '${result['option']} ',
                  style: TextStyle(
                    color: appnewColors.text1,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                 Text(
                  '@${result['odds']}',
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                  ],
                ),
               
                SizedBox(height: 8.h),
                Text(
                  result['description'],
                  style: TextStyle(
                    color: appnewColors.text2,
                    fontSize: 12.sp,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          // 输赢印章
          Image.asset(
            getStampIconPath(),
            width: 80.r,
            height: 80.r,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  // 构建独赢类型的图片显示
  Widget _buildOutrightWinImages() {
    final images = [
      'assets/images/mine/help/bet/icon_pan_win_1.webp',
      'assets/images/mine/help/bet/icon_pan_win_2.webp',
      'assets/images/mine/help/bet/icon_pan_win_3.webp',
    ];
    
    return Column(
      children: images.map((imagePath) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h, left: 14.w, right: 14.w),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        );
      }).toList(),
    );
  }

  // 构建让球类型的图片显示
  Widget _buildHandicapImages() {
    final images = [
      'assets/images/mine/help/bet/icon_pan_rang_1.webp',
      'assets/images/mine/help/bet/icon_pan_rang_2.webp',
      'assets/images/mine/help/bet/icon_pan_rang_3.webp',
    ];
    
    return Column(
      children: images.map((imagePath) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h, left: 14.w, right: 14.w),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        );
      }).toList(),
    );
  }

  // 构建大小球类型的图片显示
  Widget _buildOverUnderImage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      child: Image.asset(
        'assets/images/mine/help/bet/icon_pan_bs_1.webp',
        fit: BoxFit.contain,
        width: double.infinity,
      ),
    );
  }

  // 构建单双类型的图片显示
  Widget _buildOddEvenImage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      child: Image.asset(
        'assets/images/mine/help/bet/icon_pan_oe_1.webp',
        fit: BoxFit.contain,
        width: double.infinity,
      ),
    );
  }

  // 构建角球类型的图片显示
  Widget _buildCornerImages() {
    final images = [
      'assets/images/mine/help/bet/icon_pan_jq_1.webp',
      'assets/images/mine/help/bet/icon_pan_jq_2.webp',
      'assets/images/mine/help/bet/icon_pan_jq_3.webp',
    ];
    
    return Column(
      children: images.map((imagePath) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h, left: 14.w, right: 14.w),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        );
      }).toList(),
    );
  }

  // 构建波胆类型的图片显示
  Widget _buildOtherImage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      child: Image.asset(
        'assets/images/mine/help/bet/icon_pan_bd_1.webp',
        fit: BoxFit.contain,
        width: double.infinity,
      ),
    );
  }


  // 构建模拟投注/实战投注按钮（固定在底部）
  Widget _buildSimulateButton() {
    return Obx(() => Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 46.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB3C6FE), Color(0xFFB3C6FE)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(23.h),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.toggleBettingMode,
          borderRadius: BorderRadius.circular(24.r),
          child: Center(
            child: Text(
              controller.buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

// 动态标题 AppBar
class _DynamicTitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BettingTutorialController controller;

  const _DynamicTitleAppBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomAppbar.normalTitle(
      bgColor: appnewColors.textWhite,
      title: '${controller.currentTitle}教程'.tr,
      onTap: () {
        // 如果是实战模式，切换回模拟模式
        if (controller.isRealBettingMode.value) {
          controller.isRealBettingMode.value = false;
          // 重置实战模式的选中状态
          controller.selectedBettingOption.value = null;
        } else {
          // 如果是模拟模式，返回上一页
          Get.back();
        }
      },
    ));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + Get.mediaQuery.padding.top);
}
