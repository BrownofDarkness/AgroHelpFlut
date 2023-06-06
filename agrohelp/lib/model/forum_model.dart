import 'dart:core';
class Forum {
  int? id;
  List<Comments>? comments;
  Author? author;
  String? content;
  DateTime? createdAt;

  Forum({this.id, this.comments, this.author, this.content, this.createdAt});

  Forum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    content = json['content'];
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    return data;
  }
}

class Comments {
  int? id;
  List<Replies>? replies;
  Author? author;
  String? content;
  DateTime? createdAt;
  int? forum;
  int? parent;

  Comments(
      {this.id,
      this.replies,
      this.author,
      this.content,
      this.createdAt,
      this.forum,
      this.parent});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    content = json['content'];
    createdAt = DateTime.parse(json['created_at']);
    forum = json['forum'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['forum'] = this.forum;
    data['parent'] = this.parent;
    return data;
  }
}

class Replies {
  int? id;
  List<Replies>? replies;
  Author? author;
  String? content;
  String? createdAt;
  int? forum;
  int? parent;

  Replies(
      {this.id,
      this.replies,
      this.author,
      this.content,
      this.createdAt,
      this.forum,
      this.parent});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    content = json['content'];
    createdAt = json['created_at'];
    forum = json['forum'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['forum'] = this.forum;
    data['parent'] = this.parent;
    return data;
  }
}

class Author {
  int? id;
  String? username;
  String? email;
  String? type;

  Author({this.id, this.username, this.email, this.type});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    type = json['type'];
  }

}