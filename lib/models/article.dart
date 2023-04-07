class Article {
  int id;
  String title;
  String? subtitle;
  DateTime createdDate;
  DateTime? editedDate;
  String content;
  bool isActive;
  String author;
  List<String> tags;
  String? imageURL;
  String summary;

  Article({
    required this.id,
    required this.title,
    this.subtitle,
    required this.createdDate,
    this.editedDate,
    required this.content,
    required this.isActive,
    required this.author,
    required this.tags,
    this.imageURL,
    required this.summary,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      createdDate: DateTime.parse(json['created_date']),
      editedDate: json['edited_date'] != null
          ? DateTime.parse(json['edited_date'])
          : null,
      content: json['content'],
      isActive: json['is_active'],
      author: json['author'],
      tags: List<String>.from(json['tags']),
      imageURL: json['image_url'],
      summary: json['summary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'created_date': createdDate.toIso8601String(),
      'edited_date': editedDate?.toIso8601String(),
      'content': content,
      'is_active': isActive,
      'author': author,
      'tags': tags,
      'image_url': imageURL,
      'summary': summary,
    };
  }
}
