import '../../../db/app_cache.dart';
import '../../../services/api/language_api.dart';

class LanguageState {
  LanguageState() {
    ///Initialize variables
  }

  /*
    "中文简体" (中文 - 简体)
    "繁體中文" (中文 - 繁体)
    "English" (英语)
    "Tiếng Việt" (越南语)
    "ไทย" (泰语)
    "Melayu" (马来语)
    "Indonesia" (印尼语)
    "Português" (葡萄牙语)
    "한국어" (韩语)
    "Español" (西班牙语)
    "မြန်မာ" (缅甸语)
    "العربية" (阿拉伯语)
    "русский" (俄语)
    "हिन्दी" (印地语)

   Locale('zh', 'CN'),  ///中文-简体
   Locale('zh', 'TW'),  ///中文-繁体
   Locale('en', 'GB'),  ///英式-英语
   Locale('vi', 'VN'),  ///越南
   Locale('th', 'TH'),  ///泰国
   Locale('ms', 'MY'),  ///马来西亚
   Locale('id', 'ID'),  ///印尼语
   Locale('pt', 'PT'),  ///葡萄牙
   Locale('ko', 'KR'),  ///韩国
   Locale('es', 'ES'),  ///西班牙语
   Locale('my', 'MM'),  ///缅甸语
   Locale('ar', 'AE'),  ///阿拉伯语
   Locale('ru', 'RU'),  ///俄语
   Locale('hi', 'IN'),  ///印地语
*/
  bool changelan = false;

  //语言标题
  List<String> itemName = [
    "中文简体",
    "繁體中文",
    "English",
    //越南语
    "Tiếng Việt",
    //泰语
    "ไทย",
    //马来语
    "Melayu",
    //印尼语
    "Indonesia",
    //葡萄牙语
    "Português",
    //韩语
    "한국어",
    //西班牙语
    "Español",
    //缅甸语
    "မြန်မာ",
    // //阿拉伯语
    "العربية",
    // //俄语
    "русский",
    //印地语
    "हिन्दी"
  ];

//图标
  List<String> itemIcon = [
    "assets/images/language/zh_cn_new.png",
    "assets/images/language/zh_tw_new.png",
    "assets/images/language/en_gb_new.png",
    "assets/images/language/vi_vn_new.png",
    "assets/images/language/th_th_new.png",
    "assets/images/language/ms_my_new.png",
    "assets/images/language/id_id_new.png",
    "assets/images/language/pt_pt_new.png",
    "assets/images/language/ko_ko_new.png",
    "assets/images/language/es_es_new.png",
    "assets/images/language/my_mm_new.png",
    "assets/images/language/ae_ae_new.png",
    "assets/images/language/ru_ru_new.png",
    "assets/images/language/rn_rn_new.png",
  ];

//存储语言
  final List<String> itemLanguage = [
    "CN",
    "TW",
    "GB",
    "VN",
    "TH",
    "MY",
    "ID",
    "PT",
    "KR",
    "ES",
    "MM",
    "AE",
    "RU",
    "IN"
  ];

  List<String> itemIconEuropeanCup = [
    "assets/images/language/zh_cn_new.png",
    "assets/images/language/en_gb_new.png",
  ];

  final List<String> itemNameEuropeanCup = [
    "中文简体",
    "English",
  ];

  final List<String> itemLanguageEuropeanCup = [
    "CN",
    "GB",
  ];

  /**
   * 设置语言请求
   */
  setUserLanguage(String languageName) async {
    String token = StringKV.token.get() ?? "";
    final res =
        await LanguageApi.instance().setUserLanguage(token, languageName);
    String code = res.code;
    if (code == "0000000") {
      //   print("LanguageLogic----------"+res.msg);
      //切换语言成功。
    }
  }
}
