class ArticleSummary {
  String id;
  String contentId;
  String title;
  DateTime createdDate;
  DateTime? editedDate;
  bool isActive;
  String author;
  List<String> tags;
  String? imageURL;
  String summary;

  ArticleSummary({
    required this.id,
    required this.contentId,
    required this.title,
    required this.createdDate,
    this.editedDate,
    required this.isActive,
    required this.author,
    required this.tags,
    this.imageURL,
    required this.summary,
  });

  factory ArticleSummary.fromJson(Map<String, dynamic> json) {
    return ArticleSummary(
      id: json['id'],
      contentId: json['contentId'],
      title: json['title'],
      createdDate: DateTime.parse(json['created_date']),
      editedDate: json['edited_date'] != null
          ? DateTime.parse(json['edited_date'])
          : null,
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
      'contentId': contentId,
      'title': title,
      'created_date': createdDate.toIso8601String(),
      'edited_date': editedDate?.toIso8601String(),
      'is_active': isActive,
      'author': author,
      'tags': tags,
      'image_url': imageURL,
      'summary': summary,
    };
  }
}


/*
DatabaseReference ref = FirebaseDatabase.instance.reference();
DataSnapshot snapshot = await ref.child('users').child('1').once();
User user = User.fromJson(snapshot.value);
*/