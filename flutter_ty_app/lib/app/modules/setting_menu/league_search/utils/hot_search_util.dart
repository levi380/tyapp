


class HotSearchUtil {
  static String handelHotSearchForLang(Map<String,dynamic> map) {
    // String lang = getLang();
    // if(lang == 'zh') {
    //   lang = 'keyWord';
    // } else if (lang == 'tw') {
    //   lang = 'zh';
    // } else if (lang == 'en') {
    //   lang = 'es';
    // } else if(lang == 'es') {
    //   lang  = 'ess';
    // }
    return map['keyWord'];
  }
}