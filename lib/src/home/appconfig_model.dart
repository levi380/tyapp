import 'dart:convert';

import 'dart:io';

import 'package:filbet/http/entity/jump_config_model.dart';
import 'package:filbet/utils/common_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConfigModel {
  List<BannerItem>? banner;
  List<SplashModel>? loading;
  List<NoticeModel>? marqueeNotice;

  AppConfigModel({
    this.banner,
    this.loading,
    this.marqueeNotice,
  });

  AppConfigModel.fromJson(Map<String, dynamic> json) {
    // 解析 banner
    final bannerList = json['banner'];
    if (bannerList is List) {
      banner = bannerList
          .map((e) {
            if (e is Map) {
              return BannerItem.fromJson(
                e.map((k, v) => MapEntry(k.toString(), v)),
              );
            }
            return null;
          })
          .whereType<BannerItem>()
          .toList();
    }

    // 解析 loading（SplashModel）
    final loadingList = json['loading'];
    if (loadingList is List) {
      loading = loadingList
          .map((e) {
            if (e is Map) {
              return SplashModel.fromJson(
                e.map((k, v) => MapEntry(k.toString(), v)),
              );
            }
            return null;
          })
          .whereType<SplashModel>()
          .toList();
    }

    // 解析 marquee_notice（NoticeModel）
    final noticeList = json['marquee_notice'];
    if (noticeList is List) {
      marqueeNotice = noticeList
          .map((e) {
            if (e is Map) {
              return NoticeModel.fromJson(
                e.map((k, v) => MapEntry(k.toString(), v)),
              );
            }
            return null;
          })
          .whereType<NoticeModel>()
          .toList();
    }
  }
}

class BannerItem {
  final int? ty;
  final String? title;
  final String? img;
  final int? seq;

  final int? jumpType;
  final int? linkType;
  final String? activityId;
  final String? detailLink;
  final num? activityType;

  BannerItem({
    this.ty,
    this.title,
    this.img,
    this.seq,
    this.jumpType,
    this.linkType,
    this.activityId,
    this.detailLink,
    this.activityType,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      ty: json['ty'],
      title: json['title'] as String?,
      img: json['img'],
      seq: json['seq'] as int?,
      jumpType: json['jump_type'],
      linkType: json['link_type'],
      activityId: json['activity_id'],
      detailLink: json['detail_link'],
      activityType: json['activity_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (ty != null) 'ty': ty,
      if (title != null) 'title': title,
      if (img != null) 'img': img,
      if (seq != null) 'seq': seq,
    };
  }
}

class SplashModel {
  final String ty;
  final List<String> img;
  final List<String>? imgIos;
  final List<String>? imgIosFull;

  SplashModel({
    required this.ty,
    required this.img,
    this.imgIos,
    this.imgIosFull,
  });

  factory SplashModel.fromJson(Map<String, dynamic> json) {
    return SplashModel(
      ty: '${json['ty'] ?? ''}',
      img: (json['img'] as List<dynamic>).map((e) => e as String).toList(),
      imgIos: json['img_ios'] != null
          ? (json['img_ios'] as List<dynamic>).map((e) => e as String).toList()
          : null,
      imgIosFull: json['img_ios_full'] != null
          ? (json['img_ios_full'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ty': ty,
      'img': img,
      'img_ios': imgIos,
      'img_ios_full': imgIosFull,
    };
  }

  Future<String?> imageForSinglePhotoView() async {
    final paths = await getDownloadedImagePaths();
    return paths.firstOrNull;
  }

  List<String> getImageUrlsForDevice({BuildContext? context}) {
    List<String> splashImages = [];
    if (kIsWeb) {
      splashImages = img;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      splashImages = img;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // get context
      if (isIPhoneWithNotch(context ?? Get.context!)) {
        splashImages = imgIosFull ?? [];
      } else {
        splashImages = imgIos ?? [];
      }
    }
    return splashImages;
  }

  Future<List<String>> getDownloadedImagePaths() async {
    final imageUrls = getImageUrlsForDevice();
    final paths = <String>[];
    for (final url in imageUrls) {
      final filename = url.split('/').last;
      final path = await getSplashImageSavePath(filename);
      final file = File(path);
      if (await file.exists()) {
        paths.add(path);
      }
    }
    return paths;
  }

  Future<bool> hasDownloadedImages() async {
    final paths = await getDownloadedImagePaths();
    return paths.isNotEmpty;
  }
}

class NoticeModel {
  String? id;
  String? title;
  String? content;
  int? noticeType;

//  List<Object?>? devices;
  String? vipLevels;
  String? iconUrl;
  int? jumpType;
  String? jumpConfig;
  int? sort;
  int? isTop;
  int? startTime;
  int? endTime;
  int? createdAt;
  int? readState;
  int? publishedAt;
  int? enableStartTime;
  int? enableEndTime;
  JumpConfigModel? jumpConfigModel;
  String? imageUrlApp;
  final checked = false.obs;

  NoticeModel({
    this.id,
    this.title,
    this.content,
    this.noticeType,
//    this.devices,
    this.vipLevels,
    this.iconUrl,
    this.jumpType,
    this.jumpConfig,
    this.startTime,
    this.endTime,
    this.enableStartTime,
    this.enableEndTime,
    this.sort,
    this.createdAt,
    this.publishedAt,
    this.readState,
    this.isTop,
    this.jumpConfigModel,
  });

  NoticeModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    noticeType = int.tryParse(json['notice_type'].toString());
//      devices:=json['devices'],
    vipLevels = json['vipLevels'];
    iconUrl = json['icon_url'];
    jumpType = json['jump_type'];
    jumpConfig = json['jump_config'];
    sort = json['sort'];
    isTop = json['is_top'];
    imageUrlApp = json['image_url_app'];
    startTime = int.tryParse(json['start_time'].toString());
    endTime = int.tryParse(json['end_time'].toString());
    enableStartTime = int.tryParse(json['enable_start_time'].toString());
    enableEndTime = int.tryParse(json['enable_end_time'].toString());
    createdAt = int.tryParse(json['created_at'].toString());
    publishedAt = int.tryParse(json['published_at'].toString());
    readState = int.tryParse(json['read_state'].toString());
    if (jumpConfig?.isNotEmpty == true) {
      try {
        jumpConfigModel = JumpConfigModel.fromJson(jsonDecode(jumpConfig!));
      } catch (e) {
      }
    }
  }
}
