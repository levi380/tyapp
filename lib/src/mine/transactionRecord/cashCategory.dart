class CashCategory {
  final String? cashType;
  final String? name;
  final List<CashCategory>? childs;

  CashCategory({
    this.cashType,
    this.name,
    this.childs,
  });

  factory CashCategory.fromJson(Map<String, dynamic> json) {
    return CashCategory(
      cashType:(json['cash_type']),
      name: json['name'],
      childs: (json['childs'] as List?)?.map((e) => CashCategory.fromJson(Map<String, dynamic>.from(e))).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cash_type': cashType,
      'name': name,
      'childs': childs?.map((e) => e.toJson()).toList(),
    };
  }

  
}
