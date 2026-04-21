import 'package:flutter_ty_app/app/modules/group_bet/bets/ongoing/ongoing_bets_logic.dart';

import '../../../login/login_head_import.dart';
import '../widgets/toggle_title_view.dart';
import 'ongoing_initiated/ongoing_initiated_logic.dart';
import 'ongoing_initiated/ongoing_initiated_view.dart';
import 'ongoing_participate/ongoing_participate_logic.dart';
import 'ongoing_participate/ongoing_participate_view.dart';

class OngoingBetsPage extends StatefulWidget {
  const OngoingBetsPage({Key? key}) : super(key: key);

  @override
  State<OngoingBetsPage> createState() => _OngoingBetsPageState();
}

class _OngoingBetsPageState extends State<OngoingBetsPage> {
  final logic = Get.find<OngoingBetsLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //     appBar: AppBar(
      //     elevation: 0,
      //     centerTitle: true,
      //     leading: InkWell(
      //     onTap: ()
      // {
      //   Get.back();
      // },
      // child: Container(
      // alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(horizontal: 5.w),
      // child: Image.asset(
      // "assets/images/teselol/return.png",
      // width: 15.w,
      // ),
      // ),
      // title: const Text(
      // "赛事分析",
      // style: TextStyle(color: Colors.white, fontSize: 16),
      // ),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50.h),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              size: 18.w,
              Icons.arrow_back_ios,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          title: _title(),
        ),
      ),

      body: _body(),
      //backgroundColor:
      //    context.isDarkMode ? AppColor.titleBackgroundColor : Colors.white,
    );
  }

  Widget _title() {
    return Obx(
      () => ToggleTitleView(
        type: logic.type.value,
        onChanged: (int value) {
          logic.setType(value);
        },
      ),
    );
  }

  Widget _body() {
    return GetBuilder<OngoingBetsLogic>(
      builder: (logic) {
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 10.h,
                color: Color(0xFFF3FAFF),
              ),
              Expanded(child: _contentBetsView(logic.type.value)),
            ],
          ),
        );
      },
    );
  }

  Widget _contentBetsView(int type) {
    if (logic.type == 0) {
      Get.delete<OngoingParticipateLogic>();
      Get.lazyPut(
        () => OngoingInitiatedLogic(),
      );
      return OngoingInitiatedPage();
    } else if (logic.type == 1) {
      Get.delete<OngoingInitiatedLogic>();
      Get.lazyPut(
        () => OngoingParticipateLogic(),
      );
      return OngoingParticipatePage();
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    Get.delete<OngoingBetsLogic>();
    super.dispose();
  }
}
