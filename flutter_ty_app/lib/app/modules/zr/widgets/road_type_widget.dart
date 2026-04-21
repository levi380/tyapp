import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

///路纸布局（红色字部分 8连闲，6连庄。。。）
class RoadTypeWidget extends StatelessWidget {
  final List<String>? roadPaperTypeImg;
  final double height;

  RoadTypeWidget({super.key, this.roadPaperTypeImg, this.height = 17.0});

  @override
  Widget build(BuildContext context) {
    List<Widget> typeImg = [];

    ///根据返回数组长度，依次添加布局，如12拆分为【1,2】，对应1,2两个图片
    if (roadPaperTypeImg != null && roadPaperTypeImg!.isNotEmpty) {
      for (int i = 0; i < roadPaperTypeImg!.length; i++) {
        typeImg.add(ImageView(roadPaperTypeImg![i]));
      }
    }

    return Transform.scale(
      alignment: Alignment.centerRight,
      scale: 0.7,
      child: Container(
        alignment: Alignment.centerRight,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: typeImg,
        ),
      ),
    );
  }
}
