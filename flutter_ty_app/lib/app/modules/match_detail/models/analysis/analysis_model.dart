import '../../../login/login_head_import.dart';

class LineColorBean {
  List<Color> colors = [
    AppColor.text00B42A,
    AppColor.textFEAE2B,
    AppColor.textF53F3F,
  ];
  Color? color;
  int expand = 1;
  String number = "0";

  LineColorBean(this.expand);

  Color getColor(int index) {
    return colors[index];
  }
}

class GridColorBean {
  List<Color> colors = [Color(0xFFFFCC54), Color(0xFFFF8A2D)];
  Color? color;
  String name1;
  String name2;
  String name3;
  String? name4;

  GridColorBean(this.name1, this.name2, this.name3, this.colors, {this.name4});

  Color getColor(int index) {
    return colors[index];
  }
}

class TechnicalPBUIBean {
  String? leftValue;
  String? rightValue;
  String? centerName;

  TechnicalPBUIBean({this.leftValue, this.rightValue, this.centerName});
}

class GridListDataBean {
  List<Color> colors = [
    AppColor.text4CD238,
    AppColor.textD45FFF,
    AppColor.textFF7F47,
    AppColor.textFF5F8C,
    AppColor.text179CFF,
    AppColor.textFFC32F,
  ];
  Color? color;
  String name1;
  List<int> name2;
  String name3;
  String name4 = "";

  GridListDataBean(this.name1, this.name2, this.name3);

  Color getColor(int index) {
    return color ?? colors[index];
  }
}

class ListSaishiDurationDataBean {
  List<Color> colors = [
    AppColor.text4CD238,
    AppColor.textD45FFF,
    AppColor.textFF7F47,
    AppColor.textFF5F8C,
    AppColor.text179CFF,
    AppColor.textFFC32F,
  ];
  Color? color;
  String name1;
  String name2;
  String name3;
  String? mainTitle;
  String? contentTitle;

  String? img;
  IconData icons;

  ListSaishiDurationDataBean(this.name1, this.name2, this.name3, this.icons,
      {this.img, this.mainTitle, this.contentTitle});

  Color getColor(int index) {
    return colors[index];
  }
}

class ListSaishiHistoryChartBean {
  List<Color> colors = [
    AppColor.text4CD238,
    AppColor.textD45FFF,
    AppColor.textFF7F47,
    AppColor.textFF5F8C,
    AppColor.text179CFF,
    AppColor.textFFC32F,
  ];
  Color? color;
  String name1;
  String name2;
  String name3;

  List<ListSaishiHistoryChartItem> listSaishiHistoryChartItems;

  ListSaishiHistoryChartBean(
      this.name1, this.name2, this.name3, this.listSaishiHistoryChartItems);

  Color getColor(int index) {
    return colors[index];
  }
}

class ListSaishiHistoryChartItem {
  String date;
  String name2;
  String name3;
  String odds;

  ListSaishiHistoryChartItem(this.date, this.name2, this.name3, this.odds);
}
