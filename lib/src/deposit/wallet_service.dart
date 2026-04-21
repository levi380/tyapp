import 'package:device_info_plus/device_info_plus.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/common/currency.dart';
import 'package:filbet/http/entity/resp_flow_detail.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/src/deposit/channel_model.dart';
import 'package:filbet/src/deposit/deposit_model.dart';
import 'package:filbet/src/deposit/rate_model.dart';
import 'package:filbet/src/withdraw/wallet_account_model.dart';
import 'package:filbet/src/withdraw/withdraw_limit_model.dart';
import 'package:filbet/src/withdraw/withdraw_model.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/fp.dart';
import 'package:tuple/tuple.dart';

class WalletService {
  final deviceInfo = DeviceInfoPlugin();

  // 废弃
  Future<List<ChannelModel>> getChannelLsit(String currencyCode, String mode) async {
    final response = await HttpClient.get(Api.channelList, queryParameters: {
      'mode': mode,
      'currency': currencyCode,
    });
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is List) {
      final convert = compose(ChannelModel.fromJson, Map<String, dynamic>.from);
      return List<ChannelModel>.from(
        response.data.map((item) => convert(item)),
      );
    } else {
      throw Exception('Invalid response format');
    }
  }

  //<editor-fold desc="获取充值渠道列表（V2版本）">
  Future<List<ChannelModel>> getChannelDepositList() async {
    final response = await HttpClient.get(Api.channelDepositList);
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is List) {
      final convert = compose(ChannelModel.fromJson, Map<String, dynamic>.from);
      return List<ChannelModel>.from(
        response.data.map((item) => convert(item)),
      );
    } else {
      throw Exception('Invalid response format');
    }
  }
  //</editor-fold>

  //<editor-fold desc="获取提现渠道列表（V2版本，根据用户信用等级返回对应的提现渠道）">
  Future<List<ChannelModel>> getChannelWithdrawList() async {
    final response = await HttpClient.get(Api.channelWithdrawList);
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is List) {
      final convert = compose(ChannelModel.fromJson, Map<String, dynamic>.from);
      return List<ChannelModel>.from(
        response.data.map((item) => convert(item)),
      );
    } else {
      throw Exception('Invalid response format');
    }
  }
  //</editor-fold>

  Future<RateModel?> getRatesAndFees(String code) async {
    final response = await HttpClient.get(Api.ratesAndFees, queryParameters: {"currency": int.parse(code)});
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is Map) {
      final convert = compose(RateModel.fromJson, Map<String, dynamic>.from);
      return convert(response.data);
    } else {
      throw Exception('Invalid response format');
    }
  }

  Future<DepositModel?> deposit(String pid, double amount, String currencyCode) async {
    final response = await HttpClient.get(Api.deposit, queryParameters: {
      "pid": pid, // 充值渠道ID
      "amount": amount.toString(), // 充值金额
      "currency": currencyCode, // 货币类型
      "device": "app",
    });
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is Map) {
      final convert = compose(DepositModel.fromJson, Map<String, dynamic>.from);
      return convert(response.data);
    } else {
      throw Exception('Invalid response format');
    }
  }

  // Future<WalletModel> getWallet() async {
  //   final response = await HttpClient.get(Api.financewallet);
  //   if (response.status == false) {
  //     throw response.error!;
  //   }
  //   if (response.data is Map) {
  //     final convert = compose(WalletModel.fromJson, Map<String, dynamic>.from);
  //     return convert(response.data);
  //   } else {
  //     throw Exception('Invalid response format');
  //   }
  // }

  Future<List<WalletAccountModel>> getAccountList() async {
    final response = await HttpClient.get(Api.accountList);
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is List) {
      final convert = compose(
        WalletAccountModel.fromJson,
        Map<String, dynamic>.from,
      );
      if (response.data.isEmpty) {
        return [];
      }
      return List<WalletAccountModel>.from(
        response.data.map((item) => convert(item)),
      );
    } else {
      throw Exception('Invalid response format');
    }
  }

  Future<Tuple2<bool, String?>> addAccount(
    String name,
    int paymentType,
    String address, {
    String? withdrawalPassword,
    String? secCode,
    String? phone,
  }) async {
    final responseCodeVerify = await HttpClient.post(Api.phoneCodeVerify, data: {
      'active_method': 1,
      'code': secCode,
      'type': 0,
    });
    if (!responseCodeVerify.status) {
      Tuple2(
        false,
        responseCodeVerify.error?.toString() ?? '验证码不正确',
      );
    }

    final response = await HttpClient.post(
      Api.accountAdd,
      data: {
        "name": name,
        "payment_type": paymentType,
        "address": address,
        "phone": phone,
        // "withdrawal_password": withdrawalPassword,
        if (secCode != null) "sec_code": secCode,
      },
    );

    if (response.status) {
      return Tuple2(true, null);
    }
    if (response.message is String) {
      return Tuple2(false, response.message);
    } else {
      return Tuple2(
        false,
        response.error?.toString() ?? '添加失败，请稍后再试',
      );
    }
  }

  Future<bool> modifyAccount(
    String id,
    String withdrawalPassword, {
    int? paymentType,
    String? name,
    String? address,
    String? secCode,
  }) async {
    final response = await HttpClient.post(Api.accountUpdate, data: {
      "id": id,
      "withdrawal_password": withdrawalPassword,
      if (name != null) "name": name,
      if (paymentType != null) "payment_type": paymentType,
      if (address != null) "address": address,
      if (secCode != null) "sec_code": secCode,
    });

    if (!response.status) {
      throw response.error!;
    }
    return true;
  }

  Future<bool> deleteAccount(String id, {String? secCode}) async {
    final response = await HttpClient.get(
      Api.accountDelete,
      queryParameters: {
        "id": id,
        if (secCode != null) "sec_code": secCode,
      },
    );

    if (!response.status) {
      throw response.error!;
    }
    return true;
  }

  Future<WithdrawLimitModel> getWithdrawLimits(Currency currency) async {
    final response = await HttpClient.get(Api.withdrawLimit, queryParameters: {
      'currency': int.parse(currency.code),
    });

    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is Map) {
      final convert = compose(WithdrawLimitModel.fromJson, Map<String, dynamic>.from);
      return convert(response.data);
    } else {
      throw Exception('Invalid response format');
    }
  }

  Future<WithdrawModel?> withdraw(
    String pid,
    String accountId,
    String amount,
    String currencyCode,
    String withdrawalPassword,
  ) async {
    final response = await HttpClient.get(Api.withdrawV2, queryParameters: {
      "pid": pid,
      "account_id": accountId,
      "currency_amount": amount,
      "currency": int.parse(currencyCode),
      "withdrawal_password": withdrawalPassword,
    });
    var msg = response.message;
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is Map) {
      final convert = compose(
        WithdrawModel.fromJson,
        Map<String, dynamic>.from,
      );
      return convert(response.data);
    } else {
      throw Exception('Invalid response format');
    }
  }

  Future<RespFlowDetail?> queryWithdrawTurnoverList(int pageSize, String? cur) async {
    try {
      final response = await HttpClient.get(
        Api.withdrawTurnoverList,
        queryParameters: {
          'page_size': pageSize,
          if (cur != null) 'cur': cur,
        },
      );
      if (response.status == false) {
        AppUtils.showToastForResponse(response.message);
        return null;
      }
      return RespFlowDetail.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
