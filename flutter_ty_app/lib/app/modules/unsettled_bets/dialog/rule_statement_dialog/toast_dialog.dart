import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单(未结算)复制单号提示Dialog弹框 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能是一个无状态组件，用于显示一个透明背景的提示对话框，通常用于临时信息的展示，如成功或错误消息。
    -AlertDialog: 使用透明背景的对话框，设置了对齐方式和内边距。
    -alignment: 设置对话框内容居中。
    -insetPadding: 设置为零以去除默认内边距。
    -contentPadding: 设置为零以去除内容内边距。
    -titlePadding: 设置为零以去除标题内边距。
    -backgroundColor: 设置为透明。
    -elevation: 设置为0以去除阴影效果。
    - 构建对话框的主体内容：
    -Container: 设置对话框的高度和透明背景。
    -alignment: 内容居中。
    -height: 固定高度为50。
    -color: 设置为透明。
    -内层 Container: 用于显示提示信息的背景。
    -BoxDecoration: 设置圆角和背景颜色（半透明黑色）。
    -Padding: 设置内边距以增加文本的可读性。
    -Text: 显示提示信息，支持文本溢出处理。
    -style: 字体颜色为白色，大小为14。
    -textAlign: 文本居中对齐。
    -maxLines: 最大行数为1。
    -overflow: 溢出处理为省略号。
    】】】
 *
 */
class ToastDialogPage extends StatefulWidget {
  ToastDialogPage({
    Key? key,
    required this.information,
    required this.seconds,
  }) : super(key: key);
  final String information;
  final int seconds;

  @override
  _ToastDialogPageState createState() => _ToastDialogPageState();
}

class _ToastDialogPageState extends State<ToastDialogPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 启动定时器
    _timer = Timer(Duration(seconds: widget.seconds), () {
      _timer?.cancel();
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    // 取消定时器
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        0,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        70,
        0,
        70,
        0,
      ),
      titlePadding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        0,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100.h,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color:
              Colors.black.withValues(alpha: context.isDarkMode ? 0.95 : 0.7),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Text(
            widget.information,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
            // maxLines: 1,
            //  overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
