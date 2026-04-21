//
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘面】】】
    【【【 AUTO_PARAGRAPH_TITLE 数据页面-历史分析 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -   序列化bean对象
    】】】
 *
 */
class SeriesBean {
  // 定义序列名称属性，类型为可空String
  // 用于标识图表中的序列名称（如："主队"、"客队"等）
  String? name;
  // 定义数据列表属性，类型为可空List<double?>
  // 用于存储序列的数据点（如：比分、赔率等数值数组）
  List<double?>? data;
  // 定义柱状图宽度属性，类型为可空String
  // 用于设置柱状图的宽度（如："60%"等）
  String? barWidth;
  // 定义图表类型属性，类型为可空String
  // 用于指定图表类型（如："line"（折线图）、"bar"（柱状图）等）
  String? type;
  // 定义堆叠属性，类型为可空String
  // 用于指定堆叠图表的堆叠组名称
  String? stack;
  // 定义项样式属性，类型为可空ItemStyle
  // 用于设置图表项的样式（如：颜色、圆角等）
  ItemStyle? itemStyle;
  // 定义连接空值属性，类型为可空bool
  // 用于指定是否连接空值点（在折线图中，如果数据点为空，是否用线连接）
  bool? connectNulls;
  
  // 构造函数，使用可选命名参数
  // this.name: 序列名称，可选参数
  // this.connectNulls: 连接空值标志，可选参数
  // this.data: 数据列表，可选参数
  // this.barWidth: 柱状图宽度，可选参数
  // this.type: 图表类型，可选参数
  // this.stack: 堆叠属性，可选参数
  // this.itemStyle: 项样式，可选参数
  SeriesBean({this.name,this.connectNulls, this.data, this.barWidth, this.type,this.stack, this.itemStyle});

  /**
   * 从JSON数据反序列化
   * 
   * 功能说明：
   * - 将JSON格式的数据转换为SeriesBean对象
   * - 处理嵌套的ItemStyle对象
   * 
   * 参数：
   * - json: JSON数据映射，类型为Map<String, dynamic>
   */
  SeriesBean.fromJson(Map<String, dynamic> json) {
    // 从JSON中获取name字段，赋值给name属性
    name = json['name'];
    // 从JSON中获取connectNulls字段，赋值给connectNulls属性
    connectNulls = json['connectNulls'];
    // 从JSON中获取data字段，转换为List<double>类型
    // 如果data为null，则使用空列表<double>[]
    data = (json['data']??<double>[]).cast<double>();
    // 从JSON中获取barWidth字段，赋值给barWidth属性
    barWidth = json['barWidth'];
    // 从JSON中获取type字段，赋值给type属性
    type = json['type'];
    // 从JSON中获取stack字段，赋值给stack属性
    stack = json['stack'];
    // 从JSON中获取itemStyle字段，如果不为null则创建ItemStyle对象
    itemStyle = json['itemStyle'] != null
        ? new ItemStyle.fromJson(json['itemStyle'])
        : null;
  }

  /**
   * 序列化为JSON数据
   * 
   * 功能说明：
   * - 将SeriesBean对象转换为JSON格式的数据
   * - 处理嵌套的ItemStyle对象
   * 
   * 返回：
   * - Map<String, dynamic>: 返回JSON格式的数据映射
   */
  Map<String, dynamic> toJson() {
    // 创建JSON数据映射
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // 将name属性添加到JSON中
    data['name'] = this.name;
    // 将data属性添加到JSON中
    data['data'] = this.data;
    // 将barWidth属性添加到JSON中
    data['barWidth'] = this.barWidth;
    // 将type属性添加到JSON中
    data['type'] = this.type;
    // 将stack属性添加到JSON中
    data['stack'] = this.stack;
    // 将connectNulls属性添加到JSON中
    data['connectNulls'] = this.connectNulls;
    // 如果itemStyle不为null，则将其序列化为JSON并添加到data中
    if (this.itemStyle != null) {
      data['itemStyle'] = this.itemStyle!.toJson();
    }
    // 返回JSON数据映射
    return data;
  }
}

/**
 * 项样式类
 * 
 * 功能说明：
 * - 用于存储图表项的样式信息
 * - 包含正常状态的样式配置
 * 
 * 使用场景：
 * - 在SeriesBean中作为itemStyle属性的类型
 */
class ItemStyle {
  // 定义正常状态样式属性，类型为可空Normal
  // 用于存储正常状态下的样式配置（如：颜色、圆角等）
  Normal? normal;

  // 构造函数，使用可选命名参数
  // this.normal: 正常状态样式，可选参数
  ItemStyle({this.normal});

  /**
   * 从JSON数据反序列化
   * 
   * 功能说明：
   * - 将JSON格式的数据转换为ItemStyle对象
   * - 处理嵌套的Normal对象
   * 
   * 参数：
   * - json: JSON数据映射，类型为Map<String, dynamic>
   */
  ItemStyle.fromJson(Map<String, dynamic> json) {
    // 从JSON中获取normal字段，如果不为null则创建Normal对象
    normal =
    json['normal'] != null ? new Normal.fromJson(json['normal']) : null;
  }

  /**
   * 序列化为JSON数据
   * 
   * 功能说明：
   * - 将ItemStyle对象转换为JSON格式的数据
   * - 处理嵌套的Normal对象
   * 
   * 返回：
   * - Map<String, dynamic>: 返回JSON格式的数据映射
   */
  Map<String, dynamic> toJson() {
    // 创建JSON数据映射
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // 如果normal不为null，则将其序列化为JSON并添加到data中
    if (this.normal != null) {
      data['normal'] = this.normal!.toJson();
    }
    // 返回JSON数据映射
    return data;
  }
}

/**
 * 正常状态样式类
 * 
 * 功能说明：
 * - 用于存储正常状态下的样式配置
 * - 包含柱状图圆角和颜色配置
 * 
 * 使用场景：
 * - 在ItemStyle中作为normal属性的类型
 */
class Normal {
  // 定义柱状图圆角属性，类型为可空int
  // 用于设置柱状图的圆角半径（像素值）
  int? barBorderRadius;
  // 定义颜色属性，类型为可空SeriesColor
  // 用于设置图表的颜色配置（如：渐变色等）
  SeriesColor? color;

  // 构造函数，使用可选命名参数
  // this.barBorderRadius: 柱状图圆角，可选参数
  // this.color: 颜色配置，可选参数
  Normal({this.barBorderRadius, this.color});

  /**
   * 从JSON数据反序列化
   * 
   * 功能说明：
   * - 将JSON格式的数据转换为Normal对象
   * - 处理嵌套的SeriesColor对象
   * 
   * 参数：
   * - json: JSON数据映射，类型为Map<String, dynamic>
   */
  Normal.fromJson(Map<String, dynamic> json) {
    // 从JSON中获取barBorderRadius字段，赋值给barBorderRadius属性
    barBorderRadius = json['barBorderRadius'];
    // 从JSON中获取color字段，如果不为null则创建SeriesColor对象
    color = json['color'] != null ? new SeriesColor.fromJson(json['color']) : null;
  }

  /**
   * 序列化为JSON数据
   * 
   * 功能说明：
   * - 将Normal对象转换为JSON格式的数据
   * - 处理嵌套的SeriesColor对象
   * 
   * 返回：
   * - Map<String, dynamic>: 返回JSON格式的数据映射
   */
  Map<String, dynamic> toJson() {
    // 创建JSON数据映射
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // 将barBorderRadius属性添加到JSON中
    data['barBorderRadius'] = this.barBorderRadius;
    // 如果color不为null，则将其序列化为JSON并添加到data中
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    // 返回JSON数据映射
    return data;
  }
}

/**
 * 序列颜色类
 * 
 * 功能说明：
 * - 用于存储图表的颜色配置
 * - 支持渐变色配置（线性渐变）
 * - 包含渐变类型、坐标和颜色停止点
 * 
 * 使用场景：
 * - 在Normal中作为color属性的类型
 */
class SeriesColor {
  // 定义渐变类型属性，类型为可空String
  // 用于指定渐变类型（如："linear"（线性渐变）等）
  String? type;
  // 定义起始点x坐标属性，类型为可空int
  // 用于设置线性渐变的起始点x坐标（0-100，表示百分比）
  int? x;
  // 定义起始点y坐标属性，类型为可空int
  // 用于设置线性渐变的起始点y坐标（0-100，表示百分比）
  int? y;
  // 定义结束点x坐标属性，类型为可空int
  // 用于设置线性渐变的结束点x坐标（0-100，表示百分比）
  int? x2;
  // 定义结束点y坐标属性，类型为可空int
  // 用于设置线性渐变的结束点y坐标（0-100，表示百分比）
  int? y2;
  // 定义颜色停止点列表属性，类型为可空List<SeriesColorStops>
  // 用于设置渐变的颜色停止点（如：0%处为红色，100%处为蓝色）
  List<SeriesColorStops>? colorStops;

  // 构造函数，使用可选命名参数
  // this.type: 渐变类型，可选参数
  // this.x: 起始点x坐标，可选参数
  // this.y: 起始点y坐标，可选参数
  // this.x2: 结束点x坐标，可选参数
  // this.y2: 结束点y坐标，可选参数
  // this.colorStops: 颜色停止点列表，可选参数
  SeriesColor({this.type, this.x, this.y, this.x2, this.y2, this.colorStops});

  /**
   * 从JSON数据反序列化
   * 
   * 功能说明：
   * - 将JSON格式的数据转换为SeriesColor对象
   * - 处理嵌套的SeriesColorStops对象列表
   * 
   * 参数：
   * - json: JSON数据映射，类型为Map<String, dynamic>
   */
  SeriesColor.fromJson(Map<String, dynamic> json) {
    // 从JSON中获取type字段，赋值给type属性
    type = json['type'];
    // 从JSON中获取x字段，赋值给x属性
    x = json['x'];
    // 从JSON中获取y字段，赋值给y属性
    y = json['y'];
    // 从JSON中获取x2字段，赋值给x2属性
    x2 = json['x2'];
    // 从JSON中获取y2字段，赋值给y2属性
    y2 = json['y2'];
    // 从JSON中获取colorStops字段，如果不为null则转换为SeriesColorStops对象列表
    if (json['colorStops'] != null) {
      // 初始化colorStops列表
      colorStops = <SeriesColorStops>[];
      // 遍历JSON中的colorStops数组，将每个元素转换为SeriesColorStops对象并添加到列表中
      json['colorStops'].forEach((v) {
        colorStops!.add(new SeriesColorStops.fromJson(v));
      });
    }
  }

  /**
   * 序列化为JSON数据
   * 
   * 功能说明：
   * - 将SeriesColor对象转换为JSON格式的数据
   * - 处理嵌套的SeriesColorStops对象列表
   * 
   * 返回：
   * - Map<String, dynamic>: 返回JSON格式的数据映射
   */
  Map<String, dynamic> toJson() {
    // 创建JSON数据映射
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // 将type属性添加到JSON中
    data['type'] = this.type;
    // 将x属性添加到JSON中
    data['x'] = this.x;
    // 将y属性添加到JSON中
    data['y'] = this.y;
    // 将x2属性添加到JSON中
    data['x2'] = this.x2;
    // 将y2属性添加到JSON中
    data['y2'] = this.y2;
    // 如果colorStops不为null，则将其序列化为JSON数组并添加到data中
    if (this.colorStops != null) {
      data['colorStops'] = this.colorStops!.map((v) => v.toJson()).toList();
    }
    // 返回JSON数据映射
    return data;
  }
}

/**
 * 颜色停止点类
 * 
 * 功能说明：
 * - 用于存储渐变的颜色停止点信息
 * - 包含偏移量和颜色值
 * 
 * 使用场景：
 * - 在SeriesColor中作为colorStops列表的元素类型
 */
class SeriesColorStops {
  // 定义偏移量属性，类型为可空int
  // 用于设置颜色停止点的位置（0-100，表示百分比）
  int? offset;
  // 定义颜色值属性，类型为可空String
  // 用于设置该位置的颜色值（如："#FF0000"（红色）等）
  String? color;

  // 构造函数，使用可选命名参数
  // this.offset: 偏移量，可选参数
  // this.color: 颜色值，可选参数
  SeriesColorStops({this.offset, this.color});

  /**
   * 从JSON数据反序列化
   * 
   * 功能说明：
   * - 将JSON格式的数据转换为SeriesColorStops对象
   * 
   * 参数：
   * - json: JSON数据映射，类型为Map<String, dynamic>
   */
  SeriesColorStops.fromJson(Map<String, dynamic> json) {
    // 从JSON中获取offset字段，赋值给offset属性
    offset = json['offset'];
    // 从JSON中获取color字段，赋值给color属性
    color = json['color'];
  }

  /**
   * 序列化为JSON数据
   * 
   * 功能说明：
   * - 将SeriesColorStops对象转换为JSON格式的数据
   * 
   * 返回：
   * - Map<String, dynamic>: 返回JSON格式的数据映射
   */
  Map<String, dynamic> toJson() {
    // 创建JSON数据映射
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // 将offset属性添加到JSON中
    data['offset'] = this.offset;
    // 将color属性添加到JSON中
    data['color'] = this.color;
    // 返回JSON数据映射
    return data;
  }
}
