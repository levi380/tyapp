import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../widgets/image_view.dart';

typedef AsyncVoidCallback = Future<void> Function();

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 横屏投注键盘Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 横屏投注键盘部件
      横屏投注键盘布局和竖屏键盘有所不同
    】】】
 *
 */
class NumberKeyboardLandscape extends StatelessWidget {
  const NumberKeyboardLandscape({
    Key? key,
    this.onTextInput,
    this.onBackspace,
    this.onBet,
    this.isBetEnabled = true,
  }) : super(key: key);

  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;
  final AsyncVoidCallback? onBet;
  final bool isBetEnabled;

  void _textInputHandler(String text) => onTextInput?.call(text);
  void _backspaceHandler() => onBackspace?.call();
  Future<void> _betHandler() async => onBet?.call();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 111,
        child: Column(
            children: [
              Row(
                children: [
                  TextKey(
                    text: '1',
                    onTextInput: _textInputHandler,
                  ),
                  TextKey(
                    text: '2',
                    onTextInput: _textInputHandler,
                  ),
                  TextKey(
                    text: '3',
                    onTextInput: _textInputHandler,
                  ),
                  TextKey(
                    text: '4',
                    onTextInput: _textInputHandler,
                  ),
                  TextKey(
                    text: '5',
                    onTextInput: _textInputHandler,
                  ),
                ],
              ),
              Row(
                children: [
                  TextKey(
                    text: '6',
                    onTextInput: _textInputHandler,
                  ),
                  TextKey(
                    text: '7',
                    onTextInput: _textInputHandler,
                  ),
                  TextKey(
                    text: '8',
                    onTextInput: _textInputHandler,
                  ),
                  TextKey(
                    text: '9',
                    onTextInput: _textInputHandler,
                  ),
                  TextKey(
                    text: '0',
                    onTextInput: _textInputHandler,
                  ),
                ],
              ),
              Row(
                children: [
                  TextKey(
                    text: '.',
                    onTextInput: _textInputHandler,
                  ),
                  BackspaceKey(
                    onBackspace: _backspaceHandler,
                  ),
                  BetKey(
                    flex: 3,
                    onBet: _betHandler,
                    isEnabled: isBetEnabled,
                  ),

                ],
              ),
            ]
        )
    );
  }
}

class TextKey extends StatelessWidget {
  const TextKey({
    Key? key,
    @required this.text,
    this.onTextInput,
    this.flex = 1,
  }) : super(key: key);

  final String? text;
  final ValueSetter<String>? onTextInput;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 34,
        decoration: BoxDecoration(
          color:Colors.white.withValues(alpha:0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.all(1.5),
        child: InkWell(
          onTap: () {
            onTextInput?.call(text!);
          },
          child: Container(
            child: Center(
                child: Text(text!,
                  style: TextStyle(
                    fontSize: 14.0.scale,
                    color: Colors.white,
                    fontWeight:FontWeight.w500,
                    fontFamily: "PingFang SC",
                  ),
                )),
          ),
        ),

      ),
    );
  }
}


class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    Key? key,
    this.onBackspace,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback? onBackspace;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 34,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: Colors.white.withValues(alpha:0.1),
        ),
        margin: const EdgeInsets.all(1.5),
        child: InkWell(
          onTap: () {
            onBackspace?.call();
          },
          child: Container(
            child: Center(
              child: ImageView('assets/images/shopcart/backspace1.png',width: 16,color: Colors.white.withValues(alpha:0.6),),
            ),
          ),
        ),
      ),
    );
  }
}

class BetKey extends StatefulWidget {
  const BetKey({
    Key? key,
    this.onBet,
    this.flex = 1,
    this.isEnabled = true,
  }) : super(key: key);

  final AsyncVoidCallback? onBet;
  final int flex;
  final bool isEnabled;

  @override
  _BetKeyState createState() => _BetKeyState();
}

class _BetKeyState extends State<BetKey>{
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Container(
        height: 34,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: widget.isEnabled?(isProcessing?const Color(0xFF026DBC):const Color(0xFF127DCC)):Colors.white.withValues(alpha:0.4),
        ),
        margin: const EdgeInsets.all(1.5),
        child: InkWell(
          onTap: widget.isEnabled?() async {
            if(!isProcessing) {
              setState(() {
                isProcessing = true;
              });
              await widget.onBet?.call();
              setState(() {
                isProcessing = false;
              });
            }
          }:null,
          child: Container(
            child: Center(
                child: Text(LocaleKeys.app_place_bet.tr,
                  style: TextStyle(
                    fontSize: 14.0.scale,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: "PingFang SC",
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
