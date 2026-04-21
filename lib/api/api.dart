import 'package:filbet/utils/app_config.dart';

class Api {
  static String get imageurl => AppEnvConfig.instance.imageUrl;

  // 游戏场馆
  static const String platformList = "/member/game/platform/list";
  static const String platformListNew = "/member/vip/rebate/platform/name";

  static const String refreshtoken = "/member/refresh/token";

//  static const String currencystatus = "/finance/currency/status";

  // 游戏场馆点击
  static const String platformClick = "/member/game/platform/click";

  // tg登录获取botid
  static const String tgLoginGetBotId = "/member/tgauth/botid";

  // tg登录
  static const String tgLogin = "/member/login/tgauth";

  // 游戏场馆点击
  static const String platformLiveWin = "/member/game/live/win";

  // 游戏场馆点击
  static const String platformOne = "/member/game/platform/one";

  // 会员信息更新
  static const String userinfoUpdate = "/member/detail/update";

  //会员VIP信息
  static const String membervipinfo = "/member/vip/user/info";
  static const String memberviptextdata = "/member/vip/text/data";
  static const String membervipgiftlist = "/member/vip/gift/list";
  static const String membervipsetting = "/member/vip/setting";
  static const String memberviprebatelist = "/member/vip/rebate/list";

  //VIP晋级优惠配置列表
  static const String memberVipPromotionList = "/member/vip/promotion/list";
  static const String memberVipPromotionApply = "/member/vip/promotion/apply";
  static const String memberVipRebateGames =
      "/member/vip/rebate/platform/games";
  static const String memberVipConfig = "/member/vip/config";

  // 会员信息
  static const String userinfo = "/member/detail";
  static const String customerservice = "/member/customer/service/list";
  static const String memberreport = "/member/report";
  static const String currencyChange = "/finance/currency/change";

  // 删除消息
  static const String messageDelete = "/member/v3/notify/delete";

  //消息列表
  static const String messageList = "/member/v3/notify/list";

  //修改消息已读
  static const String messageReadList = '/member/v3/notify/readlist';

  //公告列表首页
  static const String noticeListAll = "/member/v3/notice/all";

  //公告列表
  static const String noticeListV2 = "/member/v3/notice/list";

  //修改公告已读
  static const String noticeReadListV2 = '/member/v3/notice/readlist';

  // 删除通知
  static const String noticeDeleteV2 = "/member/v3/notice/delete";

  //消息列表V2
  static const String messageListV2 = "/member/v3/message/list";

  //修改消息V2已读
  static const String messageReadListV2 = '/member/v3/message/readlist';

  // 删除消息V2
  static const String messageDeleteV2 = "/member/v3/message/delete";

  // 注册
  static const String register = "/member/register";

  // 登录
  static const String login = "/member/login";

  // 登出
  static const String logout = "/member/logout";

  //中心钱包
  // static const String financewallet = "/finance/wallet";
  //
  // //锁定钱包
  // static const String financeLockWallet = "/finance/lock/wallet";

  //红利金额
  static const String financeWelfareWallet = "/finance/welfare/wallet";

  // 获取开屏页与轮播图/公告
  static const String membermindex = "/member/index";

  static const String gameList = "/member/game/list";

  //收藏列表
  static const String favList = '/member/fav/list';

// 添加收藏
  static const String favinsert = '/member/fav/insert';

  //删除收藏
  static const String favdelete = '/member/fav/delete';

  // 获取充提渠道列表
  static const String channelList = "/finance/channel/list";

  // 获取充值渠道列表（V2版本）
  static const String channelDepositList = "/finance/channel/v2/deposit/list";

  //获取提现渠道列表（V2版本，根据用户信用等级返回对应的提现渠道）
  static const String channelWithdrawList = "/finance/channel/v2/withdraw/list";

  // 获取汇率和手续费
  static const String ratesAndFees = "/finance/payment/rate";

  // 发起充值
  static const String deposit = "/finance/payment/deposit";

  // 发起提现
  static const String withdraw = "/finance/payment/withdraw";

  //发起提现（V2版本）
  static const String withdrawV2 = "/finance/payment/v2/withdraw";

  // 获取提现限制
  static const String withdrawLimit = "/finance/withdraw/limit";

  // 获取钱包账号列表
  static const String accountList = "/finance/account/list";

  // 添加钱包账号
  static const String accountAdd = "/finance/account/insert";

  // 修改钱包账号`
  static const String accountUpdate = "/finance/account/update";

  // 删除钱包账号
  static const String accountDelete = "/finance/account/delete";

  // 投注记录
  static const String betList = "/member/game/bet/list";

  //福利中心列表
  static const String welfareList = "/member/welfare/list";

  //兑换记录
  static const String memberClaimList = "/promo/member/claim/list";

  //福利类型列表
  static const String welfaretypelist = "/member/welfare/typelist";

  //福利立即领取
  static const String memberinsert = "/member/welfare/insert";

  // 投注记录
  static const String launch = "/game2/launch";

  static const String depositList = "/finance/deposit/list";

  static const String withdrawList = "/finance/withdraw/list";

  static const String transactionList = "/finance/transaction/list/v2";
  static const String transactionCancel = "/finance/transaction/cancel/v2";

  static const String transactionDict = "/finance/transaction/dict/v2";

  // 活动类型
  static const String promoTypeList = '/promo/tag';

  //活动列表
  static const String promoList = '/promo/list';

  //签到活动详情
  static const String promosignDetail = "/promo/promosign/detail";

  //签到
  static const String promosignClaim = "/promo/promosign/claim";

  // ============= 安全中心数据加载 =============
  static const String securityLoad = "/member/security/load";

  static const String securitySetLoginPassword =
      "/member/security/loginpwd/update";

//  static const String securitySetPayPassword = "/member/security/paypwd/update";

  //绑定邮箱
  static const String securityEmailBind = "/member/security/email/bind";

  //发送绑定邮箱的验证码
  static const String securityEmailBindingCode =
      "/member/security/email/sendbindcode";

  //发送安全验证码到邮箱
  static const String securitySendEmailSecurityCode =
      "/member/security/email/sendsecuritycode";

  //修改邮箱
  static const String securityEmailUpdate = "/member/security/email/update";

  //解绑邮箱
  static const String securityEmailUnbind = "/member/security/email/unbind";

  // 修改安全验证方式
  static const String securityVerifyTypeUpdate =
      "/member/security/verify/type/set";

  //绑定谷歌验证
  static const String securityGoogleBind =
      "/member/security/google/secret/bind";

  //解绑谷歌验证
  static const String securityGoogleUnbind =
      "/member/security/google/secret/unbind";

  //修改谷歌验证
  static const String securityGoogleUpdate =
      "/member/security/google/secret/update";

  //vip等级配置
  static const String vipLevel = "/member/vip/level";

  //首页广告
  static const String indexAds = "/member/index/ads";

  //app版本列表
  static const String versionList = "/member/setup/version/list";

  //活动申请
  static const String applyJoinActivity = "/promo/apply";

  //活动详情
  static const String activityDetail = "/promo/detail";

  //活动中奖记录
  static const String activityWinnerRecord = "/promo/report";

  //活动申请列表
  static const String applyActivityList = "/promo/apply/info/list";

  //三级联动省
  static const String provinces = "/finance/address/provinces";

  //三级联动市
  static const String cities = "/finance/address/cities";

  //三级联动区镇
  static const String areas = "/finance/address/areas";

  //获取银行卡列表
  static const String bankList = "/finance/bank/list";

  //提现流水稽核列表
  static const String withdrawTurnoverList = "/finance/withdraw/turnover/list";

  //获取区号列表
  static const String countryCodeList =
      "/member/security/phone/countrycode/list";

  //获取短信验证码
  static const String sendBindCode = "/member/security/phone/send";

  // 手机验证码业务校验接口
  static const String phoneCodeVerify = "/member/security/phone/code/verify";

  //手机号安全认证
  static const String phoneVerify = "/member/security/phone/verify";

  static const String platformWalletList = "/game2/balance/all";
  static const String balanceRefresh = "/game2/balance/refresh";
  static const String balanceRecover = "/game2/balance/recover";

  static const String transferIn = "/game2/transfer/in";
  static const String transferOut = "/game2/transfer/out";
  static const String updateAutoTransfer = "/member/auto/transfer/update";
  static const String transferInCheck = "/finance/transfer/in/check";
  static const String platformBalance = "/game2/balance";

  static const String phoneBind = "/member/security/phone/bind";

  //投注/首存豪礼活动领奖接口
  static const String promoClaim = "/promo/claim";

  // 找回密码第一步（验证账号）
  static const String recoveryStep1 = "/member/recovery/step/1";

  // 找回密码第二步（发送验证码）
  static const String recoveryStep2 = "/member/recovery/step/2";

  // 找回密码第三步（验证验证码）
  static const String recoveryStep3 = "/member/recovery/step/3";

  // 找回密码第四步（重置密码）
  static const String recoveryStep4 = "/member/recovery/step/4";

  //上传支付宝收款二维码接口
  static const String alipayQrcodeUpload =
      "/finance/account/alipay/qrcode/upload";

  //忘记支付密码第一步（验证手机号）
  static const String resetStep1 = "/member/security/paypwd/reset/step/1";

  //忘记支付密码第二步（发送验证码）
  static const String resetStep2 = "/member/security/paypwd/reset/step/2";

  //忘记支付密码第三步（验证验证码）
  static const String resetStep3 = "/member/security/paypwd/reset/step/3";

  //忘记支付密码第四步（设置新密码）
  static const String resetStep4 = "/member/security/paypwd/reset/step/4";

  static const String updateLoginPwd1 =
      "/member/security/loginpwd/update/step/1";
  static const String updateLoginPwd2 =
      "/member/security/loginpwd/update/step/2";
  static const String updateLoginPwd3 =
      "/member/security/loginpwd/update/step/3";
  static const String updateLoginPwd4 =
      "/member/security/loginpwd/update/step/4";
  static const String loginStep1 = "/member/login/step/1";
  static const String loginStep2 = "/member/login/step/2";
  static const String loginStep3 = "/member/login/step/3";
  static const String loginStep4 = "/member/login/step/4";
  static const String infoViewStep1 = "/member/security/info/view/step/1";
  static const String infoViewStep2 = "/member/security/info/view/step/2";

  //验证手机号是否正确，创建绑定会话
  static const String accountBindStep1 = "/finance/account/bind/step/1";

  // 向验证手机号发送短信验证码
  static const String accountBindStep2 = "/finance/account/bind/step/2";

  //验证用户输入的短信验证码
  static const String accountBindStep3 = "/finance/account/bind/step/3";

  // 提交银行卡/支付宝/USDT等账户绑定数据
  static const String accountBindStep4 = "/finance/account/bind/step/4";

  //绑定手机号第一步（验证手机号并发送验证码）
  static const String phoneBindStep1 = "/member/security/phone/bind/step/1";

  //绑定手机号第二步（验证验证码并绑定手机号）
  static const String phoneBindStep2 = "/member/security/phone/bind/step/2";

  static const String accountDeleteStep1 = "/finance/account/delete/step/1";

  static const String accountDeleteStep2 = "/finance/account/delete/step/2";

  static const String captchaVerify = "/member/captcha/verify";

  //会员删除标签
  static const String removeTags = "/member/remove/tag";

// =====================================
}
