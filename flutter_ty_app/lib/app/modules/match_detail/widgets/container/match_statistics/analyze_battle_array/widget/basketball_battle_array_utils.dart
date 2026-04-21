// 导入分析阵容人员实体，包含球员数据的模型定义
import '../../../../../../../services/models/res/analyze_array_person_entity.dart';

/**
 * 篮球阵容数据分组工具类
 * 
 * 功能说明：
 * - 用于将球员数据按照篮球场上的位置进行分组
 * - 根据球员数量，将球员分配到不同的行（第一行、第二行、第三行）
 * - 用于在阵容页面中显示球员位置
 * 
 * 使用场景：
 * - 在篮球阵容页面中显示球员位置分布
 * - 根据球员数量动态调整布局
 */
/// 篮球阵容数据分组工具类
/// 用于将球员数据按照篮球场上的位置进行分组
class BasketballBattleArrayUtils {
  /**
   * 将球员数据按照篮球场上的位置进行分组
   * 
   * 功能说明：
   * - 根据球员数量，将球员分配到不同的行
   * - 分配规则：
   *   - 1个球员：第一行
   *   - 2个球员：第一行1个，第二行1个
   *   - 3个球员：第一行1个，第二行2个
   *   - 4个球员：第一行1个，第二行2个，第三行1个
   *   - 5个球员：第一行1个，第二行2个，第三行2个
   * 
   * 参数：
   * - basketballData: 球员数据列表，类型为List<Up>?，包含所有球员信息
   * 
   * 返回：
   * - Map<String, List<Up>>: 返回三个列表的映射
   *   - 'first': 第一行的球员数据列表
   *   - 'second': 第二行的球员数据列表
   *   - 'three': 第三行的球员数据列表
   */
  /// 将球员数据按照篮球场上的位置进行分组
  /// 
  /// 根据球员数量，将球员分配到不同的行：
  /// - 1个球员：第一行
  /// - 2个球员：第一行1个，第二行1个
  /// - 3个球员：第一行1个，第二行2个
  /// - 4个球员：第一行1个，第二行2个，第三行1个
  /// - 5个球员：第一行1个，第二行2个，第三行2个
  /// 
  /// [basketballData] 球员数据列表
  /// 返回三个列表，分别代表第一行、第二行、第三行的球员数据
  static Map<String, List<Up>> groupPlayersByPosition(
      List<Up>? basketballData) {
    // 初始化第一行球员列表
    List<Up> first = [];
    // 初始化第二行球员列表
    List<Up> second = [];
    // 初始化第三行球员列表
    List<Up> three = [];

    // 获取球员数据列表的长度，如果为null则默认为0
    final dataLength = basketballData?.length ?? 0;

    // 判断：如果球员数量为1
    if (dataLength == 1) {
      // 1个球员：放在第一行
      // 将第一个球员添加到第一行，如果basketballData为null则添加空的Up对象
      first.add(basketballData?.first ?? Up());
    } 
    // 判断：如果球员数量为2
    else if (dataLength == 2) {
      // 2个球员：第一行1个，第二行1个
      // 将第一个球员添加到第一行
      first.add(basketballData?.first ?? Up());
      // 将第二个球员添加到第二行
      second.add(basketballData?[1] ?? Up());
    } 
    // 判断：如果球员数量为3
    else if (dataLength == 3) {
      // 3个球员：第一行1个，第二行2个
      // 将第一个球员添加到第一行
      first.add(basketballData?.first ?? Up());
      // 将第二个球员添加到第二行
      second.add(basketballData?[1] ?? Up());
      // 将第三个球员添加到第二行
      second.add(basketballData?[2] ?? Up());
    } 
    // 判断：如果球员数量为4
    else if (dataLength == 4) {
      // 4个球员：第一行1个，第二行2个，第三行1个
      // 将第一个球员添加到第一行
      first.add(basketballData?.first ?? Up());
      // 将第二个球员添加到第二行
      second.add(basketballData?[1] ?? Up());
      // 将第三个球员添加到第二行
      second.add(basketballData?[2] ?? Up());
      // 将最后一个球员添加到第三行
      three.add(basketballData?.last ?? Up());
    } 
    // 判断：如果球员数量为5
    else if (dataLength == 5) {
      // 5个球员：第一行1个，第二行2个，第三行2个
      // 将第一个球员添加到第一行
      first.add(basketballData?.first ?? Up());
      // 将第二个球员添加到第二行
      second.add(basketballData?[1] ?? Up());
      // 将第三个球员添加到第二行
      second.add(basketballData?[2] ?? Up());
      // 将第四个球员添加到第三行
      three.add(basketballData?[3] ?? Up());
      // 将第五个球员添加到第三行
      three.add(basketballData?[4] ?? Up());
    }

    // 返回包含三个列表的映射
    return {
      // 第一行球员列表
      'first': first,
      // 第二行球员列表
      'second': second,
      // 第三行球员列表
      'three': three,
    };
  }
}
