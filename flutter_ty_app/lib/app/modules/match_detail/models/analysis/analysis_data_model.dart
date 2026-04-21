

class AnalyzeNewMatchResultData {
  List<NewAnalyzeMatchResultItem> ring_statistics = [];
  List<NewAnalyzeMatchResultItem> card_corner_list = [];
  List<NewAnalyzeMatchResultItem> progress_graph = [];
}

class NewAnalyzeMatchResultItem {
  String score_type;
  String title;
  String icon;
  num home = 0;
  num away = 0;
  int proportion = 0;
  String? homeAlias;
  String? awayAlias;
  double? homeAliasValue;
  double? awayAliasValue;

  NewAnalyzeMatchResultItem(this.score_type, this.title, this.icon,
      {this.homeAlias,
      this.awayAlias,
      this.homeAliasValue,
      this.awayAliasValue});
}