
import '../modules/login/login_head_import.dart';

class TextUtitls{
 static Widget normalText(String text,{Color? color,double? fontSize,String? fontFamily,FontWeight? fontWeight,TextAlign? textAlign ,double? height} ){
    return   Text(
      text,
      textAlign: textAlign??TextAlign.center,
      style: TextStyle(
        color: color??Colors.white,
        fontSize: fontSize??14,
        fontFamily: fontFamily??'PingFang SC',
        fontWeight: fontWeight??FontWeight.w500,
        height: height??0
      ),
    );
  }
}