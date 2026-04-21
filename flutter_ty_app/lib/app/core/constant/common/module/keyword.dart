import 'package:flutter_ty_app/generated/locales.g.dart';

/**
 * 投注快捷金额
 *
 */
const keyboard = [
  {
    'text': "5",
    'value': 5,
    'disabled': false
  },
  {
    'text': "10",
    'value': 10, // 数值
    'disabled': false // 禁用
  },
  {
    'text': "25",
    'value': 25,
    'disabled': false
  },
  {
    'text': "50",
    'value': 50,
    'disabled': false
  },
  {
    'text': "100",
    'value': 100,
    'disabled': false
  },
  {
    'text': "200",
    'value': 200,
    'disabled': false
  }
];

// 盘 对应关系
const odds_type_name = {
  "EU": LocaleKeys.odds_EU, //欧洲盘
  "ID": LocaleKeys.odds_ID, //印尼盘
  "US": LocaleKeys.odds_US, //美式盘
  "MY": LocaleKeys.odds_MY, //马来盘
  "GB": LocaleKeys.odds_GB, //英式盘
  "HK": LocaleKeys.odds_HK, //香港盘
};

// 币种对应关系
const Map<int, String> currency_code = {
  1: 'RMB',
  2: "USD",
  3: "HKD",
  4: "VND",
  5: "SGD",
  6: "GBP",
  7: "EUR",
  8: "RMB",
  9: "TWD",
  10: "JPY",

  11: "PHP",
  12: "KRW",
  13: "AUD",
  14: "CAD",
  15: "AED",
  16: "MOP",
  17: "DZD",
  18: "OMR",
  19: "EGP",
  20: "RUB",

  21: "IDR",
  22: "MYR",
  23: "VND",
  24: "INR",
  25: "IDR",
  26: "THB",
  27: "BND",
  28: "CEO",
  29: "BRL",
  30: "COP",

  31: "TRY",
  32: "RMB",
  33: "MMK",
  34: "AFN",
  35: "ALL",
  36: "AMD",
  37: "ANG",
  38: "AOA",
  39: "ARS",
  40: "AWG",

  41: "AZN",
  42: "BAM",
  43: "BBD",
  44: "BDT",
  45: "BGN",
  46: "BHD",
  47: "BIF",
  48: "BMD",
  49: "BOB",
  50: "BSD",

  51: "BTC",
  52: "BTN",
  53: "BWP",
  54: "BYN",
  55: "BZD",
  56: "CDF",
  57: "CHF",
  58: "CLF",
  59: "CLP",
  60: "CNH",

  61: "CRC",
  62: "CUC",
  63: "CUP",
  64: "CVE",
  65: "CZK",
  66: "DJF",
  67: "DKK",
  68: "DOP",
  69: "ERN",
  70: "ETB",

  71: "FJD",
  72: "FKP",
  73: "GEL",
  74: "GGP",
  75: "GHS",
  76: "GIP",
  77: "GMD",
  78: "GNF",
  79: "GTQ",
  80: "GYD",

  81: "HNL",
  82: "HRK",
  83: "HTG",
  84: "HUF",
  85: "ILS",
  86: "IMP",
  87: "IQD",
  88: "IRR",
  89: "ISK",
  90: "JEP",

  91: "JMD",
  92: "JOD",
  93: "KES",
  94: "KGS",
  95: "KHR",
  96: "KMF",
  97: "KPW",
  98: "KWD",
  99: "KYD",
  100: "KZT",


  101: 'LAK',
  102: "LBP",
  103: "LKR",
  104: "LRD",
  105: "LSL",
  106: "LYD",
  107: "MAD",
  108: "MDL",
  109: "MGA",
  110: "MKD",

  111: "MNT",
  112: "MRO",
  113: "MUR",
  114: "MVR",
  115: "MWK",
  116: "MXN",
  117: "MZN",
  118: "NAD",
  119: "NGN",
  120: "NIO",

  121: "NOK",
  122: "NPR",
  123: "NZD",
  124: "PAB",
  125: "PEN",
  126: "PGK",
  127: "PKR",
  128: "PLN",
  129: "PYG",
  130: "QAR",

  131: "RON",
  132: "RSD",
  133: "RWF",
  134: "SAR",
  135: "SBD",
  136: "SCR",
  137: "SDG",
  138: "SEK",
  139: "SHP",
  140: "SLL",

  141: "SOS",
  142: "SRD",
  143: "SSP",
  144: "STD",
  145: "STN",
  146: "SVC",
  147: "SYP",
  148: "SZL",
  149: "TJS",
  150: "TMT",

  151: "TND",
  152: "TOP",
  153: "TTD",
  154: "TZS",
  155: "UAH",
  156: "UGX",
  157: "UYU",
  158: "UZS",
  159: "VES",
  160: "VUV",

  171: "YER",
  172: "ZAR",
  173: "ZMW",
  174: "ZWL",
  175: "UGX",
  176: "TZS",
  177: "SYP",
  178: "RWF",
  179: "PYG",
  180: "MWF",

  181: "MNT",
  182: "MMK",
  183: "MGA",
  184: "LBP",
  185: "KRW",
  186: "KPW",
  187: "KHR",
  188: "IQD",
  189: "COP",
  //180: "CLP",
  190:  "CLP",

  191: "CDF",
  192: "BIF",
  193: "UZS",
  194: "STD",
  195: "SLL",
  196: "LAK",
  197: "IRR",
  198: "GNF",
  199: "RMB",
  200: "RMB",
  201: "USDT",
};