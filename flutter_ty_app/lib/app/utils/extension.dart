import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/keep_alive_wrapper.dart';
extension WidgetSliver on Widget {
  Widget get sliver => SliverToBoxAdapter(child: this);

  Widget sliverOr(bool sliver) =>
      sliver ? SliverToBoxAdapter(child: this) : this;
}

extension WidgetAlignExtensions on Widget {
  Widget get center => Align(alignment: Alignment.center, child: this);
  Widget get centerLeft => Align(alignment: Alignment.centerLeft, child: this);
}

extension WidgetColor on Widget {
  Widget color(Color? c) => c != null ? Container(color: c, child: this) : this;
}

extension WidgetBorderRadius on Widget {
  Widget borderRadius(BorderRadiusGeometry? r) => r != null
      ? Container(decoration: BoxDecoration(borderRadius: r), child: this)
      : this;
}

final _baseSpace = 14.w;

extension WidgetMarginPadding on Widget {
  // 左右 base margin
  Widget get baseMarginHorizontal => marginHorizontal(_baseSpace);

  // 上下 base margin
  Widget get baseMarginVertical => marginVertical(_baseSpace);

  // 左上右margin
  Widget get baseMarginLtr => Container(
        margin: EdgeInsets.only(top: 5.w, left: _baseSpace, right: _baseSpace),
        child: this,
      );
  Widget get baseMarginLt => Container(
        margin: EdgeInsets.only(top: 5.w, left: _baseSpace),
        child: this,
      );
  Widget get baseMarginL => Container(
        margin: EdgeInsets.only(left: _baseSpace),
        child: this,
      );
  Widget get baseMarginR => Container(
        margin: EdgeInsets.only(right: _baseSpace),
        child: this,
      );
  Widget get baseMarginT => Container(
        margin: EdgeInsets.only(top: 5.w),
        child: this,
      );

  // 左右 margin
  Widget marginVertical(double? vertical) => vertical != null
      ? Container(
          margin: EdgeInsets.symmetric(vertical: vertical),
          child: this,
        )
      : this;

  // 上下 margin
  Widget marginHorizontal(double? horizontal) => horizontal != null
      ? Container(
          margin: EdgeInsets.symmetric(horizontal: horizontal),
          child: this,
        )
      : this;

  Widget marginLeft(double? left) => left != null
      ? Container(
          margin: EdgeInsets.only(left: left),
          child: this,
        )
      : this;

  Widget marginTop(double? top) => top != null
      ? Container(
          margin: EdgeInsets.only(top: top),
          child: this,
        )
      : this;

  Widget marginBottom(double? bottom) => bottom != null
      ? Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: this,
        )
      : this;

  Widget marginRight(double? right) => right != null
      ? Container(
          margin: EdgeInsets.only(right: right),
          child: this,
        )
      : this;

  // 左右 base padding
  Widget get basePaddingHorizontal => Container(
        padding: EdgeInsets.symmetric(horizontal: _baseSpace),
        child: this,
      );

  // 上下 base padding
  Widget get basePaddingVertical => Container(
        padding: EdgeInsets.symmetric(vertical: _baseSpace),
        child: this,
      );

  // 左上下 base padding
  Widget get basePaddingLtr => Container(
        padding: EdgeInsets.only(
          top: _baseSpace,
          left: _baseSpace,
          right: _baseSpace,
        ),
        child: this,
      );

  // 左右padding
  Widget paddingVertical(double? vertical) => vertical != null
      ? Padding(
          padding: EdgeInsets.symmetric(vertical: vertical),
          child: this,
        )
      : this;

  Widget paddingHorizontal(double? horizontal) => horizontal != null
      ? Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          child: this,
        )
      : this;

  Widget sliverPaddingHorizontal(double? horizontal) => horizontal != null
      ? SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          sliver: this,
        )
      : this;

  Widget paddingTop(double? top) => top != null
      ? Padding(padding: EdgeInsets.only(top: top), child: this)
      : this;

  Widget paddingLeft(double? left) => left != null
      ? Padding(padding: EdgeInsets.only(left: left), child: this)
      : this;

  Widget sliverPaddingLeft(double? left) => left != null
      ? SliverPadding(padding: EdgeInsets.only(left: left), sliver: this)
      : this;

  Widget paddingRight(double? right) => right != null
      ? Padding(padding: EdgeInsets.only(right: right), child: this)
      : this;
  Widget sliverPaddingRight(double? right) => right != null
      ? SliverPadding(padding: EdgeInsets.only(right: right), sliver: this)
      : this;
  Widget paddingBottom(double? bottom) => bottom != null
      ? Padding(padding: EdgeInsets.only(bottom: bottom), child: this)
      : this;

  Widget paddingAll(double? value) => value != null
      ? Padding(padding: EdgeInsets.all(value), child: this)
      : this;

  Widget padding(EdgeInsets? padding) =>
      padding != null ? Padding(padding: padding, child: this) : this;
}

extension GestureDetectorExtensions on Widget {
  Widget onTap(VoidCallback? onTap) => onTap != null
      ? GestureDetector(
          onTap: onTap,
          child: this,
        )
      : this;

  Widget onOpaqueTap(VoidCallback? onTap) => onTap != null
      ? GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: this,
        )
      : this;
}

extension KeepAliveExtensions on Widget {
  Widget get keepAlive => KeepAliveWrapper(child: this);
  // Widget get keepAlive => this;
}

extension ListExtensions<E> on List<E> {
  List<E> trimLeading(bool Function(E e) test) {
    final index = indexWhere(test);
    if (index == -1) return this;
    final start = index + 1;
    if (start >= length - 1) {
      return [];
    }
    return sublist(start);
  }

  // 向指定位置插入，长度不够则add
  List<E> insertOrAdd(int index, E e) {
    if (index < length) {
      insert(index, e);
    } else {
      add(e);
    }
    return this;
  }
}

extension PathPointExtensions on Path {
  lineToPoint(Point<double> point) => lineTo(point.x, point.y);
  moveToPoint(Point<double> point) => moveTo(point.x, point.y);
}

extension ScrollControllerExtensions on ScrollController {
  void jumpToBottomIfNecessary() {
    final maxScrollExtent = position.maxScrollExtent;
    final current = offset;

    if (maxScrollExtent > current) {
      jumpTo(maxScrollExtent);
    }
  }
}

extension DoubleExtension on double {
  // 1.0 -> 1
  // 1.234 => 1.234
  String toStringAsShort() => '$this'.trimTrailing('0').trimTrailing('.');
}

extension StringExtension on String {
  String trimLeading(String pattern) {
    if (pattern.isEmpty) return this;
    var i = 0;
    while (startsWith(pattern, i)) {
      i += pattern.length;
    }
    return substring(i);
  }

  String trimTrailing(String pattern) {
    if (pattern.isEmpty) return this;
    var i = length;
    while (startsWith(pattern, i - pattern.length)) {
      i -= pattern.length;
    }
    return substring(0, i);
  }

  String trimString(String pattern) =>
      trimLeading(pattern).trimTrailing(pattern);
}

extension DateTimeExtension on DateTime {
  DateTime beginningOfMonth(int next) {
    var newYear = year + next ~/ 12;
    var newMonth = 0;
    if (next >= 0) {
      newMonth = month + next % 12;
    } else {
      newMonth = month - ((-next) % 12);
    }
    if (newMonth > 12) {
      newYear++;
      newMonth = newMonth % 12;
    } else if (newMonth <= 0) {
      newYear--;
      newMonth = 12 + newMonth;
    }
    return DateTime(newYear, newMonth, 1);
  }
}


