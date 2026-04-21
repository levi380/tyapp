import 'dart:async';

import 'package:filbet/common/currency.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/user/user_state.dart';
import 'package:filbet/widgets/select_bottom_sheet.dart';
import 'package:filbet/widgets/wallet_component_builder.dart';
import 'package:get/get.dart';
import 'package:filbet/services/global/global_service.dart';

extension UserStateViewExtension on UserServiceState {
  Future<Currency?> presentChangeUserDefaultCurrencyBottomSheet(
      {autoSaved = true}) {
    final completer = Completer<Currency?>();

    final items = GlobalService.to.state.currencyConfig.map((currency) {
      return BottomSelectModel(
        imgUrl: currency.imagePath,
        keyValue: currency.toString(),
        title: currency.name,
        width: 36,
        height: 36
      );
    }).toList();

    final selectedItem = items.firstWhere(
      (item) => item.keyValue == UserService.to.state.currencyType.toString(),
      orElse: () => items.first,
    );

    final sheet = SelectBottomSheet(
      title: 'choose_currency'.tr,
      itemList: items,
      onValueChanged: (model) {
        final selectedCurrency =
            GlobalService.to.state.currencyConfig.firstWhere(
          (currency) => currency.toString() == model.keyValue,
        );
        if (autoSaved) {
//          UserService.to.state.currencyType = selectedCurrency;
          UserService.to.state.userInfo.currency =
              int.parse(selectedCurrency.code!);
          UserService.to
              .currencyChange(currency: int.parse(selectedCurrency.code!));
        }
        completer.complete(selectedCurrency);
      },
      selectedItem: selectedItem,
    );

    Get.bottomSheet(sheet).then((_) {
      if (!completer.isCompleted) {
        completer.complete(null);
      }
    });

    return completer.future;
  }
}
