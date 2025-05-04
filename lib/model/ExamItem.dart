class ExamItem {
  final String label;
  final String menuName;
  final String description;

  ExamItem({
    required this.label,
    required this.menuName,
    required this.description,
  });

  factory ExamItem.fromJson(Map<String, dynamic> json) {
    return ExamItem(
      label: json['Label'] ?? '',
      menuName: json['MENUNAME'] ?? '',
      description: json['Description'] ?? '',
    );
  }


}
Map<String, List<ExamItem>> groupBySection(List<ExamItem> items) {
  return {
    "Pre Exam": items.where((item) => item.menuName == "Pre Exam").toList(),
    "During Exam": items.where((item) => item.menuName == "During Exam").toList(),
    "Post Exam": items.where((item) => item.menuName == "Expenditure Bill").toList(), // Assuming
  };
}