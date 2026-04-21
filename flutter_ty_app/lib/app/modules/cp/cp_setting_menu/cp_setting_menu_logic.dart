
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-865e55c5-ff96-400e-9c5b-fa97bce48a09-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票设置菜单  CpSettingMenulogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票设置菜单  CpSettingMenulogic
    - CpSettingMenuPage
    - 包含-主题风格-音效-中奖提示-主题风格-游戏玩法投注金额区间
    ```
    ///主题风格 1日间 2夜间
    int themeStyle = 1;

    ///音效
    bool countDownBeep = false;

    ///中奖提示
    bool winModal = false;

    ///冷热提示
    bool coldHot = false;

    ///遗留提示
    bool missRemind = false;

    ///立即投注确认弹窗
    bool doubleBetConfirm = false;
    ```
    】】】
 *
 */

class CpSettingMenulogic {

  ///主题风格 1日间 2夜间
  int themeStyle = 1;

  ///音效
  bool countDownBeep = false;

  ///中奖提示
  bool winModal = false;

  ///冷热提示
  bool coldHot = false;

  ///遗留提示
  bool missRemind = false;

  ///立即投注确认弹窗
  bool doubleBetConfirm = false;

  int doubleSidedPlayId = 0;

  int featuredGamesId = 0;

  CpSettingMenulogic() {
    ///Initialize variables
  }
}
