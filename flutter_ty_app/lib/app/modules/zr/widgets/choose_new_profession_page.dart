import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

///选择新手版还是专业版布局
class chooseNewOrProfessionPage extends StatelessWidget {
  var callback;

  chooseNewOrProfessionPage({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              callback();
            },
            child: Padding(
              padding: EdgeInsets.all(ZrState.space20),
              child: SizedBox(
                width: ZrState.guideCloseIconSize,
                height: ZrState.guideCloseIconSize,
                child:
                    const ImageView(ZrState.guideCloseIcon),
              ),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(ZrState.radius20))),
          margin: EdgeInsets.symmetric(horizontal: ZrState.space20),
          padding: EdgeInsets.symmetric(horizontal: ZrState.space20, vertical: ZrState.space20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///专业版布局
              Column(
                children: [
                  SizedBox(
                    width: ZrState.guideCardImageSize,
                    height: ZrState.guideCardImageSize,
                    child: Stack(children: [
                      const ImageView(
                        ZrState.guideProfessionImage,
                        boxFit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: ZrState.guideCardImageSize,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10.w,
                            ),
                            Text(
                              LocaleKeys.common_zhuanye.tr,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: ZrState.textColorPrimary,
                              ),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Text(
                              LocaleKeys.common_gongnengwanshan.tr,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ZrState.textColorSecondary),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      ///通知HomeController,更新主列表UI
                      TyHomeController.to.homeState.isProfess = true;
                      TyHomeController.to.update();
                      Navigator.pop(context);
                      callback();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.w),
                      margin: EdgeInsets.only(top: ZrState.space20),
                      decoration: const BoxDecoration(
                        color: ZrState.primaryBlue,
                        borderRadius: BorderRadius.all(Radius.circular(ZrState.radius20)),
                      ),
                      child: Text(
                        LocaleKeys.common_use.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),

              ///新手版布局
              Column(
                children: [
                  SizedBox(
                    width: ZrState.guideCardImageSize,
                    height: ZrState.guideCardImageSize,
                    child: Stack(children: [
                      const ImageView(
                          ZrState.guideBeginnerImage),
                      SizedBox(
                        width: ZrState.guideCardImageSize,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10.w,
                            ),
                            Text(
                              LocaleKeys.common_xinshou.tr,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: ZrState.textColorPrimary),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Text(
                              LocaleKeys.common_yemianjianjie.tr,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ZrState.textColorSecondary),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            // ImageView(),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      ///通知HomeController,更新主列表UI
                      TyHomeController.to.homeState.isProfess = false;
                      TyHomeController.to.update();
                      Navigator.pop(context);
                      callback();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.w),
                      margin: EdgeInsets.only(top: ZrState.space20),
                      decoration: const BoxDecoration(
                          color: ZrState.primaryBlue,
                          borderRadius: BorderRadius.all(Radius.circular(ZrState.radius20))),
                      child: Text(
                        LocaleKeys.common_use.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
