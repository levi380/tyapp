// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const LOGIN_AND_REGISTER = _Paths.LOGIN_AND_REGISTER;
  static const LOGIN_TELEGRAM = _Paths.LOGIN_TELEGRAM;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const HOME = _Paths.HOME;
  static const HOME1 = _Paths.HOME;

  static const MINE = _Paths.MINE;
  static const MAIN = _Paths.MAIN;
  static const ACTIVITY = _Paths.ACTIVITY;
  static const SERVICE = _Paths.SERVICE;
  static const WITHDRAW = _Paths.WITHDRAW;
  static const DEPOSIT = _Paths.DEPOSIT;
  static const DEPOSIT_TUTORIAL = _Paths.DEPOSIT_TUTORIAL;
  static const BETTING_TUTORIAL = _Paths.BETTING_TUTORIAL;
  static const TRANSFER_TUTORIAL = _Paths.TRANSFER_TUTORIAL;
  static const WAITING_PAYMENT = _Paths.WAITING_PAYMENT;

  static const GAMEINIT = _Paths.GAMEINIT;
  static const GAME_DB_SDK = _Paths.GAME_DB_SDK;

  static const WABURL = _Paths.WABURL;
  static const ACTIVITY_DETAIL = _Paths.ACTIVITY_DETAIL;
  static const ACTIVITY_DETAIL_TURNTABLE = _Paths.ACTIVITY_DETAIL_TURNTABLE;

  static const BET_RECORD = _Paths.BET_RECORD;

  static const BET_RECORD_DETAIL = _Paths.BET_RECORD_DETAIL;
  static const TRANSACTION_RECORD = _Paths.TRANSACTION_RECORD;
  static const TRANSACTION_RECORD_DETAIL = _Paths.TRANSACTION_RECORD_DETAIL;

  static const GAME_SEARCH = _Paths.GAME_SEARCH;

//  static const SECURITY = _Paths.SECURITY;
  static const USER_INFO = _Paths.USER_INFO;
  static const GAME_LIST = _Paths.GAME_LIST;
  static const SETTING = _Paths.SETTING;
  static const WELFARE_CENTER = _Paths.WELFARE_CENTER;
  static const MESSAGE = _Paths.MESSAGE;

//  static const ACCOUNT_CHANGE_RECORD = _Paths.ACCOUNT_CHANGE_RECORD;
  static const ACCOUNT_CHANGE_RECORD_DETAIL =
      _Paths.ACCOUNT_CHANGE_RECORD_DETAIL;
  static const MESSAGE_DETAIL = _Paths.MESSAGE_DETAIL;
  static const DAILY_SIGNIN = _Paths.DAILY_SIGNIN;
  static const VIP_DETAIL = _Paths.VIP_DETAIL;
  static const VIP_PRIVILEDGE = _Paths.VIP_PRIVILEDGE;
  static const JOIN_US = _Paths.JOIN_US;
  static const HELP_CENTER = _Paths.HELP_CENTER;
  static const WAITING_THIRD_PAYMENT = _Paths.WAITING_THIRD_PAYMENT;
  static const FLOW_DETAIL = _Paths.FLOW_DETAIL;
  static const TRANSFER = _Paths.TRANSFER;
  static const FEEDBACK = _Paths.FEEDBACK;
  static const MY_ASSETS = _Paths.MY_ASSETS;
  static const ACCOUNT_MANAGE = _Paths.ACCOUNT_MANAGE;
  static const ADD_BANK_CARD = _Paths.ADD_BANK_CARD;
  static const ADD_ACCOUNT = _Paths.ADD_ACCOUNT;
  static const ADD_USDT = _Paths.ADD_USDT;
  static const VERITY_IDENTITY = _Paths.VERITY_IDENTITY;
  static const GETPWD_BYPHONE = _Paths.GETPWD_BYPHONE;
  static const BIND_PHONE = _Paths.BIND_PHONE;
  static const MODIFY_WITHDRAW_PWD = _Paths.MODIFY_WITHDRAW_PWD;
  static const MODIFY_WITHDRAW_PWD_SUCCESS = _Paths.MODIFY_WITHDRAW_PWD_SUCCESS;
  static const REAL_NAME_AUTHENTICATION = _Paths.REAL_NAME_AUTHENTICATION;
  static const PWD_MODIFY = _Paths.PWD_MODIFY;
  static const BIND_EMAIL = _Paths.BIND_EMAIL;
  static const ABOUT_US = _Paths.ABOUT_US;
  static const WITHDRAWAL_PWD = _Paths.WITHDRAWAL_PWD;
  static const RETRIEVE_WITHDRAWAL_PWD = _Paths.RETRIEVE_WITHDRAWAL_PWD;
  static const FIRST_DEPOSIT_ACTIVITY = _Paths.FIRST_DEPOSIT_ACTIVITY;
  static const BETTING_FIRST_DEPOSIT = _Paths.BETTING_FIRST_DEPOSIT;
  static const LOTTERY_RECORD = _Paths.LOTTERY_RECORD;
  static const WINNER_RECORD = _Paths.WINNER_RECORD;
  static const MATCH_BETTING_ACT = _Paths.MATCH_BETTING_ACT;
  static const MATCH_BETTING_HIS = _Paths.MATCH_BETTING_HIS;
  static const MATCH_WINER_HIS = _Paths.MATCH_WINER_HIS;
  static const REDEMPTION_DETAIL = _Paths.REDEMPTION_DETAIL;
  static const WITHDRAWAL_TUTORIAL = _Paths.WITHDRAWAL_TUTORIAL;
  static const FORGET_WITHDRAWAL_PWD = _Paths.FORGET_WITHDRAWAL_PWD;
  static const VERIFY = _Paths.VERIFY;
}

abstract class _Paths {
  _Paths._();

  static const SPLASH = '/splash-single-photo';
  static const LOGIN_AND_REGISTER = '/login-and-register';
  static const LOGIN_TELEGRAM = '/login-telegram';
  static const FORGOT_PASSWORD = '/forgot-password';

  static const HOME = '/home';
  static const MAIN = '/main';
  static const MINE = '/mine';
  static const ACTIVITY = '/activity';
  static const SERVICE = '/service';
  static const WITHDRAW = '/withdraw';
  static const DEPOSIT = '/deposit';
  static const DEPOSIT_TUTORIAL = '/deposit-tutorial';
  static const BETTING_TUTORIAL = '/betting-tutorial';
  static const TRANSFER_TUTORIAL = '/transfer-tutorial';
  static const WAITING_PAYMENT = '/waiting-payment';
  static const GAMEINIT = '/game';
  static const GAME_DB_SDK = '/game_db_sdk';
  static const WABURL = '/weburl';
  static const ACTIVITY_DETAIL = '/activity-detail';
  static const ACTIVITY_DETAIL_TURNTABLE = '/activity_detail_turntable';

  static const BET_RECORD = '/bet-record';
  static const BET_RECORD_DETAIL = '/bet-record-detail';
  static const TRANSACTION_RECORD = '/transaction-record';
  static const JOIN_US = '/join-us';
  static const HELP_CENTER = '/help-center';
  static const TRANSACTION_RECORD_DETAIL = '/transaction-record-detail';

  static const GAME_SEARCH = '/game-search';

  static const GAME_LIST = '/game-list';

//  static const SECURITY = '/security';
  static const USER_INFO = '/userinfo';
  static const SETTING = '/setting';
  static const WELFARE_CENTER = '/welfare-center';
  static const MESSAGE = '/message';

//  static const ACCOUNT_CHANGE_RECORD = '/account-change-record';
  static const VIP_DETAIL = '/vip-detail';
  static const VIP_PRIVILEDGE = '/vip-priviledge';

  static const ACCOUNT_CHANGE_RECORD_DETAIL = '/account-change-record-detail';

  static const MESSAGE_DETAIL = '/message-detail';
  static const DAILY_SIGNIN = '/daily_signin';
  static const WAITING_THIRD_PAYMENT = '/waiting-third-payment';
  static const FLOW_DETAIL = '/flow_detail';
  static const TRANSFER = '/transfer';
  static const FEEDBACK = '/feedback';
  static const MY_ASSETS = '/myAssets';
  static const ACCOUNT_MANAGE = '/account-manage';
  static const ADD_BANK_CARD = '/add-bank-card';
  static const ADD_ACCOUNT = '/add-account';
  static const ADD_USDT = '/add-usdt';
  static const VERITY_IDENTITY = '/verity_identity';
  static const VERIFY = '/verify';
  static const GETPWD_BYPHONE = '/getpwdbyphone';
  static const BIND_PHONE = '/bind_phone';
  static const MODIFY_WITHDRAW_PWD = '/modify_withdraw_pwd';
  static const MODIFY_WITHDRAW_PWD_SUCCESS = '/modify_withdraw_pwd_success';
  static const REAL_NAME_AUTHENTICATION = '/real-name-authentication';
  static const PWD_MODIFY = '/pwd_modify';
  static const BIND_EMAIL = '/bind_email';
  static const ABOUT_US = '/about_us';
  static const WITHDRAWAL_PWD = '/withdrawal-pwd';
  static const RETRIEVE_WITHDRAWAL_PWD = '/retrieve-withdrawal-pwd';
  static const FIRST_DEPOSIT_ACTIVITY = '/first-deposit-activity';
  static const LOTTERY_RECORD = '/lottery_record';
  static const WINNER_RECORD = '/winner_record';
  static const BETTING_FIRST_DEPOSIT = '/betting-first-deposit';
  static const MATCH_BETTING_ACT = '/match_betting_act';
  static const MATCH_BETTING_HIS = '/match_betting_his';
  static const MATCH_WINER_HIS = '/match_winer_his';
  static const REDEMPTION_DETAIL = '/redemption_detail';
  static const WITHDRAWAL_TUTORIAL = '/withdrawal-tutorial';
  static const FORGET_WITHDRAWAL_PWD = '/forget-withdrawal-pwd';
}
