import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/deposit/channel_model.dart';
import 'package:filbet/src/deposit/deposit_tutorial_model.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:filbet/utils/payment_type.dart';
import 'package:get/get.dart';

class DepositTutorialController extends GetXBaseController {
  RxList<DepositTutorialModel> channelList = RxList.empty();
  final Rx<DepositTutorialModel?> selectedChannel =
      Rx<DepositTutorialModel?>(null);
  final RxList<ChannelModel> tempChannelList = RxList.empty();
  final Rx<ChannelModel?> tempSelectedChannel = Rx<ChannelModel?>(null);
  final RxInt currentStep = 1.obs;

  final WalletService _walletService = Get.find<WalletService>();

  DepositTutorialController({
    required List<ChannelModel>? channelList,
    required ChannelModel? selectedChannel,
  }) {
    this.tempChannelList.value = channelList ?? [];
    this.tempSelectedChannel.value = selectedChannel;
  }

  // 支付宝 tab 相关
  final RxInt selectedAlipayTabIndex = 0.obs;
  final List<String> alipayTabs = [
    '飞行模式'.tr,
    '仿原生'.tr,
    '二次输入金额'.tr,
    '截图扫码'.tr,
    '存款错误'.tr,
  ];

  Map<String, dynamic> config = {
    "1": [
      Assets.tutorialIconNoWalletU1,
      Assets.tutorialIconNoWalletU2,
      Assets.tutorialIconNoWalletU3,
      Assets.tutorialIconNoWalletU4,
    ],
    "2": [
      Assets.tutorialIconNoWalletU1,
      Assets.tutorialIconNoWalletU2,
      Assets.tutorialIconNoWalletU3,
      Assets.tutorialIconNoWalletU4,
    ],
    "3": [
      Assets.tutorialIconEbWallet1,
      Assets.tutorialIconEbWallet2,
      Assets.tutorialIconEbWallet3,
      Assets.tutorialIconEbWallet4,
      Assets.tutorialIconEbWallet5,
      Assets.tutorialIconEbWallet6,
    ],
    "4": [
      Assets.tutorialIconNoWallet1,
      Assets.tutorialIconNoWallet2,
      Assets.tutorialIconNoWallet3,
      Assets.tutorialIconNoWallet4,
    ],
    "5": [
      Assets.tutorialIconHdWallet1,
      Assets.tutorialIconHdWallet2,
      Assets.tutorialIconHdWallet3,
      Assets.tutorialIconHdWallet4,
      Assets.tutorialIconHdWallet5,
    ],
    "6": [
      Assets.tutorialIconBank1,
      Assets.tutorialIconBank2,
      Assets.tutorialIconBank3,
      Assets.tutorialIconBank4,
    ],
    // 支付宝配置结构：paymentType 为 7 时，使用嵌套结构，key 为 tab 名称
    "7": {
      "飞行模式".tr: [
        Assets.tutorialIconAliFly1,
        Assets.tutorialIconAliFly2,
        Assets.tutorialIconAliFly3,
        Assets.tutorialIconAliFly4,
        Assets.tutorialIconAliFly5,
        Assets.tutorialIconAliFly6,
        Assets.tutorialIconAliFly7,
        Assets.tutorialIconAliFly8,
      ],
      "仿原生".tr: [
        Assets.tutorialIconAliOrigin1,
        Assets.tutorialIconAliOrigin2,
        Assets.tutorialIconAliOrigin3,
        Assets.tutorialIconAliOrigin4,
      ],
      "二次输入金额".tr: [
        Assets.tutorialIconAliDouble1,
        Assets.tutorialIconAliDouble2,
        Assets.tutorialIconAliDouble3,
        Assets.tutorialIconAliDouble4,
        Assets.tutorialIconAliDouble5,
        Assets.tutorialIconAliDouble6,
        Assets.tutorialIconAliDouble7,
        Assets.tutorialIconAliDouble8,
        Assets.tutorialIconAliDouble9,
      ],
      "截图扫码".tr: [
        Assets.tutorialIconAliScan1,
        Assets.tutorialIconAliScan2,
        Assets.tutorialIconAliScan3,
        Assets.tutorialIconAliScan4,
        Assets.tutorialIconAliScan5,
        Assets.tutorialIconAliScan6,
      ],
      "存款错误".tr: [
        Assets.tutorialIconAliErr1,
        Assets.tutorialIconAliErr2,
        Assets.tutorialIconAliErr3,
        Assets.tutorialIconAliErr4,
        Assets.tutorialIconAliErr5,
      ],
    },

    "8": [
      Assets.tutorialIconWechat1,
      Assets.tutorialIconWechat2,
      Assets.tutorialIconWechat3,
      Assets.tutorialIconWechat4,
      Assets.tutorialIconWechat5,
      Assets.tutorialIconWechat6,
    ],

    "9": [
      Assets.tutorialIconMpay1,
      Assets.tutorialIconMpay2,
      Assets.tutorialIconMpay3,
      Assets.tutorialIconMpay4,
      Assets.tutorialIconMpay5,
    ],
    "${PayType.to_pay.code}": [
      Assets.tutorialIconToPay1,
      Assets.tutorialIconToPay2,
      Assets.tutorialIconToPay3,
      Assets.tutorialIconToPay4,
      Assets.tutorialIconToPay5,
      Assets.tutorialIconToPay6,
    ],
    "${PayType.cb_pay.code}": [
      Assets.tutorialIconCbPay1,
      Assets.tutorialIconCbPay2,
      Assets.tutorialIconCbPay3,
      Assets.tutorialIconCbPay4,
      Assets.tutorialIconCbPay5,
    ],
    "${PayType.w_pay.code}": [
      Assets.tutorialIconWPay1,
      Assets.tutorialIconWPay2,
      Assets.tutorialIconWPay3,
    ],
    "${PayType.go_pay.code}": [
      Assets.tutorialIconGoPay1,
      Assets.tutorialIconGoPay2,
      Assets.tutorialIconGoPay3,
      Assets.tutorialIconGoPay4,
      Assets.tutorialIconGoPay5,
      Assets.tutorialIconGoPay6,
    ],
    "${PayType.p365_pay.code}": [
      Assets.tutorialIcon365Pay1,
      Assets.tutorialIcon365Pay2,
      Assets.tutorialIcon365Pay3,
      Assets.tutorialIcon365Pay4,
    ],
    "${PayType.f_pay.code}": [
      Assets.tutorialIconFPay1,
      Assets.tutorialIconFPay2,
      Assets.tutorialIconFPay3,
    ],
    "${PayType.no_pay.code}": [
      Assets.tutorialIconNoPay1,
      Assets.tutorialIconNoPay2,
      Assets.tutorialIconNoPay3,
      Assets.tutorialIconNoPay4,
      Assets.tutorialIconNoPay5,
    ],
    "${PayType.ok_pay.code}": [
      Assets.tutorialIconOkPay1,
      Assets.tutorialIconOkPay2,
      Assets.tutorialIconOkPay3,
      Assets.tutorialIconOkPay4,
      Assets.tutorialIconOkPay5,
      Assets.tutorialIconOkPay6,
    ],
    "${PayType.qn_pay.code}": [
      Assets.tutorialIconQnPay1,
      Assets.tutorialIconQnPay2,
      Assets.tutorialIconQnPay3,
    ],
    "${PayType.bo_pay.code}": [
      Assets.tutorialIconBoBi1,
      Assets.tutorialIconBoBi2,
      Assets.tutorialIconBoBi3,
    ],
    "${PayType.union_pay.code}": [
      Assets.tutorialIconUnionPay1,
      Assets.tutorialIconUnionPay2,
      Assets.tutorialIconUnionPay3,
      Assets.tutorialIconUnionPay4,
      Assets.tutorialIconUnionPay5,
    ],
  };

  // 判断是否为支付宝类型
  bool get isAlipayType {
    return selectedChannel.value?.paymentType == 7;
  }

  // 根据当前选择的渠道获取图片列表
  List<String> get currentTutorialImages {
    final channel = selectedChannel.value;
    if (channel == null) {
      return [];
    }

    // 支付宝类型特殊处理
    if (channel.paymentType == 7) {
      final alipayConfig = config["7"];
      if (alipayConfig == null || alipayConfig is! Map) {
        return [];
      }

      final tabName = alipayTabs[selectedAlipayTabIndex.value];
      final imageList = alipayConfig[tabName];

      if (imageList == null || imageList is! List) {
        return [];
      }

      return List<String>.from(imageList);
    }

    // 其他类型的处理逻辑
    String configKey;

    // 如果 paymentType 为 1，使用 paymentType 和 name 转小写后用 "-" 拼接
    // if (channel.paymentType == 1) {
    //   final name = channel.name.toLowerCase();
    //   configKey = '${channel.paymentType}-$name';
    // } else {
    // 其他情况直接使用 paymentType 作为 key
    configKey = channel.paymentType.toString();
    // }

    final imageList = config[configKey];

    if (imageList == null || imageList is! List) {
      return [];
    }

    return List<String>.from(imageList);
  }

  // 选择支付宝 tab
  void selectAlipayTab(int index) {
    selectedAlipayTabIndex.value = index;
    currentStep.value = 1;
  }

  @override
  void onInit() {
    super.onInit();
    iniData();
    if (tempSelectedChannel.value == null) {
      // 如果有渠道列表但没有选中项，默认选中第一个
      selectedChannel.value = channelList.firstOrNull;
    } else {
      for (var v in channelList) {
        if (v.paymentType == tempSelectedChannel.value?.paymentType) {
          selectedChannel.value = v;
        }
      }
    }

    if (selectedChannel.value == null) {
      // 如果有渠道列表但没有选中项，默认选中第一个
      selectedChannel.value = channelList.firstOrNull;
    }

    // 如果渠道列表为空，通过接口获取
    // if (channelList.isEmpty) {
    //   _loadDepositChannels();
    // } else if (selectedChannel.value == null) {
    //   // 如果有渠道列表但没有选中项，默认选中第一个
    //   selectedChannel.value = channelList.firstOrNull;
    // }
  }

  /// 获取充值渠道列表（如果没有传递数据时调用）
  // Future<void> _loadDepositChannels() async {
  //   final currency = UserService.to.state.currencyType;
  //   final currencyCode = currency.code;
  //
  //   await fetchHandler<List<ChannelModel>>(
  //     _walletService.getChannelLsit(currencyCode, "1"),
  //     onSuccess: (list) {
  //       if (list.isNotEmpty) {
  //         channelList.value = list;
  //         list.sort((a, b) => a.sort.compareTo(b.sort));
  //         selectedChannel.value = list.firstOrNull;
  //       } else {
  //         channelList.value = [];
  //       }
  //     },
  //     onError: (error) {
  //       // 如果获取失败，保持空列表
  //       channelList.value = [];
  //       toastError(error);
  //     },
  //     loading: false,
  //   );
  // }

  // 选择渠道
  void selectChannel(DepositTutorialModel channel) {
    selectedChannel.value = channel;
    currentStep.value = 1;
    // 切换渠道时，如果是支付宝类型，重置 tab 索引
    if (channel.paymentType == 7) {
      selectedAlipayTabIndex.value = 0;
    }
  }

  void iniData() {
    //链路协议 1：TRC20 2:ERC20  3 EB Pay ,4 NO Wallet ,5 HD Pay ,6 银行卡 ,7 支付宝 , 8 微信 ，9 Mpay 钱包
    List<DepositTutorialModel>? tempChannelList = [];
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.bankCard.code,
          name: PayType.bankCard.key,
          img: Assets.tutorialIconTutorialBank),
    );
    tempChannelList.add(DepositTutorialModel(
        paymentType: PayType.alipay.code,
        name: PayType.alipay.key,
        img: Assets.tutorialIconTutorialAlipay));
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.trc20.code,
          name: "USDT",
          img: Assets.tutorialIconTutorialUsdt),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.ebPay.code,
          name: "EB钱包",
          img: Assets.tutorialIconTutorialEb),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.noWallet.code,
          name: "No钱包",
          img: Assets.tutorialIconTutorialNo),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.hdPay.code,
          name: "HD钱包",
          img: Assets.tutorialIconTutorialHd),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.wechat.code,
          name: "微信支付",
          img: Assets.tutorialIconTutorialWechat),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.Mpay.code,
          name: "Mpay钱包",
          img: Assets.tutorialIconTutorialMpay),
    );

    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.to_pay.code,
          name: "TOPAY",
          img: Assets.tutorialToPay),
    );

    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.cb_pay.code,
          name: "CBPAY",
          img: Assets.tutorialCbPay),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.w_pay.code,
          name: "WPAY",
          img: Assets.tutorialWPay),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.go_pay.code,
          name: "GOPAY",
          img: Assets.tutorialGoPay),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.p365_pay.code,
          name: "365PAY",
          img: Assets.tutorialToPay),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.f_pay.code,
          name: "FPAY",
          img: Assets.tutorialFpay),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.no_pay.code,
          name: "NOPAY",
          img: Assets.tutorialNoPay),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.ok_pay.code,
          name: "OKPAY",
          img: Assets.tutorialOkPay),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.qn_pay.code,
          name: "QNPAY",
          img: Assets.tutorialQnPay),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.bo_pay.code,
          name: "波币",
          img: Assets.tutorialBobi),
    );
    tempChannelList.add(
      DepositTutorialModel(
          paymentType: PayType.union_pay.code,
          name: "银联扫码",
          img: Assets.tutorialIconTutorialBank),
    );


    channelList.addAll(tempChannelList);
  }
}
