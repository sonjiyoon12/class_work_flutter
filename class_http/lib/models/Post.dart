class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'],
        body = json['body'];

  @override
  String toString() {
    return 'Post{userId: $userId, id: $id, title: $title, body: $body}';
  }
}
