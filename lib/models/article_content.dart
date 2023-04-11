class ArticleContent {
  String id;
  String title;
  String? subtitle;
  String content;

  ArticleContent({
    required this.id,
    required this.title,
    this.subtitle,
    required this.content,
  });

  factory ArticleContent.fromJson(Map<String, dynamic> json) {
    return ArticleContent(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'content': content,
    };
  }
}


/*
DatabaseReference ref = FirebaseDatabase.instance.reference();
DataSnapshot snapshot = await ref.child('users').child('1').once();
User user = User.fromJson(snapshot.value);
*/