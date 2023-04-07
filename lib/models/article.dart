class Article {
  String title;
  String subtitle;
  DateTime createdDate;
  DateTime editedDate;
  String content;
  bool isActive;

  Article({
    required this.title,
    required this.subtitle,
    required this.createdDate,
    required this.editedDate,
    required this.content,
    required this.isActive,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      subtitle: json['subtitle'],
      createdDate: DateTime.parse(json['created_date']),
      editedDate: DateTime.parse(json['edited_date']),
      content: json['content'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'created_date': createdDate.toIso8601String(),
      'edited_date': editedDate.toIso8601String(),
      'content': content,
      'is_active': isActive,
    };
  }
}
