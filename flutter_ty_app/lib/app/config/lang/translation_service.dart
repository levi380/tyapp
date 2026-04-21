
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../generated/locales.g.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9236b86d-2f93-40b7-a267-6fcfe0acb8fe-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  国际化多语言配置  】】】
    【【【 AUTO_PARAGRAPH_TITLE 国际化多语言配置  TranslationService 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 国际化多语言配置  TranslationService
    - TranslationService
    ```
    ///中文-简体
    Locale('zh', 'CN'),
    ///中文-繁体
    Locale('zh', 'TW'),

    ///英式-英语
    Locale('en', 'GB'),

    ///越南
    Locale('vi', 'VN'),

    ///泰国
    Locale('th', 'TH'),

    ///马来西亚
    Locale('ms', 'MY'),

    ///印尼语
    Locale('id', 'ID'),

    ///葡萄牙
    Locale('pt', 'PT'),

    ///韩国
    Locale('ko', 'KR'),

    ///西班牙语
    Locale('es', 'ES'),

    ///缅甸语
    Locale('my', 'MM'),

    ///阿拉伯语
    Locale('ar', 'AE'),

    ///俄语
    Locale('ru', 'RU'),

    ///印地语
    Locale('hi', 'IN'),

    ///设置菜单特殊繁译
    Locale('zh', 'HANS'),

    ```
    】】】
 *
 */

class TranslationService extends Translations {
  static const fallbackLocale = Locale('zh', 'CN');
  static Map<String, Map<String, String>> translations = {};

  static Locale getInitLocale() {
    String language = StringKV.language.get() ?? "";
    if (language.isNotEmpty) {
      if (language.contains('CN')) {
        return const Locale('zh', 'CN'); ///中文-简体
      } else if (language.contains('GB')) {
        return const Locale('en', 'GB');  ///英式-英语
      } else if (language.contains('TW')) {
        return const Locale('zh', 'TW');  ///中文-繁体
      } else if (language.contains('VN')) {
        return const Locale('vi', 'VN');  ///越南
      }else if (language.contains('TH')) {
        return const Locale('th', 'TH');  ///泰国
      }else if (language.contains('MY')) {
        return const Locale('ms', 'MY');  ///马来西亚
      }else if (language.contains('KR')) {
        return const Locale('ko', 'KR');   ///韩国
      }else if (language.contains('PT')) {
        return const Locale('pt', 'PT');  ///葡萄牙
      }else if (language.contains('PT')) {
        return const Locale('id', 'ID'); ///印尼语
      }else if (language.contains('ES')) {
        return const Locale('es', 'ES'); ///西班牙语
      }else if (language.contains('MM')) {
        return const  Locale('my', 'MM'); ///缅甸语
      }else if (language.contains('ar')) {
        return const  Locale('ar', 'AE');  ///阿拉伯语
      }else if (language.contains('RU')) {
        return const  Locale('ru', 'RU');  ///俄语
      }else if (language.contains('IN')) {
        return const  Locale('hi', 'IN');  ///印地语
      }else if (language.contains('HANS')) {
        return const  Locale('zh', 'HANS');  ///设置菜单特殊繁译
      }
    }
    //首次没是语言设置默认设置中文简体
    StringKV.language.save("CN");
    return fallbackLocale;

  }

  @override
  Map<String, Map<String, String>> get keys {
    if (translations.isEmpty) {
      Get.translations.forEach((key, value) {
        translations[key] = Map<String, String>.from(value);
      });
      AppTranslation.translations.forEach((key, value) {
        translations.putIfAbsent(key, () => <String, String>{});
        translations[key]!.addAll(value);
      });
    }
    return translations;
  }
}
