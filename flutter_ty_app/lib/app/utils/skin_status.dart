/// 定义枚举（目前只有暗黑模式下3种，后面有再加）
enum Status {
  BLACK_STYLE_1('assets/images/home/color_background_skin.png'), //默认的肤色
  BLACK_STYLE_2('assets/images/bg2.png'),
  BLACK_STYLE_3('assets/images/bg3.png');

  final String bgUri;
  const Status(this.bgUri);
}