class Note {
  final String? id;
  final String userId;
  final String title;
  final String content;
  final DateTime createdAt;

  Note(
      {this.id,
      required this.userId,
      required this.title,
      required this.content,
      required this.createdAt});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'].toString(),
      userId: map['user_id'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.parse(map['inserted_at']),
    );
  }
}
