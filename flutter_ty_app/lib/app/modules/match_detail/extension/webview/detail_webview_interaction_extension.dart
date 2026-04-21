import 'dart:convert';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';
import '../../controllers/match_detail_controller.dart';
import '../../models/header_type_enum.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE webview】】】
    【【【 AUTO_PARAGRAPH_TITLE webview交互逻辑】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 与webview的交互主要通过runJavaScript 来实现
    】】】
 *
 */
extension DetailWebViewInteractionExtension on MatchDetailController {
  ///@description: 给iframe发送全局视频类型变化事件
  ///@param {int} type 1:高清flv, 2:流畅m3u8
  switchVideoUrl({int type = 0}) {
    sendMessage({"cmd": 'switch_type', "val": type});
  }

  /// 声音切换
  switchVideoVolume() async {
    await FlutterVolumeController.updateShowSystemUI(true);
    if (detailState.liveMuted.value) {
      await FlutterVolumeController.setVolume(0.7);
      // sendMessage({"cmd": 'volume_video', "volume": 1});
      detailState.liveMuted.value = false;
    } else {
      await FlutterVolumeController.setMute(true);
      // sendMessage({"cmd": 'volume_video', 'volume': 0});
      detailState.liveMuted.value = true;
    }
  }

  /// 视频打码
  djImageCoding() {
    if (detailState.isDJDetail && detailState.match?.h5Data != null) {
      sendMessage({"cmd": 'image_coding'});
    }
  }

  /// 发送指令
  sendMessage(Map map) async {
    if (detailState.headerType.value == HeaderType.live) {
      String msg = jsonEncode(map);
      if (map['cmd'] == 'switch_type') {
        // 正在切换高清一、二 提示语
        String toggleMsg = LocaleKeys.app_toggle_hd_video1.tr;
        if (map['val'] == 1) {
          toggleMsg = LocaleKeys.app_toggle_hd_video2.tr;
        }

        await detailState.webViewController.runJavaScript(
            "document.getElementById('iframe').contentWindow.postMessage($msg,'*')");
        await detailState.webViewController
            .runJavaScript("index.video_msg('$toggleMsg')");
        await detailState.webViewController
            .runJavaScript("index.playM3u8(${map['val']})");
      } else if (map['cmd'] == 'volume_video') {
        // 声音关闭打开 是通过操作html video标签muted属性实现。缺陷：html播放方式更改有可能会失效
        if (map['volume'] == 0) {
          await detailState.webViewController.runJavaScript('''
            var videos = document.getElementById('iframe').contentWindow.document.getElementsByTagName('video');
            for (var i = 0; i < videos.length; i++) {
              videos[i].muted = true;
            }
          ''');
        } else {
          await detailState.webViewController.runJavaScript('''
            var videos = document.getElementById('iframe').contentWindow.document.getElementsByTagName('video');
            for (var i = 0; i < videos.length; i++) {
              videos[i].muted = false;
            }
          ''');
        }
      }
      // 电竞打码
      else if (map['cmd'] == 'image_coding') {
        var data = {
          "type": 0,
          "data": {
            "data_list": [
              {
                "h5_data": detailState.match?.h5Data?.toJson(),
                "conf_type": 1,
                "state": 1,
              },
            ],
          },
        };
        String message = jsonEncode(data);
        await detailState.webViewController
            .runJavaScript("window.postMessage($message,'*')");
      } else {
        await detailState.webViewController.runJavaScript(
            "document.getElementById('iframe').contentWindow.postMessage($msg,'*')");
      }
    }
  }
}
