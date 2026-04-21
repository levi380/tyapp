import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/views/living/controllers/living_view_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_sport_video_countdown_widget.dart';
import 'package:flutter_ty_app/app/widgets/common_app_bar.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

class VrLivingView extends GetView<VrLivingViewController> {
  const VrLivingView({Key? key}) : super(key: key);

  Text _whiteText(String text, {double? fontSize, FontWeight? fontWeight}) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget _overlayBox({
    required Widget child,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    EdgeInsetsGeometry? margin,
    Color color = Colors.black26,
  }) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      padding: padding,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.arrowBack(context, title: 'VrLiving'),
      body: ListView.separated(
        itemCount: 4,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Get.toNamed(Routes.vrCompetitionDetailPage);
            },
            child: Container(
              height: 190.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // TODO: 图片|视频展示
                  Builder(
                    builder: (context) {
                      if (index < 2) {
                        return VrSportVideoCountdownWidget(
                          progressColor:
                              index == 0 ? Colors.yellow : Colors.red,
                          no: '${index == 0 ? 11 : 12}',
                        );
                      }
                      if (index == 2) return _buildGoingWidget();
                      return _buildFinishedWidget();
                    },
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 12.w,
        ),
      ),
    );
  }

  Widget _buildFinishedWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _overlayBox(
          child: _whiteText(LocaleKeys.list_match_end.tr),
        ),
        _overlayBox(
          padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _whiteText('布莱顿海鸥'),
              _whiteText('2-1'),
              _whiteText('维拉人'),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _overlayBox(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _whiteText('第4轮'),
                  SizedBox(width: 4),
                  Text(
                    '01:26',
                    style: const TextStyle(
                      color: Colors.yellow,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.lock_clock),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGoingWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: _overlayBox(
        margin: const EdgeInsets.only(bottom: 4),
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 30),
            _whiteText('布莱顿海鸥'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: _whiteText('0-0'),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              color: Colors.red,
              child: _whiteText("12'"),
            ),
          ],
        ),
      ),
    );
  }
}
