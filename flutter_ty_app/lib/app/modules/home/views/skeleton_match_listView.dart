import 'package:flutter_ty_app/app/modules/home/views/skeleton_profession_item.dart';
import 'package:flutter_ty_app/app/modules/home/views/skeleton_new_item.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../states/home_state.dart';

/// 骨架屏
class SkeletonMatchListView extends StatelessWidget {
  const SkeletonMatchListView({super.key, required this.isNews});

  /// 新手版还是专业版.
  final bool isNews;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
          horizontal: HomeState.skeletonPaddingHorizontal),
      children: List.generate(
        HomeState.skeletonItemCount,
        (index) =>
            isNews ? const SkeletonNewItem() : const SkeletonProfessionItem(),
      ),
    );
  }
}
