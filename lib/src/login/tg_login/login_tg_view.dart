import 'package:country_picker/country_picker.dart';
import 'package:filbet/src/login/login_and_register_text_field.dart';
import 'package:filbet/src/login/login_register_commit_button.dart';
import 'package:filbet/src/login/tg_login/login_tg_controller.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/http/exception_user_message.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/loadinng_view.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:telegram_login_flutter/telegram_login_flutter.dart';

class LoginTelegramView extends GetView<LoginTelegramController> {
  LoginTelegramView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      backgroundColor: appnewColors.bg5,
      showBgTexture: false,
      appBar: CustomAppbar.normalTitle(
        title: "Telegram".tr,
        bgColor: appnewColors.bg5,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                exclude: <String>['KN', 'MF'],
                                favorite: <String>['SE'],
                                //Optional. Shows phone code before the country name.
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  controller.country.value = country;
                                },
                                // Optional. Sheet moves when keyboard opens.
                                moveAlongWithKeyboard: false,
                                // Optional. Sets the theme for the country list picker.
                                countryListTheme: CountryListThemeData(
                                  // Optional. Sets the border radius for the bottomsheet.
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  // Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  // Optional. Styles the text in the search field
                                  searchTextStyle: TextStyle(
                                    color: appColors.textMainColor,
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            },
                            child: Obx(
                              () => Text(
                                "+${controller.country.value?.phoneCode ?? "86"}",
                                style: TextStyle(
                                    color: appColors.textMainColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: LoginAndRegisterTextField(
                      controller: controller.phoneController,
                      hintText: 'input_phone_number'.tr,
                      fillColor: appnewColors.bg1.withOpacity(0.5),
                      cornerRadius: 20.r,
                      isError: false,
                      textInputAction: TextInputAction.next,
                    ))
                  ],
                ),
                const SizedBox(height: 20),

                Obx(() {
                  final canTap = controller.loginInvalid.value &&
                      !controller.isLoading.value;
                  return LoginRegisterCommitButton(
                    canTap: canTap,
                    onPressed: () {
                      _handleLogin(context);
                    },
                    label: 'login'.tr,
                  );
                }),
                const SizedBox(height: 20),
                // if (controller.user != null) _buildUserInfo(),
              ],
            ),
          ),
          Obx(() =>
              (controller.isLoading.value) ? loadinngView() : Container()),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    String? photoUrl = controller.user!.photoUrl.isNotEmpty
        ? controller.user!.photoUrl.replaceAll(RegExp(r'(?<!:)/+'), '/')
        : null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('User Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            if (photoUrl != null)
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(photoUrl),
                  onBackgroundImageError: (e, stack) {
                    // Fallback if image fails to load
                    return;
                  },
                ),
              ),
            const SizedBox(height: 16),
            _buildInfoRow('First Name', controller.user!.firstName),
            if (controller.user!.lastName.isNotEmpty)
              _buildInfoRow('Last Name', controller.user!.lastName),
            _buildInfoRow(
                'Username',
                controller.user!.username.isNotEmpty
                    ? '@${controller.user!.username}'
                    : 'Not provided'),
            _buildInfoRow('User ID', controller.user!.id),
            _buildInfoRow(
                'Auth Date',
                DateTime.fromMillisecondsSinceEpoch(
                        int.parse(controller.user!.authDate))
                    .toString()),
            _buildInfoRow(
                'Hash', '${controller.user!.hash.substring(0, 12)}...'),
            // Show partial hash
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text('$label:',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    controller.isLoading.value = true;
    controller.user = null;

    try {
      final telegramAuth = TelegramAuth(
        botId: controller.tgBotId,
        botDomain: controller.tgDomain,
        phoneNumber:
            '+${controller.country.value?.phoneCode ?? "86"}${controller.phoneController.text.trim()}',
      );

      // Step 1: Initiate login
      final initiated = await telegramAuth.initiateLogin();
      if (!initiated) throw Exception('Failed to initiate login');

      // Step 2: Launch Telegram
      await telegramAuth.launchTelegram();

      // Step 3: Check login status periodically
      bool isLoggedIn = false;
      final timeout = DateTime.now().add(const Duration(seconds: 60));

      while (!isLoggedIn && DateTime.now().isBefore(timeout)) {
        await Future.delayed(const Duration(seconds: 2));
        isLoggedIn = await telegramAuth.checkLoginStatus();
        if (isLoggedIn) {
          final user = await telegramAuth.getUserData();
          controller.user = user;
          if (user != null) {
            controller.loginWithTelegaram({
              "id": int.parse(controller.user!.id),
              "first_name": controller.user!.firstName,
              "last_name": controller.user!.lastName,
              "photo_url": controller.user!.photoUrl,
              "username": controller.user!.username,
              "auth_date": int.parse(controller.user!.authDate),
              "hash": controller.user!.hash,
            });
          }
        }
      }

      if (!isLoggedIn) {
        throw Exception('Login timeout - please try again');
      }
    } catch (e) {
      AppUtils.showToast(exceptionMessageForUser(e));
    } finally {
      controller.isLoading.value = false;
    }
  }
}
