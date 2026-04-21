import 'package:flutter_ty_app/app/modules/result/widgets/results_early_redemption_details_child_view.dart';
import 'package:flutter_ty_app/app/modules/result/widgets/results_extend_view.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../login/login_head_import.dart';
import '../../unsettled_bets/widgets/dividing_line_view.dart';
import '../../unsettled_bets/widgets/rule_statement_view.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-998323de-6c52-4771-a2e1-96f8fe57bb0f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果体育注单-注单部分提前兑Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能展示提前兑现的相关信息，包括分隔线和详细数据列表。
    - `EarlyRedemptionDetailsView`：接收两个参数：
    - `data`：类型为 `GetH5OrderListDataRecordxData`，用于存储提前兑现的详细数据。
    - `index`：整数类型，表示当前视图的索引。
    - 使用 `Obx` 进行响应式更新，确保在数据变化时自动重建视图。
    - 返回一个包含多个子组件的列布局：
    - **条件渲染**：如果 `preSettleExpand` 为 `true` 且 `data.data` 不为空，展示提前兑现的详情列表。
    - 包含分隔线和动态生成的 `EarlyRedemptionDetailsChildView` 列表。
    - 另外添加一个分隔线。
    - 最后展示 `ExtendView` 组件，提供折叠功能。
    】】】
 *
 */

class ResultsEarlyRedemptionDetailsView extends StatelessWidget {
  const ResultsEarlyRedemptionDetailsView({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final GetH5OrderListDataRecordxData data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            ///提前兑现说明
            const RuleStatementView(),

            ///分割线
            const DividingLineView(),

            ///提前兑现详情数据
            if (data.preSettleExpand.value && data.data.isNotEmpty)
              Column(
                children: [
                  ///提前兑现列表详情数据
                  ...List<ResultsEarlyRedemptionDetailsChildView>.generate(
                    data.data.length,
                    (index) {
                      return ResultsEarlyRedemptionDetailsChildView(
                        data: data.data[index],
                        index: index,
                      );
                    },
                  ).toList(),
                ],
              ),

            ///提前兑现折叠
            ResultsExtendView(
              index: index,
              preSettleExpand: data.preSettleExpand.value,
            ),
          ],
        ),
      ),
    );
  }
}
