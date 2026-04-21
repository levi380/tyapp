
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fdd890e9-4ed9-4012-9685-8c670ec4ed37-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人娱乐设置菜单 ZrSettingMenulogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人娱乐设置菜单 ZrSettingMenulogic
    - ZrSettingMenulogic
    - 包含-主题风格-语音语言-游戏语言-游戏音效-现场声音-现场视频-快速投注-等开关
    - 等逻辑处理
    ```
    ///主题风格 1：深色，2：浅色
    int themeStyle = 1;

    ///路纸模式 1 浅色 2 深色
    int pathPaperMode = 1;

    ///声音开关
    bool soundSwitch = true;

    ///现场视频
    bool videoSettings = true;

    ///游戏语音
    double gameVoice = 1.0;

    ///游戏音效
    double gameSoundEffects = 1.0;

    ///现场声音
    double liveSound = 1.0;

    ///快速投注
    bool quickBet = true;

    ///语言语言
    String phoneticLanguage = '普通话';
    int phoneticLanguageIndex = 1;
    List<String> gameSoundEffectsList = [
    '普通话',
    '普通话(林志玲)',
    'English',
    'Tiếng Việt',
    'แบบไทย',
    ];
    ```
    】】】
 *
 */
class ZrSettingMenulogic {

  bool isDarkMode = false;

  ///主题风格 1：深色，2：浅色
  int themeStyle = 1;



  ///声音开关
  bool soundSwitch = true;

  ///现场视频
  bool videoSettings = true;



  ///快速投注
  bool quickBet = true;

  ///语言语言
  String phoneticLanguage = '普通话';
  int phoneticLanguageIndex = 1;
  List<String> gameSoundEffectsList = [
    '普通话',
    '普通话(林志玲)',
    'English',
    'Tiếng Việt',
    'แบบไทย',
  ];


  ZrSettingMenulogic() {
    ///Initialize variables
  }
}
