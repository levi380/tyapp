import 'dart:ffi';

import 'package:filbet/common/currency.dart';

// import 'package:filbet/common/funding_channel.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/mixin/copy_mixin.dart';
import 'package:filbet/src/deposit/channel_model.dart';
import 'package:filbet/src/withdraw/glowing_icon.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/content_shadow_wrapper.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/widgets/select_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

/// Builder
Widget buildCurrencySelection(
  String title,
  Image icon,
  String currencyText, {
  bool isShowArrow = true,
  TextStyle? titleStyle,
  double? titleSpacing,
  EdgeInsetsGeometry? titlePadding,
  Color? glowColor,
  EdgeInsets contentPadding = const EdgeInsets.all(8),
  EdgeInsets padding = const EdgeInsets.all(8),
  void Function()? onTap,
}) {
  return buildContentShadowWrapperWithTitle(
    title: title,
    titleSpacing: titleSpacing,
    titleStyle: titleStyle,
    titlePadding: titlePadding,
    padding: padding,
    content: Padding(
      padding: contentPadding,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            GlowingIcon(glowColor: glowColor, size: 36.r, icon: icon),
            SizedBox(width: 10.w),
            Text(currencyText),
            Spacer(),
            if (isShowArrow)
              Image.asset(
                Assets.imagesArrowDown,
                height: 16.h,
                width: 16.w,
                color: appnewColors.text3,
              )
          ],
        ),
      ),
    ),
  );
}

/// 存取款方式
Widget buildFundingChannelsSelection(
  String title,
  List<ChannelModel> fundingChannels, {
  ChannelModel? selected,
  EdgeInsets contentPadding = const EdgeInsets.all(8),
  EdgeInsetsGeometry? titlePadding,
  double? titleSpacing,
  TextStyle? titleStyle,
  EdgeInsets padding = const EdgeInsets.all(8),
  void Function()? onTap,
  void Function(ChannelModel channel)? didSelect,
}) {
  // 将fundingChannels按每行3个分组
  List<List<ChannelModel>> rows = [];
  for (int i = 0; i < fundingChannels.length; i += 3) {
    int end = (i + 3 < fundingChannels.length) ? i + 3 : fundingChannels.length;
    rows.add(fundingChannels.sublist(i, end));
  }

  return buildContentShadowWrapperWithTitle(
    title: title,
    titlePadding: titlePadding,
    padding: padding,
    content: Padding(
      padding: contentPadding,
      child: Column(
        children: rows.map((rowChannels) {
          return Padding(
            padding:
                EdgeInsets.only(bottom: rows.last == rowChannels ? 0 : 16.h),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 为每一行都创建固定大小的项目，用spacer分隔
                for (int i = 0; i < 3; i++) ...[
                  if (i < rowChannels.length)
                    Container(
                      width: 64.w,
                      height: 64.h,
                      margin: EdgeInsets.only(right: 24.w),
                      child: GestureDetector(
                        onTap: () => didSelect?.call(rowChannels[i]),
                        child: _buildFundingChannelItem(
                          img: rowChannels[i].img,
                          title: rowChannels[i].name,
                          isSelected: selected == rowChannels[i],
                          recommend: fundingChannels[i].recommend ?? "",
                        ),
                      ),
                    ),
                  // else
                  //   SizedBox(width: 80.w), // 空白占位，保持固定宽度
                ],
              ],
            ),
          );
        }).toList(),
      ),
    ),
    titleSpacing: titleSpacing,
    titleStyle: titleStyle,
  );
}

/// 存取款方式
Widget buildFundingChannelsSelectionHorizontalSlide(
  String title,
  List<ChannelModel> fundingChannels, {
  ChannelModel? selected,
  EdgeInsets contentPadding = const EdgeInsets.all(8),
  EdgeInsetsGeometry? titlePadding,
  double? titleSpacing,
  TextStyle? titleStyle,
  EdgeInsets padding = const EdgeInsets.all(8),
  void Function()? onTap,
  void Function(ChannelModel channel)? didSelect,
}) {
  double width = (Get.width - 14.w * 2 - 20.w * 2 - 20.r * 3) / 4;
  return buildContentShadowWrapperWithTitle(
    title: title,
    titlePadding: titlePadding,
    padding: padding,
    content: Padding(
      padding: contentPadding,
      child: Wrap(
        runSpacing: 10.r,
        spacing: 20.r,
        children: List.generate(fundingChannels.length, (index) {
          return SizedBox(
            width: width,
            height: width,
            child: GestureDetector(
              onTap: () => didSelect?.call(fundingChannels[index]),
              child: _buildFundingChannelItem(
                img: fundingChannels[index].img,
                title: fundingChannels[index].name,
                isSelected: selected == fundingChannels[index],
                recommend: fundingChannels[index].recommend ?? "",
              ),
            ),
          );
        }),
      ),
    ),
    titleSpacing: titleSpacing,
    titleStyle: titleStyle,
  );
}

/// 存取款方式
Widget buildFundingChannelsSelectionGridViewSlide(
  String title,
  List<ChannelModel> fundingChannels,
  BuildContext context, {
  int crossAxisCount = 3,
  double childAspectRatio = 110 / 60,
  ChannelModel? selected,
  EdgeInsets contentPadding = const EdgeInsets.all(8),
  EdgeInsetsGeometry? titlePadding,
  double? titleSpacing,
  TextStyle? titleStyle,
  Color? bgColor,
  bool isPermanentUrl = false,
  EdgeInsets padding = const EdgeInsets.all(8),
  void Function()? onTap,
  double mainAxisSpacing = 4,
  double crossAxisSpacing = 0,
  void Function(ChannelModel channel)? didSelect,
  double? positionedLeft,
}) {
  return buildContentShadowWrapperWithTitle(
    title: title,
    titlePadding: titlePadding,
    padding: padding,
    isPermanentUrl: isPermanentUrl,
    content: MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeTop: true,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: fundingChannels.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount, // 三列
            mainAxisSpacing: mainAxisSpacing, // 行间距
            crossAxisSpacing: crossAxisSpacing, // 列间距
            childAspectRatio: childAspectRatio, // 宽高比（越大越扁）
          ),
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () => didSelect?.call(fundingChannels[index]),
              child: _buildFundingChannelItem(
                img: fundingChannels[index].img,
                title: fundingChannels[index].name,
                isSelected: selected == fundingChannels[index],
                recommend: fundingChannels[index].recommend ?? "",
                discount: fundingChannels[index].discountRate,
              ),
            );
          }),
    ),
    titleSpacing: titleSpacing,
    titleStyle: titleStyle,
    bgColor: bgColor,
    positionedLeft: positionedLeft,
  );
}

Widget _buildFundingChannelItem({
  required String img,
  required String title,
  required bool isSelected,
  required String recommend,
  String? discount,
}) {
  bool hasDiscount = discount?.isNotEmpty == true;
  return Stack(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? appnewColors.bg : appnewColors.colorLine,
            width: 1,
          ),
        ),
        // height: 64.w,
        // width: 64.w, // 固定宽度
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: !hasDiscount ? 32.w : 24.r,
              height: !hasDiscount ? 32.w : 24.r,
              padding: EdgeInsets.all(2.r),
              child: SKNetworkImage(
                fit: BoxFit.cover,
                imageUrl: img ?? "",
                placeholderType: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                "线下银行卡转账" == title ? "银行转账" : title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // 超出显示 ...
                style: TextStyle(
                  color: isSelected ? appnewColors.bg : appnewColors.text1,
                  fontSize: 12.sp,
                  height: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 2.r),
            if (hasDiscount)
              Text(
                '加送$discount%',
                style: TextStyle(
                  color: Color(0xFFFF7255),
                  fontSize: 10.sp,
                ),
              ),
          ],
        ),
      ),
      if (isSelected)
        Positioned(
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Image.asset(
                Assets.mineIconSelectWithdrawMethod,
                width: 19.w,
                height: 19.w,
              ),
            )),
      if ("1" == recommend)
        Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: Color(0xffFF7254),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  topLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: Text(
                "推荐",
                style: TextStyle(
                  color: appnewColors.text4,
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                  fontFamily: "PingFang SC",
                ),
              ),
            ))
    ],
  );
}

Widget buildCurrencySelectionDialog({
  required List<Currency> currencyList,
  Currency? selectedCurrency,
  void Function(Currency selectedCurrency)? didSelected,
}) {
  final items = currencyList.map((currency) {
    return BottomSelectModel(
      imgUrl: currency.imagePath,
      keyValue: currency.toString(),
      title: currency.name,
    );
  }).toList();
  final selectedItem = items.firstWhere(
    (item) => item.keyValue == selectedCurrency.toString(),
    orElse: () => items.first,
  );
  final sheet = SelectBottomSheet(
    title: 'choose_currency'.tr,
    itemList: items,
    onValueChanged: (model) {
      final selectedCurrency = Currency.values.firstWhere(
        (currency) => currency.toString() == model.keyValue,
      );
      didSelected?.call(selectedCurrency);
    },
    selectedItem: selectedItem,
  );
  return sheet;
}

/// Extensions
extension ChannelModelForWallet on ChannelModel {
  Widget get icon {
    switch (tokenType.toUpperCase()) {
      case 'USDT':
        return Image.asset(
          Assets.currencyUsdt,
          height: 28.h,
          width: 28.w,
        );
      case 'EB':
        return Image.asset(
          Assets.currencyEb,
          height: 28.h,
          width: 28.w,
        );
      case 'NO':
        return Image.asset(
          Assets.currencyNo,
          height: 28.h,
          width: 28.w,
        );
      case 'HD':
        return Image.asset(
          Assets.currencyHd,
          height: 28.h,
          width: 28.w,
        );
      case 'CNY':
        return Image.asset(
          Assets.currencyRmb,
          height: 28.h,
          width: 28.w,
        );
      default:
        return Image.asset(
          Assets.currencyThirdParty,
          height: 28.h,
          width: 28.w,
        );
    }
  }
}

extension CurrencyExtension on Currency {
  String get name {
    switch (this) {
      case Currency.rmb:
        return 'cny'.tr;
      // case Currency.usd:
      //   return 'usd'.tr;
      // case Currency.vnd:
      //   return 'vnd'.tr;
      // case Currency.hkd:
      //   return 'hkd'.tr;
      // case Currency.krw:
      //   return 'krw'.tr;
      // case Currency.idr:
      //   return 'idr'.tr;
      // case Currency.thb:
      //   return 'thb'.tr;
      // case Currency.mxn:
      //   return 'mxn'.tr;
      // case Currency.brl:
      //   return 'brl'.tr;
      // case Currency.inr:
      //   return 'inr'.tr;
      // case Currency.php:
      //   return 'php'.tr;
    }
  }

  String get imagePath {
    switch (this) {
      case Currency.rmb:
        return Assets.currencyRmb;
      // case Currency.usd:
      //   return Assets.currencyUsd;
      // case Currency.vnd:
      //   return Assets.currencyVnd;
      // case Currency.hkd:
      //   return Assets.currencyHkd;
      // case Currency.krw:
      //   return Assets.currencyKrw;
      // case Currency.idr:
      //   return Assets.currencyIdr;
      // case Currency.thb:
      //   return Assets.currencyThb;
      // case Currency.mxn:
      //   return Assets.currencyMxn;
      // case Currency.brl:
      //   return Assets.currencyBrl;
      // case Currency.inr:
      //   return Assets.currencyInr;
      // case Currency.php:
      //   return Assets.currencyPhp;
    }
  }
}

/// Widget
class WalletAmountInputField extends StatelessWidget {
  final bool isError;
  final String hintText;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final int maxLength;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged; // 👈 新增
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final TextStyle? hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const WalletAmountInputField({
    super.key,
    required this.isError,
    required this.hintText,
    required this.suffixIcon,
    this.controller,
    this.focusNode,
    this.maxLength = 18,
    this.textStyle,
    this.onChanged, // 👈 新增
    this.contentPadding, // 👈 新增
    this.borderRadius,
    this.hintStyle,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      cursorColor: textStyle?.color ?? appColors.textMainColor,
      maxLength: maxLength,
      inputFormatters: inputFormatters ??
          [
            FilteringTextInputFormatter.digitsOnly,
          ],
      style: textStyle ??
          TextStyle(
            color: appColors.mainColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
      decoration: InputDecoration(
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        counterText: '',
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              color: appnewColors.text2,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
        filled: true,
        fillColor: isError
            ? appnewColors.tip1.withValues(alpha: 0.1)
            : appnewColors.bg4,
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12.r),
          borderSide:
              isError ? BorderSide(color: appnewColors.tip1) : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12.r),
          borderSide:
              isError ? BorderSide(color: appnewColors.tip1) : BorderSide.none,
        ),
        isCollapsed: false,
        suffixIconConstraints: BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: suffixIcon,
        ),
      ),
      keyboardType: keyboardType ?? TextInputType.number,
      onChanged: onChanged, // 👈 关键
    );
  }
}

class WaleltUSDTAddressTextField extends StatelessWidget with CopyMixin {
  final String? hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Color? bgcolor;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final TextStyle? hintStyle;
  final bool showIcon;
  final Color? fillColor;
  final bool isError;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  const WaleltUSDTAddressTextField({
    super.key,
    this.hintText,
    this.bgcolor,
    required this.controller,
    this.focusNode,
    this.contentPadding, // 👈 新增
    this.borderRadius,
    this.hintStyle,
    this.showIcon = false,
    this.fillColor = Colors.white,
    this.isError = false,
    this.inputFormatters,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      // maxLength: maxLength,
      cursorColor: appColors.mainColor,
      style: TextStyle(
        color: appnewColors.text1,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText ?? 'input_wallet_addr'.tr,
        hintStyle: hintStyle ??
            TextStyle(
              color: appnewColors.text8,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
        filled: true,
        fillColor: fillColor ?? Colors.white,
        contentPadding: EdgeInsets.fromLTRB(10.w, 10.h, 100.w, 10.h),
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          borderSide: isError
              ? BorderSide(color: appnewColors.tip1, width: 1.w)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          borderSide: isError
              ? BorderSide(color: appnewColors.tip1, width: 1.w)
              : BorderSide.none,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        suffixIcon: suffixIcon ??
            GestureDetector(
              onTap: () {
                paste(controller);
                focusNode?.unfocus();
              },
              child: Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showIcon)
                        Image.asset(
                          Assets.imagesCopy,
                          height: 14.w,
                          width: 14.w,
                          color: appnewColors.bg,
                        ),
                      if (!showIcon)
                        Text(
                          'paste'.tr,
                          style: TextStyle(
                            color: appnewColors.text7,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  )),
            ),
      ),
    );
  }
}

class WalletPasswordTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isError;
  final Color? bgcolor;
  final int maxLength;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final BorderRadius? borderRadius;

  const WalletPasswordTextField({
    super.key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.bgcolor,
    this.isError = false,
    this.maxLength = 12,
    this.keyboardType,
    this.onChanged,
    this.fillColor,
    this.contentPadding,
    this.style,
    this.hintStyle,
    this.borderRadius,
  });

  @override
  State<WalletPasswordTextField> createState() =>
      _WalletPasswordTextFieldState();
}

class _WalletPasswordTextFieldState extends State<WalletPasswordTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      obscureText: _isObscured,
      onChanged: widget.onChanged,
      obscuringCharacter: '•',
      cursorColor: appColors.inputTextStyleColor,
      style: widget.style ??
          TextStyle(
            color: appColors.inputTextStyleColor,
            fontSize: 14.sp,
          ),
      decoration: InputDecoration(
        counterText: '',
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            TextStyle(
              color: appColors.textInputHintColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
        filled: true,
        fillColor: widget.isError
            ? appColors.bgErrorColor.withValues(alpha: 0.1)
            : widget.fillColor ?? appColors.bgSecondColor,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
          borderSide: widget.isError
              ? BorderSide(color: appColors.textRedErrorColor)
              : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
          borderSide: widget.isError
              ? BorderSide(color: appColors.textRedErrorColor)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
          borderSide: widget.isError
              ? BorderSide(color: appColors.textRedErrorColor)
              : BorderSide.none,
        ),
        suffixIconConstraints: BoxConstraints(
          // minHeight: 54.h,
          minWidth: 40.w,
        ),
        suffixIcon: widget.isError
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        Assets.imagesClear,
                        width: 20.w,
                        height: 20.w,
                        // color: appColors.textRedErrorColor,
                      ),
                      onTap: () {
                        widget.controller?.clear();
                      },
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      child: Image.asset(
                        _isObscured ? Assets.loginHidePwd : Assets.loginShowPwd,
                        width: 20.w,
                        height: 20.w,
                        // color: appColors.textRedErrorColor,
                      ),
                      onTap: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}

class ChangeLoginPwdOrPayPwdTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isError;
  final bool hasFocus;
  final int maxLength;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const ChangeLoginPwdOrPayPwdTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.focusNode,
      this.isError = false,
      this.hasFocus = false,
      this.maxLength = 12,
      this.keyboardType,
      this.onChanged,
      this.inputFormatters});

  @override
  State<ChangeLoginPwdOrPayPwdTextField> createState() =>
      _ChangeLoginPwdOrPayPwdTextFieldState();
}

class _ChangeLoginPwdOrPayPwdTextFieldState
    extends State<ChangeLoginPwdOrPayPwdTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    var inputStr = widget.controller?.text ?? '';
    return TextField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      obscureText: _isObscured,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      obscuringCharacter: '•',
      cursorColor: appColors.inputTextStyleColor,
      // widget.isError ? appColors.textRedColor : appColors.mainColor,
      style: TextStyle(
        color: appColors.inputTextStyleColor,
        // color: widget.isError ? appColors.textRedColor : appColors.mainColor,
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
          counterText: '',
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: appColors.textInputHintColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: widget.isError
              ? appColors.bgErrorColor.withValues(alpha: 0.1)
              : appColors.bgSecondColor,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: widget.isError
                ? BorderSide(color: appColors.textRedErrorColor)
                : BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: widget.isError
                ? BorderSide(color: appColors.textRedErrorColor)
                : BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: widget.isError
                ? BorderSide(color: appColors.textRedErrorColor)
                : BorderSide.none,
          ),
          suffixIconConstraints: BoxConstraints(
            // minHeight: 54.h,
            minWidth: 40.w,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (inputStr.isNotEmpty && widget.hasFocus)
                  GestureDetector(
                    child: Image.asset(
                      Assets.imagesClear,
                      width: 20.w,
                      height: 20.w,
                      // color: appColors.textRedColor,
                      // color: widget.isError
                      //     ? appColors.textRedColor
                      //     : appColors.mainColor,
                    ),
                    onTap: () {
                      widget.controller?.clear();
                    },
                  ),
                SizedBox(width: 8.w),
                GestureDetector(
                  child: Image.asset(
                    _isObscured ? Assets.loginHidePwd : Assets.loginShowPwd,
                    width: 20.w,
                    height: 20.w,
                    // color: appColors.textRedColor,
                    // color: widget.isError
                    //     ? appColors.textRedColor
                    //     : appColors.mainColor,
                  ),
                  onTap: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
              ],
            ),
          )),
    );
  }
}
