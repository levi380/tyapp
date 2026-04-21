import 'package:filbet/common/currency.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/currency_balance.dart';
import 'package:filbet/services/user/user_vip_level.dart';
import 'package:filbet/services/user/userinfo.dart';
import 'package:filbet/src/mine/vip/models/member_vip_info.dart';
import 'package:filbet/src/security/security_data_model.dart';
import 'package:filbet/utils/base_util.dart';
import 'package:get/get.dart';

enum AuthLevel {
  regular, // 登录用户
  visitor, // 游客
}

class UserServiceState {
  RxList<String> avatarList = [
    Assets.headerIc0,
    Assets.headerIc1,
    Assets.headerIc2,
    Assets.headerIc3,
    Assets.headerIc4,
    Assets.headerIc5,
    Assets.headerIc6,
    Assets.headerIc7
  ].obs;

  int get userAvatarIndex {
    if (userInfo.avatar == null || userInfo.avatar!.isEmpty) {
      return 0; // 默认头像索引
    }
    final index = parseAvatarIndex(userInfo.avatar!);
    return index < 0 || index >= avatarList.length ? 0 : index;
  }

  String get avatarImgUrl {
    var index = parseAvatarIndex(userInfo.avatar);
    index = index < 0 || index >= avatarList.length ? 0 : index;
    return avatarList[index];
  }

  // 用户信息
  late final Rx<UserInfoEntity> _userInfo = Rx(UserInfoEntity());

  set userInfo(value) => _userInfo.value = value;

  UserInfoEntity get userInfo => _userInfo.value;

  final Rx<Currency> _currencyType = Rx(Currency.rmb);

  // set currencyType(Currency value) => _currencyType.value = value;

  //
  Currency get currencyType => _currencyType.value;

  //用户名
  String get userName => _userInfo.value.username ?? '';

  String get avatar => _userInfo.value.avatar ?? '';

  String get nickname => _userInfo.value.nickName ?? '';

  String get nicknamelabel {
    if (nickname.isEmpty) {
      return userName;
    } else {
      return nickname;
    }
  }

  String get birthday => _userInfo.value.birthday ?? '';

  String get uid => _userInfo.value.uid ?? '';

  // 用户信息
  final Rx<bool> loginState = false.obs;

  //token过期时间记录用来防重复提示toast
  final Rx<int> tokenExpireTime = 0.obs;

  final Rx<AuthLevel> _authLevel = Rx(AuthLevel.visitor);

  set authLevel(AuthLevel value) => _authLevel.value = value;

  //正式账号
  AuthLevel get authLevel => _authLevel.value;

  bool get isRegularUser => _authLevel.value == AuthLevel.regular;

  bool get isVisitor => _authLevel.value == AuthLevel.visitor;

  // 安全中心信息
  final Rx<SecurityDataModel> _securityData = SecurityDataModel().obs;

  set securityData(SecurityDataModel value) {
    _securityData.value = value;
  }

  SecurityDataModel get securityData => _securityData.value;
  final totalUnread = 0.obs;

  final hideBalance = true.obs;

  final vipInfo = Rx<MemberVipInfoModel?>(null);

  // 钱包相关状态
  final RxList<PlatformWalletModel> walletList = RxList.empty();
  final RxString centerBalance = '0.00'.obs; // 中心钱包余额
  final RxString lockBalance = '0.00'.obs; // 锁定钱包余额
  final RxString totalBalance = '0.00'.obs; // 总资产
  final RxString platformBalance = '0.00'.obs; // 场馆钱包总额
  final RxBool isRefreshingWallet = false.obs; // 刷新状态
  final welfareAmount = '0.00'.obs; //福利中心

  void clearBalance() {
    centerBalance.value = '0.00';
    lockBalance.value = '0.00';
    totalBalance.value = '0.00';
    platformBalance.value = '0.00';
    welfareAmount.value = '0.00';
  }
}
