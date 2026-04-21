

class BetAppointUtil {
  /// 足球、电子足球
  static const csidFootball = [1, 90];

  /// 篮球、电子篮球
  static const csidBasketball = [2, 91];

  static const appointBallValueRangeConfigBasketball = {
    // // 足球
    // sportId_1: {
    //   //让球
    //   rang_qiu: {
    //     "min": -10,
    //     "max": 10,
    //   },
    //   //大小
    //   da_xiao: {
    //     "min": 0,
    //     "max": 30,
    //   },
    // },
    //篮球
    
      "39": {
        "min": -100.5,
        "max": 100.5,
      },
      "19": {
        "min": -100.5,
        "max": 100.5,
      },
      "143": {
        "min": -100.5,
        "max": 100.5,
      },
      "46": {
        "min": -50.5,
        "max": 50.5,
      },
      "52": {
        "min": -50.5,
        "max": 50.5,
      },
      "58": {
        "min": -50.5,
        "max": 50.5,
      },
      "64": {
        "min": -50.5,
        "max": 50.5,
      },
      "38": {
        "min": 50.5,
        "max": 300.5,
      },
      "18": {
        "min": 25.5,
        "max": 300.5,
      },
      "26": {
        "min": 25.5,
        "max": 300.5,
      },
      "45": {
        "min": 0,
        "max": 100.5,
      },
      "51": {
        "min": 0,
        "max": 100.5,
      },
      "57": {
        "min": 0,
        "max": 100.5,
      },
      "63": {
        "min": 0,
        "max": 100.5,
      },
    
  };

  /// 足球让球玩法
  static const marketRangFlagList = [
    '3', //全场让球胜平负
    '4', //全场让球
    '19', //半场让球
    '33', //15分钟进球-让球({a}-{b})
    '71', //下半场让球胜平负
    '113', //角球让球
    '121', //上半场角球让球
    '128', //加时赛-让球
    '130', //加时赛-上半场让球
    '143', //下半场让球
    '232', //15分钟角球-让球({a}-{b})
    '269', //全场让球
    '270', //半场让球
    '324', //黄牌让分
    '327', //上半场黄牌让分
  ];

  /// 篮球可预约盘口值玩法（让分）
  static const basketballLet = [
    '4', //让分(不含加时)
    '19', //上半场让分
    '39', //让分
    '46', //第1节让分
    '52', //第2节让分
    '58', //第3节让分
    '64', //第4节让分
    '143', //下半场让分
  ];

  /// 篮球可预约盘口值玩法（总分）
  static const basketballTotal = [
    '2', //总分(不含加时)
    '4', //让分(不含加时)
    '10', //{主队}总分(不含加时)
    '11', //{客队}总分(不含加时)
    '18', //上半场总分
    '19', //上半场让分
    '26',//下半场总分
    '38',//总分
    '39',//让分
    '45',//第1节总分
    '46', //第1节让分
    '51', //第2节总分
    '52', //第2节让分
    '57', //第3节总分
    '58', //第3节让分
    '63', //第4节总分
    '64', //第4节让分
    '87', //上半场{主队}总分
    '88', //下半场{主队}总分
    '97', //上半场{客队}总分
    '98', //下半场{客队}总分
    '143', //下半场让分
    '198', //{主队}总分
    '199', //{客队}总分
    '145',
    '146',
    '220',// 球员得分
    '221',// 球员三分球
    '271',// 球员助攻
    '272',// 球员篮板
  ];

  //要添加球头值下限的大小玩法(全场)
  static const MARKET_BIG_SMALL_PLAY_LIST = [
    '2', //全场大小
    '18',//半场大小
    '26',//下半场大小
    '34',//15分钟进球-大小({a}-{b})
    '114',//角球大小
    '122',//上半场角球大小
    '127',//加时赛-大小
    '134',//点球大战-大小
    '233',//15分钟角球-大小({a}-{b})
    '307',//罚牌大小
    '309',//上半场罚牌大小
    '325',//黄牌大小
    '328',//上半场黄牌大小
    '331',//加时赛-角球大小
    '332',//加时赛-上半场大小
    '335',//点球大战-前5轮大小
    '10',//点球大战-前5轮大小
    '97',//点球大战-前5轮大小
    '11',//点球大战-前5轮大小
    '87',//点球大战-前5轮大小
    '88',//点球大战-前5轮大小
    '98',//点球大战-前5轮大小
  ];
  //要添加球头值下限的大小玩法(主队)
  static const MARKET_HOME_PLAY_LIST = [
    '10',//{主队}进球大小
    '87',//上半场{主队}进球大小
    '88',//下半场{主队}进球大小
    '115',//{主队}角球大小
    '123',//上半场{主队}角球大小
    '314',//{主队}罚牌大小
    '316',//上半场{主队}罚牌大小
  ];
  //要添加球头值下限的大小玩法(客队)
  static const MARKET_AWAY_PLAY_LIST = [
    '11',//{客队}进球大小
    '97',//上半场{客队}进球大小
    '98',//下半场{客队}进球大小
    '116',//{客队}角球大小
    '124',//上半场{客队}角球大小
    '315',//{客队}罚牌大小
    '317',//上半场{客队}罚牌大小
  ];


  /// 获取最大值
  static double getMax(int csid, String hpid) {
    if (csidFootball.contains(csid)) {
      if (_isFootballLetBall(hpid)) {
        return 10;
      } else {
        return 30;
      }
    } else if (csidBasketball.contains(csid)) {
      var maxValue = appointBallValueRangeConfigBasketball[hpid]?["max"];
      if(maxValue != null){
        return maxValue.toDouble();
      }
      else if (_isLetBall(hpid)) {
        return 99.5;
      } else if (_isTotalScore(hpid)) {
        return 400.5;
      }
    }
    return 0;
  }

  /// 获取最小值，currentScore 格式 "1:0"
  static double getMin(int csid, String hpid, String currentScore) {
    int scoreHome = 0;
    int scoreAway = 0;
    if (currentScore.isNotEmpty && currentScore.contains(':')) {
      var arr = currentScore.split(':');
      scoreHome = int.tryParse(arr[0]) ?? 0;
      scoreAway = int.tryParse(arr[1]) ?? 0;
    }

    if (csidFootball.contains(csid)) {
      if (_isFootballLetBall(hpid)) {
        return -10;
      } else {
        if(MARKET_BIG_SMALL_PLAY_LIST.contains(hpid)) {
          return scoreHome + scoreAway + 0.5;
        }else if(MARKET_HOME_PLAY_LIST.contains(hpid)){
          return scoreHome + 0.5;
        }else if(MARKET_AWAY_PLAY_LIST.contains(hpid)){
          return scoreAway + 0.5;
        }else{
          return 0.5;
        }
      }
    } else if (csidBasketball.contains(csid)) {
      var minValue = appointBallValueRangeConfigBasketball[hpid]?["min"];
      if(minValue != null){
        return minValue.toDouble();
      }
      else if (_isLetBall(hpid)) {
        return -99.5;
      } else if (_isTotalScore(hpid)) {
        return 50.5;
      }
    }
    return 0;
  }

  /// 计算加/减后的值
  /// current: "1/1.5"
  static String calcNextValue(int csid, String hpid, String current, bool isAdd) {
    String addPlus = "";
    double step = csidFootball.contains(csid) ? 0.25 : 1;

    double value = _toDoubleAverage(current);
    double next = isAdd ? value + step : value - step;

    // 足球盘口格式
    if (csidFootball.contains(csid)) {
      // 四分之一球
      if (next % 0.5 != 0) {
        double low = next - 0.25;
        double high = next + 0.25;
        if(_isFootballLetBall(hpid)) {
          if (low >= 0) {
            addPlus = "+";
          }
          //负数盘口需要反一下，绝对值大的放后面
          if(high < 0){
            double temp = low;
            low = high;
            high = -temp;
          }else if(high == 0){
            high = -low;
            low = 0;
            addPlus = "-";
          }
        }
        return '$addPlus${_trim(low)}/${_trim(high)}';
      }

      if(next > 0 && _isFootballLetBall(hpid)){
        addPlus = "+";
      }
      // 整数 / 半球
      return '$addPlus${_trim(next)}';
    }

    if(next > 0 && _isLetBall(hpid)){
      addPlus = "+";
    }
    // 篮球直接数值
    return '$addPlus${_trim(next)}';
  }

  /// 判断能否加
  static bool canAdd(int csid, String hpid, String current, String currentScore) {
    double max = getMax(csid, hpid);
    String next = calcNextValue(csid, hpid, current, true);
    double nextValue = _toDoubleAverage(next);
    return nextValue <= max;
  }

  /// 判断能否减
  static bool canSubtract(int csid, String hpid, String current, String currentScore) {
    double min = getMin(csid, hpid, currentScore);
    String next = calcNextValue(csid, hpid, current, false);
    double nextValue = _toDoubleAverage(next);
    return nextValue >= min;
  }

  /// 辅助：将 "1/1.5" 或 "2" 转成平均值 double
  static double _toDoubleAverage(String value) {
    if (value.contains('/')) {
      var arr = value.split('/');
      double v1 = double.tryParse(arr[0]) ?? 0;
      double v2 = double.tryParse(arr[1]) ?? 0;
      if(value.trimLeft().startsWith('-')){
        //负号 两边都加
        v2 = -v2;
      }
      return (v1 + v2) / 2;
    } else {
      return double.tryParse(value) ?? 0;
    }
  }

  /// 去掉多余的 .0 / .00
  static String _trim(double v) {
    if (v % 1 == 0) {
      return v.toInt().toString();
    }
    return v.toString();
  }

  /// 判断是否为篮球让分玩法
  static bool _isLetBall(String hpid) => basketballLet.contains(hpid);

  /// 判断是否为篮球总分玩法
  static bool _isTotalScore(String hpid) => basketballTotal.contains(hpid);

  /// 判断是否为足球让球玩法
  static bool _isFootballLetBall(String hpid) => marketRangFlagList.contains(hpid);

  /*
   *是否可以修改盘口
   */
  static bool canChangeHandicap(int sportId, int playId) {
    //足球
    if (sportId == 1) {
      return [4, 19, 143, 2, 18, 26, 10, 11, 87, 88, 97, 98].contains(playId);
    } else if (sportId == 2) {
      //篮球
      return [39, 19, 143, 46, 52, 58, 64, 38, 18, 26, 45, 51, 57, 63]
          .contains(playId);
    }

    return false;
  }
}
