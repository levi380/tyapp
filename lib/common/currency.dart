// const kUsdtSymbol = '₮';

// CNY = 101 // 人名币
// USD = 102 // 美元
// VND = 103 // 越南盾
// HKD = 104 // 港币
// KRW = 105 // 韩国币
// IDR = 106 // 印尼盾
// THB = 107 //泰铢
// MXN = 108 // 墨西哥币
// BRL = 109 // 巴西币
// INR = 110 // 印度币
// PHP=111 // 菲律宾比索
enum Currency {
  rmb;
  //usd,
  // vnd,
  // hkd,
  // krw,
  // idr,
  // thb,
  // mxn,
  // brl,
  // inr,
  // php;

  String get abbr {
    switch (this) {
      case Currency.rmb:
        return 'CNY';
      // case Currency.usd:
      //   return 'USD';
      // case Currency.vnd:
      //   return 'VND';
      //
      // case Currency.hkd:
      //   return 'HKD';
      // case Currency.krw:
      //   return 'KRW';
      // case Currency.idr:
      //   return 'IDR';
      // case Currency.thb:
      //   return 'THB';
      // case Currency.mxn:
      //   return 'MXN';
      // case Currency.brl:
      //   return 'BRL';
      // case Currency.inr:
      //   return 'INR';
      // case Currency.php:
      //   return 'PHP';
    }
  }

// 中文名称 货币代码 官方符号 符号位置
// 人民币 CNY ¥  左侧（¥100）
// 美元 USD $ 左侧（$100）
// 越南盾 VND ₫ 右侧（100₫）
// 港元 HKD HK$ 左侧（HK$100）
// 韩元 KRW ₩ 左侧（₩100）
// 印尼盾 IDR Rp 左侧（Rp100）
// 泰铢 THB ฿ 左侧（฿100）
// 墨西哥比索 MXN Mex$ 左侧（Mex$100 ）
// 巴西雷亚尔 BRL R$ 左侧（R$100）
// 印度卢比 INR ₹ 左侧（₹100）
// 菲律宾比索 PHP ₱ 左侧（₱100）

  String get symbol {
    switch (this) {
      case Currency.rmb:
        return '¥';
      // case Currency.usd:
      //   return '\$';
      // case Currency.vnd:
      //   return '₫';
      // case Currency.hkd:
      //   return 'HK\$';
      // case Currency.krw:
      //   return '₩';
      // case Currency.idr:
      //   return 'Rp';
      // case Currency.thb:
      //   return '฿';
      // case Currency.mxn:
      //   return 'Mex\$';
      // case Currency.brl:
      //   return 'R\$';
      // case Currency.inr:
      //   return '₹';
      // case Currency.php:
      //   return '₱';
    }
  }

  String get code {
    switch (this) {
      case Currency.rmb:
        return '101';
      // case Currency.usd:
      //   return '102';
      // case Currency.vnd:
      //   return '103';
      // case Currency.hkd:
      //   return '104';
      // case Currency.krw:
      //   return '105';
      // case Currency.idr:
      //   return '106';
      // case Currency.thb:
      //   return '107';
      // case Currency.mxn:
      //   return '108';
      // case Currency.brl:
      //   return '109';
      // case Currency.inr:
      //   return '110';
      // case Currency.php:
      //   return '111';
      default:
        return '101';
    }
  }

  static Currency fromCodeString(String code) {
    switch (code) {
      case '101':
        return Currency.rmb;
      // case '102':
      //   return Currency.usd;
      // case '103':
      //   return Currency.vnd;
      // case '104':
      //   return Currency.hkd;
      // case '105':
      //   return Currency.krw;
      // case '106':
      //   return Currency.idr;
      // case '107':
      //   return Currency.thb;
      // case '108':
      //   return Currency.mxn;
      // case '109':
      //   return Currency.brl;
      // case '110':
      //   return Currency.inr;
      // case '111':
      //   return Currency.php;
      default:
        return Currency.rmb; // 或抛异常
    }
  }

  static Currency fromCodeInt(int code) {
    switch (code) {
      case 101:
        return Currency.rmb;
      // case 102:
      //   return Currency.usd;
      // case 103:
      //   return Currency.vnd;
      // case 104:
      //   return Currency.hkd;
      // case 105:
      //   return Currency.krw;
      // case 106:
      //   return Currency.idr;
      // case 107:
      //   return Currency.thb;
      // case 108:
      //   return Currency.mxn;
      // case 109:
      //   return Currency.brl;
      // case 110:
      //   return Currency.inr;
      // case 111:
      //   return Currency.php;
      default:
        return Currency.rmb; // 或抛异常
    }
  }

  static Currency fromAbbr(String abbr) {
    switch (abbr.toUpperCase()) {
      case 'CNY':
        return Currency.rmb;
      // case 'USD':
      //   return Currency.usd;
      // case 'VND':
      //   return Currency.vnd;
      // case 'HKD':
      //   return Currency.hkd;
      // case 'KRW':
      //   return Currency.krw;
      // case 'IDR':
      //   return Currency.idr;
      // case 'THB':
      //   return Currency.thb;
      // case 'MXN':
      //   return Currency.mxn;
      // case 'BRL':
      //   return Currency.brl;
      // case 'INR':
      //   return Currency.inr;
      // case 'PHP':
      //   return Currency.php;
      default:
        return Currency.rmb; // 或抛异常
    }
  }
}
