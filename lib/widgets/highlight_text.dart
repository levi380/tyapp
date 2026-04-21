import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///例:
// HighlightText(
//   text: LanguageService.to.language.globalDepositTip,
//   highlightData: {
//     '{m}': LanguageService.to.language.globalFooterContactUs,
//     '{a}': 'xxx'
//   },
//   onLink: (p0) {
//     print(p0);
//   },
//   normalStyle: TextStyle(
//       color: AoneAppTheme.appTheme.aoneTextColor,
//       fontSize: 13.sp,
//       fontWeight: FontWeight.w400),
//   highlightStyle: TextStyle(
//       decoration: TextDecoration.underline,
//       color: AoneAppTheme.appTheme.aonePrimary,
//       fontSize: 13.sp,
//       fontWeight: FontWeight.w400),
// )

///纯文本高亮颜色
class HighlightText extends StatelessWidget {
  final String text; //整个翻译文本内容
  final Map<String, String> highlightData; //高亮文本的 key:value
  final Function(String)? onLink; //高亮文本点击事件
  final TextStyle? normalStyle; //普遍文本样式
  final TextStyle? highlightStyle; //高亮文本样式
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const HighlightText({
    super.key,
    required this.text,
    required this.highlightData,
    this.onLink,
    this.normalStyle,
    this.highlightStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  List<TextSpan> _textSpans() {
    final pattern = highlightData.keys.map((e) => RegExp.escape(e)).join('|');
    final regExp = RegExp(pattern, multiLine: true);
    String prefix = "_&t";
    final textNew = text.splitMapJoin(
      regExp,
      onMatch: (m) => '$prefix${m[0]}$prefix',
      onNonMatch: (n) => n,
    );

    final list = textNew.split(RegExp('$prefix|$prefix'));

    return list.map((e) {
      if (e.isNotEmpty) {
        if (highlightData.keys.contains(e)) {
          return TextSpan(
            text: highlightData[e],
            style: highlightStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onLink?.call(e);
              },
          );
        }
      }
      return TextSpan(text: e, style: normalStyle);
    }).toList();
  }

  // List<TextSpan> _textSpanList() {
  //   List<TextSpan> list = [];
  //   if (text.contains(variableKey)) {
  //     int startIndex = text.indexOf(variableKey);
  //     String normalStr1 = text.substring(0, startIndex);
  //     String normalStr2 = text.substring(startIndex + variableKey.length);
  //     if (normalStr1.isNotEmpty) {
  //       list.add(TextSpan(text: normalStr1, style: normalStyle));
  //     }
  //     list.add(TextSpan(
  //         text: variable,
  //         style: highlightStyle,
  //         recognizer: highelightRecognizer));
  //     if (normalStr2.isNotEmpty) {
  //       list.add(TextSpan(text: normalStr2, style: normalStyle));
  //     }
  //   } else {
  //     list.add(TextSpan(text: text, style: normalStyle));
  //   }
  //   return list;
  // }

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.clip,
        text: TextSpan(children: _textSpans()));
  }
}
