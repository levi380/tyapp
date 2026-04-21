import 'package:filbet/common/language.dart';
import 'package:filbet/services/global/global_service.dart';

class LanguageUtils{

  //<editor-fold desc="当前使用的语言">
  static String switchLanguage() {
    Language language = GlobalService.to.state.language;
    switch (language) {
      case Language.zh_cn:
        return "zh_CN";
      case Language.zh_tw:
        return "zh_TW";
      // case Language.en:
      //   return "en_US";
      // case Language.viet:
      //   return "vi_VN";
    }
  }
//</editor-fold>
}