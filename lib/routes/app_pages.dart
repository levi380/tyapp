import 'package:filbet/src/activity/bindings/match_winner_binding.dart';
import 'package:filbet/src/game/db_sdk/db_sdk_binding.dart';
import 'package:filbet/src/game/db_sdk/db_sdk_view.dart';
import 'package:filbet/src/message/message_center_view.dart';
import 'package:filbet/src/mine/modify_withdraw_pwd/bindings/forget_withdrawal_pwd_binding.dart';
import 'package:filbet/src/mine/modify_withdraw_pwd/views/forget_withdrawal_pwd_view.dart';
import 'package:filbet/src/mine/setting/pwd_modify/verify/verify_binding.dart';
import 'package:filbet/src/mine/setting/pwd_modify/verify/verify_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../app/modules/daily_signin/bindings/daily_signin_binding.dart';
import '../app/modules/daily_signin/views/daily_signin_view.dart';
import '../services/user/user_service.dart';
import '../src/activity/activityDetail/bindings/activity_detail_binding.dart';
import '../src/activity/activityDetail/views/activity_detail_view.dart';
import '../src/activity/activityDetail_turntable/activity_detail_turntable_binding.dart';
import '../src/activity/activityDetail_turntable/activity_detail_turntable_view.dart';
import '../src/activity/bindings/activity_binding.dart';
import '../src/activity/bindings/match_betting_binding.dart';
import '../src/activity/controllers/activity_controller.dart';
import '../src/activity/lottery_record/lottery_record_binding.dart';
import '../src/activity/lottery_record/lottery_record_view.dart';
import '../src/activity/views/activity_view.dart';
import '../src/activity/views/match_betting_activity.dart';
import '../src/activity/views/match_betting_history.dart';
import '../src/activity/views/match_winner_history.dart';
import '../src/activity/winner_record/winner_record_binding.dart';
import '../src/activity/winner_record/winner_record_view.dart';
import '../src/deposit/deposit_binding.dart';
import '../src/deposit/deposit_tutorial_binding.dart';
import '../src/deposit/deposit_tutorial_view.dart';
import '../src/deposit/deposit_view.dart';
import '../src/deposit/waiting_payment_binding.dart';
import '../src/deposit/waiting_payment_view.dart';
import '../src/deposit/waiting_third_payment_binding.dart';
import '../src/deposit/waiting_third_payment_view.dart';
import '../src/deposit/withdrawal_tutorial/bindings/withdrawal_tutorial_binding.dart';
import '../src/deposit/withdrawal_tutorial/views/withdrawal_tutorial_view.dart';
import '../src/deposit_activity/bindings/bet_first_deposit_binding.dart';
import '../src/deposit_activity/bindings/first_deposit_activity_binding.dart';
import '../src/deposit_activity/bindings/first_deposit_activity_binding.dart';
import '../src/deposit_activity/views/bet_first_deposit_view.dart';
import '../src/deposit_activity/views/first_deposit_activity_view.dart';
import '../src/deposit_activity/views/first_deposit_activity_view.dart';
import '../src/game/gameinit/game_init_binding.dart';
import '../src/game/gameinit/game_init_controller.dart';
import '../src/game/gameinit/game_init_view.dart';
import '../src/game/gamelist/gamelist_binding.dart';
import '../src/game/gamelist/view.dart';
import '../src/game/gamesearch/game_search_binding.dart';
import '../src/game/gamesearch/view.dart';
import '../src/home/home_view_controller.dart';
import '../src/login/forgot_password_binding.dart';
import '../src/login/forgot_password_view.dart';
import '../src/login/login_and_register_binding.dart';
import '../src/login/login_and_register_view.dart';
import '../src/login/tg_login/login_tg_binding.dart';
import '../src/login/tg_login/login_tg_view.dart';
import '../src/main/main_controller.dart';
import '../src/main/main_tabber_view.dart';
import '../src/message/messageDetail/bindings/message_detail_binding.dart';
import '../src/message/messageDetail/views/message_detail_view.dart';
import '../src/message/message_binding.dart';
import '../src/mine/about_us/about_us_binding.dart';
import '../src/mine/about_us/about_us_page.dart';
import '../src/mine/accountChangeRecord/accountChangeRecordDetail/bindings/account_change_record_detail_binding.dart';
import '../src/mine/accountChangeRecord/accountChangeRecordDetail/views/account_change_record_detail_view.dart';
import '../src/mine/account_manage/bindings/account_manage_binding.dart';
import '../src/mine/account_manage/views/account_manage_view.dart';
import '../src/mine/add_account/bindings/add_account_binding.dart';
import '../src/mine/add_account/views/add_account_view.dart';
import '../src/mine/add_bank_card/bindings/add_bank_card_page_binding.dart';
import '../src/mine/add_bank_card/views/add_bank_card_page.dart';
import '../src/mine/add_usdt/bindings/add_usdt_binding.dart';
import '../src/mine/add_usdt/views/add_usdt_view.dart';
import '../src/mine/authentication/bindings/real_name_authentication_binding.dart';
import '../src/mine/authentication/bindings/real_name_authentication_binding.dart';
import '../src/mine/authentication/views/real_name_authentication_view.dart';
import '../src/mine/authentication/views/real_name_authentication_view.dart';
import '../src/mine/betRecord/betRecordDetail/bindings/bet_record_detail_binding.dart';
import '../src/mine/betRecord/betRecordDetail/views/bet_record_detail_view.dart';
import '../src/mine/betRecord/bindings/bet_record_binding.dart';
import '../src/mine/betRecord/views/bet_record_view.dart';
import '../src/mine/bind_email_view/bindings/bind_email_view_binding.dart';
import '../src/mine/bind_email_view/bindings/bind_email_view_binding.dart';
import '../src/mine/bind_email_view/views/bind_email_view_view.dart';
import '../src/mine/bind_email_view/views/bind_email_view_view.dart';
import '../src/mine/bindings/mine_binding.dart';
import '../src/mine/bindings/userinfo_binding.dart';
import '../src/mine/controllers/mine_controller.dart';
import '../src/mine/feedback/feedback_binding.dart';
import '../src/mine/feedback/feedback_view.dart';
import '../src/mine/help_center/betting_tutorial_binding.dart';
import '../src/mine/help_center/betting_tutorial_view.dart';
import '../src/mine/help_center/help_center_binding.dart';
import '../src/mine/help_center/help_center_page.dart';
import '../src/mine/help_center/transfer_tutorial_binding.dart';
import '../src/mine/help_center/transfer_tutorial_view.dart';
import '../src/mine/joinUs/bindings/join_us_binding.dart';
import '../src/mine/joinUs/view/join_us_view.dart';
import '../src/mine/modify_withdraw_pwd/bindings/modify_withdraw_pwd_binding.dart';
import '../src/mine/modify_withdraw_pwd/bindings/retrieve_withdrawal_pwd_binding.dart';
import '../src/mine/modify_withdraw_pwd/bindings/withdrawal_pwd_binding.dart';
import '../src/mine/modify_withdraw_pwd/views/modify_withdraw_pwd_view.dart';
import '../src/mine/modify_withdraw_pwd/views/retrieve_withdrawal_pwd_view.dart';
import '../src/mine/modify_withdraw_pwd/views/withdrawal_pwd_view.dart';
import '../src/mine/my_assets/my_assets_binding.dart';
import '../src/mine/my_assets/my_assets_view.dart';
import '../src/mine/setting/pwd_modify/pwd_modify_binding.dart';
import '../src/mine/setting/pwd_modify/pwd_modify_binding.dart';
import '../src/mine/setting/pwd_modify/pwd_modify_page.dart';
import '../src/mine/setting/pwd_modify/pwd_modify_page.dart';
import '../src/mine/setting/setting_binding.dart';
import '../src/mine/setting/setting_view.dart';
import '../src/mine/transactionRecord/bindings/transaction_record_binding.dart';
import '../src/mine/transactionRecord/transactionRecordDetail/bindings/transaction_record_detail_binding.dart';
import '../src/mine/transactionRecord/transactionRecordDetail/views/transaction_record_detail_view.dart';
import '../src/mine/transactionRecord/views/transaction_record_view.dart';
import '../src/mine/transfer/transfer_binding.dart';
import '../src/mine/transfer/transfer_view.dart';
import '../src/mine/verity_identity/bind_phone.dart';
import '../src/mine/verity_identity/get_pwd_view.dart';
import '../src/mine/verity_identity/modify_withdraw_pwd_success.dart';
import '../src/mine/verity_identity/verity_identity.dart';
import '../src/mine/verity_identity/verity_identity_binding.dart';
import '../src/mine/views/mine_view.dart';
import '../src/mine/views/user_infomation_view.dart';
import '../src/mine/vip/detail/bindings/vip_detail_binding.dart';
import '../src/mine/vip/detail/views/vip_detail_view.dart';
import '../src/mine/vip/privilege/bindings/vip_privilege_bindings.dart';
import '../src/mine/vip/privilege/views/vip_privilege_view.dart';
import '../src/mine/welfareCenter/bindings/welfare_center_binding.dart';
import '../src/mine/welfareCenter/redemption_detail/redemption_detail_binding.dart';
import '../src/mine/welfareCenter/redemption_detail/redemption_detail_view.dart';
import '../src/mine/welfareCenter/views/welfare_center_view.dart';
import '../src/service/bindings/service_binding.dart';
import '../src/service/views/service_view.dart';
import '../src/splash/splash_binding.dart';
import '../src/splash/splash_view.dart';
import '../src/webpage/web_view_page.dart';
import '../src/webpage/web_view_page_controller.dart';
import '../src/withdraw/flow_detail/flow_detail_binding.dart';
import '../src/withdraw/flow_detail/flow_detail_view.dart';
import '../src/withdraw/withdraw_binding.dart';
import '../src/withdraw/withdraw_view.dart';

part 'route_config.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> getPages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN_AND_REGISTER,
      page: () => LoginAndRegisterView(),
      binding: LoginAndRegisterBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => const MainTabbarView(),
      bindings: [
        BindingsBuilder.put(() => MainController()),
        BindingsBuilder.put(() => HomeViewController()),
        BindingsBuilder.put(() => ActivityController()),
        BindingsBuilder.put(() => MineController()),
      ],
      transition: Transition.topLevel,
    ),
    GetPage(
      name: _Paths.ACTIVITY,
      page: () => const ActivityView(),
      middlewares: [AuthMiddleware()],
      binding: ActivityBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE,
      page: () => ServiceView(),
      binding: ServiceBinding(),
    ),
    GetPage(
      name: _Paths.MINE,
      page: () => const MineView(),
      middlewares: [AuthMiddleware()],
      binding: MineBinding(),
    ),
    GetPage(
        name: _Paths.WABURL,
        page: () => const WebViewPage(),
        binding: BindingsBuilder.put(() => WebViewPageController())),
    GetPage(
      name: _Paths.GAMEINIT,
      page: () => const GameInitView(),
      binding: GameInitViewBinding(),
    ),
    GetPage(
      name: _Paths.GAME_DB_SDK,
      page: () => const DbSdkView(),
      binding: DbSdkBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY_DETAIL,
      page: () => const ActivityDetailView(),
      binding: ActivityDetailBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY_DETAIL_TURNTABLE,
      page: () => ActivityDetailTurntableView(),
      binding: ActivityDetailTurntableBinding(),
    ),
    GetPage(
      name: _Paths.GAME_SEARCH,
      page: () => GamesearchPage(),
      binding: GameSearchBinding(),
    ),
    GetPage(
      name: _Paths.BET_RECORD,
      page: () => const BetRecordView(),
      binding: BetRecordBinding(),
    ),
    GetPage(
      name: _Paths.BET_RECORD_DETAIL,
      page: () => const BetRecordDetailView(),
      binding: BetRecordDetailBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_RECORD,
      page: () => const TransactionRecordView(),
      binding: TransactionRecordBinding(),
    ),
    GetPage(
      name: _Paths.JOIN_US,
      page: () => const JoinUsView(),
      binding: JoinUsBinding(),
    ),

    GetPage(
      name: _Paths.HELP_CENTER,
      page: () => const HelpCenterPage(),
      binding: HelpCenterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_TELEGRAM,
      page: () => LoginTelegramView(),
      binding: LoginTelegramBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_RECORD_DETAIL,
      page: () => const TransactionRecordDetailView(),
      binding: TransactionRecordDetailBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW,
      page: () => const WithdrawView(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: _Paths.DEPOSIT,
      page: () => const DepositView(),
      binding: DepositBinding(),
    ),
    GetPage(
      name: _Paths.DEPOSIT_TUTORIAL,
      page: () => const DepositTutorialView(),
      binding: DepositTutorialBinding(),
    ),
    GetPage(
      name: _Paths.BETTING_TUTORIAL,
      page: () => const BettingTutorialView(),
      binding: BettingTutorialBinding(),
    ),
    GetPage(
      name: _Paths.TRANSFER_TUTORIAL,
      page: () => const TransferTutorialView(),
      binding: TransferTutorialBinding(),
    ),
    GetPage(
      name: _Paths.WAITING_PAYMENT,
      page: () => const WaitingPaymentView(),
      binding: WaitingPaymentBinding(),
    ),
    // GetPage(
    //   name: _Paths.SECURITY,
    //   page: () => const SecurityView(),
    //   binding: SecurityBinding(),
    // ),
    GetPage(
      name: _Paths.GAME_LIST,
      page: () => GameListView(),
      binding: GameListBinding(),
    ),
    GetPage(
      name: _Paths.USER_INFO,
      page: () => UserInfoMationView(),
      binding: UserinfoBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => MessageCenterView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.WELFARE_CENTER,
      page: () => const WelfareCenterView(),
      binding: WelfareCenterBinding(),
    ),
    // GetPage(
    //   name: _Paths.ACCOUNT_CHANGE_RECORD,
    //   page: () => const AccountChangeRecordView(),
    //   binding: AccountChangeRecordBinding(),
    // ),
    GetPage(
      name: _Paths.VIP_DETAIL,
      page: () => const VipDetailView(),
      binding: VipDetailBinding(),
    ),
    GetPage(
      name: _Paths.VIP_PRIVILEDGE,
      page: () => const VipRPrivilegeView(),
      binding: VipPrivilegeBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_CHANGE_RECORD_DETAIL,
      page: () => const AccountChangeRecordDetailView(),
      binding: AccountChangeRecordDetailBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE_DETAIL,
      page: () => const MessageDetailView(),
      binding: MessageDetailBinding(),
    ),
    GetPage(
      name: _Paths.DAILY_SIGNIN,
      page: () => DailySigninView(),
      middlewares: [AuthMiddleware()],
      binding: DailySigninBinding(),
    ),
    GetPage(
      name: _Paths.WAITING_THIRD_PAYMENT,
      page: () => const WaitingThirdPaymentView(),
      binding: WaitingThirdPaymentBinding(),
    ),
    GetPage(
      name: _Paths.FLOW_DETAIL,
      page: () => FlowDetailView(),
      binding: FlowDetailBinding(),
    ),
    GetPage(
      name: _Paths.TRANSFER,
      page: () => TransferView(),
      binding: TransferBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK,
      page: () => FeedbackView(),
      binding: FeedbackBinding(),
    ),
    GetPage(
      name: _Paths.MY_ASSETS,
      page: () => const MyAssetsView(),
      middlewares: [AuthMiddleware()],
      binding: MyAssetsBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_MANAGE,
      page: () => const AccountManageView(),
      binding: AccountManageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BANK_CARD,
      page: () => AddBankCardPage(),
      binding: AddBankCardPageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ACCOUNT,
      page: () => const AddAccountView(),
      binding: AddAccountBinding(),
    ),
    GetPage(
      name: _Paths.ADD_USDT,
      page: () => const AddUsdtView(),
      binding: AddUsdtBinding(),
    ),
    GetPage(
      name: _Paths.VERITY_IDENTITY,
      page: () => VerityIdentity(),
      binding: VerityIdentityBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY,
      page: () => VerifyPage(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: _Paths.GETPWD_BYPHONE,
      page: () => GetPwdView(),
      binding: VerityIdentityBinding(),
    ),
    GetPage(
      name: _Paths.BIND_PHONE,
      page: () => BindPhoneView(),
      binding: VerityIdentityBinding(),
    ),
    GetPage(
      name: _Paths.MODIFY_WITHDRAW_PWD,
      page: () => ModifyWithdrawPwdView(),
      binding: ModifyWithdrawPwdBinding(),
    ),
    GetPage(
      name: _Paths.MODIFY_WITHDRAW_PWD_SUCCESS,
      page: () => ModifyWithdrawPwdSuccess(),
      binding: VerityIdentityBinding(),
    ),
    GetPage(
      name: _Paths.REAL_NAME_AUTHENTICATION,
      page: () => const RealNameAuthenticationView(),
      binding: RealNameAuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.PWD_MODIFY,
      page: () => PwdModifyPage(),
      binding: PwdModifyBinding(),
    ),
    GetPage(
      name: _Paths.BIND_EMAIL,
      page: () => const BindEmailViewView(),
      binding: BindEmailViewBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => AboutUsPage(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAWAL_PWD,
      page: () => const WithdrawalPwdView(),
      binding: WithdrawalPwdBinding(),
    ),
    GetPage(
      name: _Paths.RETRIEVE_WITHDRAWAL_PWD,
      page: () => const RetrieveWithdrawalPwdView(),
      binding: RetrieveWithdrawalPwdBinding(),
    ),
    GetPage(
      name: _Paths.FIRST_DEPOSIT_ACTIVITY,
      page: () => const FirstDepositActivityView(),
      binding: FirstDepositActivityBinding(),
    ),
    GetPage(
      name: _Paths.BETTING_FIRST_DEPOSIT,
      page: () => const BettingFirstDepositView(),
      binding: BettingFirstDepositBinding(),
    ),
    GetPage(
      name: _Paths.LOTTERY_RECORD,
      page: () => const LotteryRecordView(),
      binding: LotteryRecordBinding(),
    ),
    GetPage(
      name: _Paths.WINNER_RECORD,
      page: () => const WinnerRecordView(),
      binding: WinnerRecordBinding(),
    ),
    GetPage(
      name: _Paths.MATCH_BETTING_ACT,
      page: () => MatchBettingActivity(),
      binding: MatchBettingBinding(),
    ),
    GetPage(
      name: _Paths.MATCH_BETTING_HIS,
      page: () => MatchBettingHistory(),
      binding: MatchBettingBinding(),
    ),
    GetPage(
      name: _Paths.MATCH_WINER_HIS,
      page: () => MatchWinnerHistory(),
      binding: MatchWinnerBinding(),
    ),
    GetPage(
      name: _Paths.REDEMPTION_DETAIL,
      page: () => const RedemptionDetailView(),
      binding: RedemptionDetailBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAWAL_TUTORIAL,
      page: () => const WithdrawalTutorialView(),
      binding: WithdrawalTutorialBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_WITHDRAWAL_PWD,
      page: () => const ForgetWithdrawalPwdView(),
      binding: ForgetWithdrawalPwdBinding(),
    ),
  ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // // 判别用户是否已登录

    if (UserService.to.state.isVisitor) {
      // 用户未登录，重定向到登录页面
      return RouteSettings(name: _Paths.LOGIN_AND_REGISTER);
    }
    // 用户已登录，持续正常跳转
    return null;
  }
}
