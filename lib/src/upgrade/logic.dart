import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:ota_update/ota_update.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class UpgradeLogic extends GetxController {
  OtaEvent? event;
  double progress = 0;
  bool isdowlod = false;

  void updateVersion(String downUrl) async {
    String url = downUrl;
    if (Platform.isIOS) {
      AppUtils.launchH5(url);
    } else if (Platform.isAndroid) {
      if (url.endsWith("apk") == false) {
        if (!await launchUrl(Uri.parse(url),
            mode: LaunchMode.externalApplication)) {
          // SmartDialog.showToast("链接有问题");
        }

        return;
      }
      try {
        toUpdate(url, 0);
      } catch (e) {
        // SmartDialog.showToast("链接有问题");
      }
    }
  }

  void toUpdate(String url, int beginSeconds) async {
    if ((event != null && event!.status == OtaStatus.DOWNLOADING)) {
      AppUtils.showToast("权限不够");
      ;
      return;
    }
    if (Platform.isAndroid) {
      // 1. 获取本地存储路径
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/sk.apk";

      // 2. 检查并删除旧文件
      File oldApk = File(filePath);
      if (await oldApk.exists()) {
        print("发现旧APK，已删除");
        await oldApk.delete();
      }

      isdowlod = true;

      if (await requestInstallPermission()) {
        OtaUpdate()
            .execute(
          url,
          destinationFilename: 'sk.apk',
        )
            .listen(
          (OtaEvent event) async {
            this.event = event;
            switch (event.status) {
              case OtaStatus.DOWNLOADING: // 下载中
                // progress = '下载进度:${event.value}%';
                progress = double.parse(event.value!) / 100;
                update();
                break;
              case OtaStatus.INSTALLING: //安装中
                // _buryThePoint(beginSeconds);
                Get.back();
                update();
                break;
              case OtaStatus.PERMISSION_NOT_GRANTED_ERROR: // 权限错误
                checkPermissFunction();
                break;
              default: // 其他问题
                {
                  if (!await launchUrl(
                    Uri.parse(url),
                  )) {
                    // SmartDialog.showToast("链接有问题");
                  }
                  Get.back();
                }
                break;
            }
          },
        );
        // 调用 ota_update 安装
      } else {
        // 提示用户去设置开启权限
        //  SmartDialog.showToast("权限不够");
        requestInstallPermission();
      }
    }
  }

  Future<bool> requestInstallPermission() async {
    if (await Permission.requestInstallPackages.isGranted) {
      return true;
    }
    var status = await Permission.requestInstallPackages.request();
    return status.isGranted;
  }

  Future<bool> checkPermissFunction() async {
    //获取当前的权限
    var status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
