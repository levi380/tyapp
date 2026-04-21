import 'dart:async';

import 'package:filbet/api/api.dart';
import 'package:filbet/constants/log.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/resp_platform_wallet.dart';
import 'package:filbet/http/exception_user_message.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/services/base_service.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/user/user_state.dart';
import 'package:filbet/services/user/user_vip_level.dart';
import 'package:filbet/services/user/userinfo.dart';
import 'package:filbet/services/web_socket_service.dart';
import 'package:filbet/src/mine/vip/vip_service.dart';
import 'package:filbet/src/security/security_data_model.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:filbet/utils/fp.dart';
import 'package:filbet/utils/log/log_events.dart';
import 'package:filbet/utils/log/log_uploader.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class UserService extends BaseService {
  static UserService get to => Get.find();
  final UserServiceState state = UserServiceState();

  // 初始化
  Future<UserService> init() async {
    print('SpStorage.jwtToken = ${SpStorage.jwtToken}');

    print('SpStorage.hibalance = ${SpStorage.hibalance}');
    try {
      state.hideBalance.value = SpStorage.hibalance;

      if (SpStorage.jwtToken != null) {
        getUserVipInfo();
        getUserInfos();
        queryTotalUnread();
        state.authLevel = AuthLevel.regular;
      }
    } catch (e) {
      // onBeforeLogout();
      await SpStorage.removeToken();
      // 清除用户信息
      state.userInfo = UserInfoEntity();
      state.authLevel = AuthLevel.visitor;
      state.loginState.value = false;
    }
    return this;
  }

  // 初始化已登录用户
  Future<void> initializeRegularUser({
    String? token,
    bool? isRegister,
  }) async {
    if (token != null) {
      await SpStorage.setToken(token);
      state.authLevel = AuthLevel.regular;
      print('SpStorage.jwtToken = ${SpStorage.jwtToken}');
    }

    state.loginState.value = true;
    WebSocketService c = Get.put(WebSocketService());
    c.connect();
    EventBus.emit(EventType.onLogin); //不需要提示登录成功,但还需处理其他逻辑
    getUserVipInfo();
    getUserInfos(isRegister: isRegister);

    getSecurityData();
    queryTotalUnread();
  }

  ///公告列表接口
  Future queryTotalUnread() async {
    try {
      var respNotice = await ApiRequest.queryNotice(0, 1);
      var respMessage = await ApiRequest.queryMessages(0, 1);
      var respPrivate = await ApiRequest.queryPrivateMessages(0, 1);
      state.totalUnread.value = (respNotice?.unreadCount?.toInt() ?? 0) +
          (respMessage?.unreadCount?.toInt() ?? 0) +
          (respPrivate?.unreadCount?.toInt() ?? 0);
    } catch (e) {}
  }

  // // 登出前置业务处理
  Future onBeforeLogout() async {
    state.totalUnread.value = 0;
    await logout();
  }

  // 退出登录
  Future<void> logout() async {
    await SpStorage.removeToken();
    state.clearBalance();
    state.userInfo = UserInfoEntity();
    state.loginState.value = false;
    state.authLevel = AuthLevel.visitor;
    WebSocketService.to.closeConnect();
  }

  Future currencyChange({required int currency}) async {
    final response = await HttpClient.post(Api.currencyChange, data: {
      "currency": currency,
    });
    if (response.status == false) {
      throw response.error!;
    }
    GlobalService.to.getHomeGames();
  }

  Future<UserInfoEntity> _getUserInfos() async {
    final response = await HttpClient.get(Api.userinfo);
    if (response.status == false) {
      throw response.error!;
    }

    return compose(
      UserInfoEntity.fromJson,
      Map<String, dynamic>.from,
    )(response.data);
  }

  // 获取用户信息
  Future<void> getUserInfos({
    Function? onSuccess,
    Function? onComplete,
    Function? onError,
    bool? isRegister,
  }) async {
    await fetchHandler<UserInfoEntity>(
      _getUserInfos(),
      onSuccess: (userInfo) {
        state.userInfo = userInfo;
        recycleBalance();
        queryTotalBalance();
        Get.find<WebSocketService>().connect();
        if (isRegister == true) {
          uploadRegisterInfo();
        }
        GlobalService.to.getHomeGames();
        onSuccess != null ? onSuccess(userInfo) : '';
      },
      onError: (exception) {
        onError != null ? onError() : "";
      },
      onComplete: () {
        onComplete != null ? onComplete() : "";
      },
    );
  }

  Future<Tuple2<bool, String?>> updateUserInfos(
      {required UserInfoEntity userInfo}) async {
    Completer<Tuple2<bool, String?>> completer = Completer();
    fetchHandler(
      HttpClient.post(
        Api.userinfoUpdate,
        data: {
          "record": {
            "real_username": userInfo.username,
            "birthday": userInfo.birthday,
            // "email": 'xxx@gmail.com',
            "nick_name": userInfo.nickName,
            "gender": (userInfo.gender ?? 1).toString(),
            "avatar": userInfo.avatar,
          }
        },
      ),
      onSuccess: (response) {
        if (response.status == false) {
          completer.complete(Tuple2(false, response.message));
          return;
        }
        state.userInfo = userInfo;
        completer.complete(Tuple2(true, null));
      },
      onError: (exception) {
        completer.complete(
          Tuple2(false, exceptionMessageForUser(exception)),
        );
      },
      loading: true,
    );

    return completer.future;
  }

  Future<String> _checkToken() async {
    var response = await HttpClient.get(
      Api.refreshtoken,
    );
    if (response.status == false) {
      throw response.error!;
    }

    return (response.data as String?) ?? "";
  }

  // 刷新Token
  Future<void> checkToken({bool? errorHandler = true}) async {
    await fetchHandler<String>(
      _checkToken(),
      onSuccess: (res) async {
        EventBus.emit(EventType.onLogin); //不需要提示登录成功,但还需处理其他逻辑
        getUserInfos();
        getUserVipInfo();

        state.authLevel = AuthLevel.regular;
      },
      onError: (exception) {
        print('刷新Token失败');

        SpStorage.removeToken();
        state.userInfo = UserInfoEntity();
        state.loginState.value = false;
        state.authLevel = AuthLevel.visitor;
        if (errorHandler == false) {}
      },
    );
  }

  // 静默获取用户的安全中心信息
  Future<void> getSecurityData() async {
    final response = await HttpClient.post(Api.securityLoad);
    if (response.status) {
      try {
        if (response.data is Map) {
          final securityData = compose(
            SecurityDataModel.fromJson,
            Map<String, dynamic>.from,
          )(response.data);
          state.securityData = securityData;
        }
      } catch (e) {
        {}
      }
    }
  }

  // vip等级配置
  Future<void> getUserVipInfo() async {
    try {
      final response = await VipService.getMemberVipInfo();
      state.vipInfo.value = response;
    } catch (e) {}
  }

  Future queryTotalBalance() async {
    await queryWalletList();
  }

  void recycleBalance() {
    if (UserService.to.state.userInfo.autoTransfer == 1) {
      ApiRequest.balanceRecover();
    }
  }

  /// 计算总资产
  /// 总资产 = 中心钱包 + 所有场馆钱包余额之和 + 锁定钱包
  /// [centerAmount] 中心钱包余额
  /// [lockAmount] 锁定钱包余额
  /// [walletList] 场馆钱包列表
  /// 返回总资产字符串（保留2位小数）
  static String calculateTotalAmount({
    required String centerAmount,
    required String lockAmount,
    required String platformBalance,
  }) {
    // 中心钱包金额
    final center = num.tryParse(centerAmount) ?? 0.0;

    // 所有场馆钱包余额之和
    final platform = num.tryParse(platformBalance) ?? 0.0;
    // 锁定钱包金额
    final lock = num.tryParse(lockAmount) ?? 0.0;

    // 总资产 = 中心钱包 + 所有场馆钱包余额之和 + 锁定钱包
    final total = center + platform + lock;
    return total.toStringAsFixed(2);
  }

  /// 更新总资产（自动从 state 中获取数据）
  void _updateTotalAmount() {
    state.totalBalance.value = calculateTotalAmount(
      centerAmount: state.centerBalance.value,
      lockAmount: state.lockBalance.value,
      platformBalance: state.platformBalance.value,
    );
  }

  /// 查询钱包列表
  Future queryWalletList() async {
    try {
      if (state.isRefreshingWallet.value) return null;
      state.isRefreshingWallet.value = true;
      await HttpClient.post(Api.balanceRefresh);
      final response = await HttpClient.get(Api.platformWalletList);
      if (response.status == false) {
        state.isRefreshingWallet.value = true;
        return null;
      }
      var platformWallet = RespPlatformWallet.fromJson(response.data);
      state.platformBalance.value = platformWallet.platformBalance ?? '0';
      state.centerBalance.value = platformWallet.balance ?? '0';
      state.lockBalance.value = platformWallet.lockBalance ?? '0';
      state.walletList.value = platformWallet.wallets ?? [];
      _updateTotalAmount();
      state.isRefreshingWallet.value = false;
      return platformWallet.wallets;
    } catch (e) {
      state.isRefreshingWallet.value = false;
      return null;
    }
  }

  /// 查询场馆钱包余额
  Future<String?> platformBalance(String pid) async {
    try {
      final response = await HttpClient.get(
        Api.platformBalance,
        queryParameters: {
          'pid': pid,
        },
      );
      if (response.status == false) {
        return null;
      }
      // 更新钱包列表中的余额
      final walletIndex =
          state.walletList.indexWhere((item) => item.walletId == pid);
      if (walletIndex != -1) {
        state.walletList[walletIndex].balance = response.data;
        state.walletList.refresh();
        _updateTotalAmount();
      }
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<bool> getResetStep2(String sid) async {
    final response = await HttpClient.post(Api.resetStep2, data: {
      'sid': sid,
    });
    if (!response.status) {
      throw response.error!;
    }
    return response.status;
  }

  /// 查询中心钱包余额
// Future<CurrencyBalance?> financeWallet() async {
//   if (state.isRefreshingWallet.value) return null;
//   state.isRefreshingWallet.value = true;
//   try {
//     final response = await HttpClient.get(Api.financewallet);
//     if (response.status == false) {
//       AppUtils.showToast(response.message ?? '');
//       state.isRefreshingWallet.value = false;
//       return null;
//     }
//     final currencyBalance =
//         CurrencyBalance.fromJson(Map<String, dynamic>.from(response.data));
//     state.centerAmount.value = currencyBalance.balance ?? '0';
//     _updateTotalAmount();
//     state.isRefreshingWallet.value = false;
//     return currencyBalance;
//   } catch (e) {
//     state.isRefreshingWallet.value = false;
//     return null;
//   }
// }
//
// /// 查询锁定钱包余额
// Future<CurrencyBalance?> financeLockWallet() async {
//   try {
//     final response = await HttpClient.get(Api.financeLockWallet);
//     if (response.status == false) {
//       AppUtils.showToast(response.message ?? '');
//       return null;
//     }
//     final currencyBalance =
//         CurrencyBalance.fromJson(Map<String, dynamic>.from(response.data));
//     state.lockAmount.value = currencyBalance.balance ?? '0';
//     _updateTotalAmount();
//     return currencyBalance;
//   } catch (e) {
//     return null;
//   }
// }

  /// 批量查询所有场馆钱包余额
// Future<void> financePlatformBalance() async {
//   for (var model in state.walletList) {
//     await platformBalance(model.walletId ?? '');
//   }
// }

  void uploadRegisterInfo() {
    LogUploader.upload([
      LogEvents.codeError(
          message:
              '${GlobalService.to.state.installQuery.value}\n\n${Log.shareTraceData}\n\n${Log.xInstallData}')
    ]);
  }
}
