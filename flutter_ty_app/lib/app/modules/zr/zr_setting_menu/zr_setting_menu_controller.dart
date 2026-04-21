import '../../../services/api/zr_api.dart';
import '../../../utils/systemchrome.dart';
import '../../home/controllers/home_controller.dart';
import '../../login/login_head_import.dart';
import 'zr_setting_menu_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fdd890e9-4ed9-4012-9685-8c670ec4ed37-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人娱乐设置菜单 控制器 ZrSettingMenuController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人娱乐设置菜单 控制器 ZrSettingMenuController
    - ZrSettingMenuController
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
class ZrSettingMenuController extends GetxController {
  final ZrSettingMenulogic logic = ZrSettingMenulogic();

  ///游戏语音
  double gameVoice = 1.0;

  ///游戏音效
  double gameSoundEffects = 1.0;

  ///现场声音
  double liveSound = 1.0;

  ///路纸模式 1 浅色 2 深色
  int pathPaperMode = 1;

  @override
  void onInit() {
    // TODO: implement onInit
    initData();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> initData() async {
    Get.isDarkMode ? logic.themeStyle = 1 : logic.themeStyle = 0;
    logic.themeStyle = Get.isDarkMode ? 2 : 1;
    logic.isDarkMode = Get.isDarkMode ? true : false;

    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;

    final res = await ZrApi.instance().getUserInfoZr(
      timestamp.toString(),
    );

    for (int i = 0; i < res.data.playerSettingList.length; i++) {
      if (res.data.playerSettingList[i].settingType == 1 &&
          res.data.playerSettingList[i].settingObject == 31 &&
          res.data.playerSettingList[i].deviceType == 2) {
        /// 路纸颜色 1：深色，2：浅色
        pathPaperMode = res.data.playerSettingList[i].value == '1' ? 2 : 1;
      } else if (res.data.playerSettingList[i].settingType == 1 &&
          res.data.playerSettingList[i].settingObject == 33 &&
          res.data.playerSettingList[i].deviceType == 6) {
        ///声音总开关 0：关闭，1：开启
        logic.soundSwitch = res.data.playerSettingList[i].value == '1' ? true : false;
      } else if (res.data.playerSettingList[i].settingType == 1 &&
          res.data.playerSettingList[i].settingObject == 2 &&
          res.data.playerSettingList[i].deviceType == 6) {
        ///语音语言 1：普通话，2：普通话(林志玲)，3：英语，4：越南语，5：泰语
        logic.phoneticLanguageIndex =
            int.parse(res.data.playerSettingList[i].value) - 1;
        logic.phoneticLanguage = logic.gameSoundEffectsList[logic.phoneticLanguageIndex];
      } else if (res.data.playerSettingList[i].settingType == 1 &&
          res.data.playerSettingList[i].settingObject == 5 &&
          res.data.playerSettingList[i].deviceType == 2) {
        ///游戏语音 1~100区间中取值
        gameVoice = double.parse(res.data.playerSettingList[i].value) == 0.0
            ? 1.0
            : double.parse(res.data.playerSettingList[i].value);
      } else if (res.data.playerSettingList[i].settingType == 1 &&
          res.data.playerSettingList[i].settingObject == 6 &&
          res.data.playerSettingList[i].deviceType == 2) {
        ///游戏音效 1~100区间中取值
        gameSoundEffects =
            double.parse(res.data.playerSettingList[i].value) == 0.0
                ? 1.0
                : double.parse(res.data.playerSettingList[i].value);
      } else if (res.data.playerSettingList[i].settingType == 1 &&
          res.data.playerSettingList[i].settingObject == 7 &&
          res.data.playerSettingList[i].deviceType == 2) {
        ///现场声音 1~100区间中取值
        liveSound = double.parse(res.data.playerSettingList[i].value) == 0.0
            ? 1.0
            : double.parse(res.data.playerSettingList[i].value);
      } else if (res.data.playerSettingList[i].settingType == 1 &&
          res.data.playerSettingList[i].settingObject == 4 &&
          res.data.playerSettingList[i].deviceType == 6) {
        ///视频设定 0：视频关闭，1：视频开启
        logic.videoSettings =
            res.data.playerSettingList[i].value == '1' ? true : false;
      } else if (res.data.playerSettingList[i].settingType == 1 &&
          res.data.playerSettingList[i].settingObject == 8 &&
          res.data.playerSettingList[i].deviceType == 6) {
        ///快速投注 0：开启，1：关闭
        logic.quickBet = res.data.playerSettingList[i].value == '0' ? true : false;
      }

      update();
    }
  }

  ///主题风格
  onThemeStyle(int theme) {
    logic.themeStyle = theme;
    Get.changeThemeMode(theme == 1 ? ThemeMode.light : ThemeMode.dark);
    BoolKV.theme.save(Get.isDarkMode);
    TyHomeController.to.homeState.isLight = theme == 2 ? false : true;
    TyHomeController.to.update();
    logic.isDarkMode = theme == 2 ? true : false;
    SystemUtils.isDarkMode(theme == 2 ? true : false);
    update();
  }

  ///路纸模式
  onPathPaperMode(int theme) {
    pathPaperMode = theme;
    update();
  }

  ///声音开关
  onSoundSwitch() {
    logic.soundSwitch = !logic.soundSwitch;
    update();
  }

  ///现场视频
  onVideoSettings() {
    logic.videoSettings = !logic.videoSettings;
    update();
  }

  ///快速投注
  onQuickBet() {
    logic.quickBet = !logic.quickBet;
    update();
  }

  ///现场声音
  onLiveSoundViceChanged(volume) {
    liveSound = volume;
    update();
  }

  ///游戏音效
  onGameSoundEffectsViceChanged(volume) {
    gameSoundEffects = volume;
    update();
  }

  ///游戏语音
  onGameVoiceViceChanged(volume) {
    gameVoice = volume;
    update();
  }

  ///游戏音效菜单
  onSelectedItemChanged(int index) {
    logic.phoneticLanguageIndex = index;
    logic.phoneticLanguage = logic.gameSoundEffectsList[index];
    update();
  }

  toClose() async {
    Get.back();
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;
    final res = await ZrApi.instance().saveUserInfoZr(
      {
        'playerSettingList': [
          /// 路纸颜色 1：深色，2：浅色
          {
            "settingType": 1,
            "settingObject": 31,
            "deviceType": 2,
            "value": pathPaperMode == 1 ? 2 : 1,
          },

          ///主题风格 0：夜间皮肤，1：日间皮肤，2：自动切换
          {
            "settingType": 1,
            "settingObject": 3,
            "deviceType": 2,
            "value": Get.isDarkMode ? 0 : 1,
          },

          ///声音总开关 0：关闭，1：开启
          {
            "settingType": 1,
            "settingObject": 33,
            "deviceType": 6,
            "value": logic.soundSwitch == true ? 1 : 0,
          },

          ///语音语言 1：普通话，2：普通话(林志玲)，3：英语，4：越南语，5：泰语
          {
            "settingType": 1,
            "settingObject": 2,
            "deviceType": 6,
            "value": logic.phoneticLanguageIndex + 1
          },

          ///游戏语音 1~100区间中取值
          {
            "settingType": 1,
            "settingObject": 5,
            "deviceType": 2,
            "value": gameVoice.toStringAsFixed(0)
          },

          ///游戏音效 1~100区间中取值
          {
            "settingType": 1,
            "settingObject": 6,
            "deviceType": 2,
            "value": gameSoundEffects.toStringAsFixed(0),
          },

          ///现场声音 1~100区间中取值
          {
            "settingType": 1,
            "settingObject": 7,
            "deviceType": 2,
            "value": liveSound.toStringAsFixed(0),
          },

          ///现场视频 0：视频关闭，1：视频开启
          {
            "settingType": 1,
            "settingObject": 4,
            "deviceType": 6,
            "value": logic.videoSettings == true ? 1 : 0,
          },

          ///快速投注 0：开启，1：关闭
          {
            "settingType": 1,
            "settingObject": 8,
            "deviceType": 6,
            "value": logic.quickBet == true ? 0 : 1
          }
        ],
        'timestamp': timestamp
      },
    );

    if (kDebugMode) {
      print(res);
    }
  }
}
