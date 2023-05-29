
class User {
  int? id;
  String? username;
  String? email;
  String? type;

  User({this.id, this.username, this.email, this.type});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = new Map<String, dynamic>();
    user['id'] = this.id;
    user['username'] = this.username;
    user['email'] = this.email;
    user['type'] = this.type;
    return user;
  }
}