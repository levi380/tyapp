import 'package:filbet/api/api.dart';
import 'package:filbet/common/currency.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/src/mine/accountChangeRecord/account_change_record_model.dart';
import 'package:filbet/utils/fp.dart';

class AccountChangeService {
  Future<AccountChangeRecordDepositModel> getAccountChangeDepositModel({
    int? size,
    Currency? currency,
    required String startAt,
    required String endAt,
    String? cur,
    int? orderStatus,
  }) async {
    final response = await HttpClient.get(
      Api.depositList,
      queryParameters: {
        'size': size ?? kPaginationSize,
        'start_at': startAt,
        'end_at': endAt,
        'currency': currency?.code ?? '0',
        if (cur != null) 'cur': cur,
        if (orderStatus != null) 'order_status': orderStatus,
      },
    );
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is Map) {
      final data = response.data;
      return compose(
        AccountChangeRecordDepositModel.fromJson,
        Map<String, dynamic>.from,
      )(data);
    } else {
      throw Exception('Invalid response format');
    }
  }

  Future<AccountChangeRecordWithdrawModel> getAccountChangeWithdrawModel({
    int? size,
    Currency? currency,
    required String startAt,
    required String endAt,
    String? cur,
    int? orderStatus,
  }) async {
    final response = await HttpClient.get(Api.withdrawList, queryParameters: {
      'size': size ?? kPaginationSize,
      'start_at': startAt,
      'end_at': endAt,
      'currency': currency?.code ?? '0',
      if (cur != null) 'cur': cur,
      if (orderStatus != null) 'order_status': orderStatus,
    });
    if (response.status == false) {
      throw response.error!;
    }
    if (response.data is Map) {
      final data = response.data;
      return compose(
        AccountChangeRecordWithdrawModel.fromJson,
        Map<String, dynamic>.from,
      )(data);
    } else {
      throw Exception('Invalid response format');
    }
  }
}
