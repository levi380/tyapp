// ignore_for_file: constant_identifier_names

enum Language {
  zh_cn,
  // en,
  // viet,
  zh_tw;

  String get name {
    switch (this) {
      case Language.zh_cn:
        return '简体中文';
      // case Language.en:
      //   return 'English';
      // case Language.viet:
      //   return 'Tiếng Việt';
      case Language.zh_tw:
        return '繁体中文';
    }
  }

  String get code {
    switch (this) {
      case Language.zh_cn:
        return 'zh_CN';
      // case Language.en:
      //   return 'en_US';
      // case Language.viet:
      //   return 'vi_VN';
      case Language.zh_tw:
        return 'zh_TW';
    }
  }

  String get abbr {
    switch (this) {
      case Language.zh_cn:
        return 'zh_CN';
      // case Language.en:
      //   return 'en_US';
      // case Language.viet:
      //   return 'vi_VN';
      case Language.zh_tw:
        return 'zh_TW';
    }
  }

  static Language fromAbbr(String abbr) {
    switch (abbr) {
      case 'zh_CN':
        return Language.zh_cn;
      // case 'en_US':
      //   return Language.en;
      // case 'vi_VN':
      //   return Language.viet;
      case 'zh_TW':
        return Language.zh_tw;
      default:
        return Language.zh_cn;
    }
  }
}
