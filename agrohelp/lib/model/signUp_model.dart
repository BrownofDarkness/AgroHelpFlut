class SingUpModel{
  String username;
  String email;
  String password;
  String type;

  SingUpModel({
    required this.username,
    required this.type,
    required this.email,
    required this.password
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["username"] = this.username;
    data["email"] = this.email;
    data["password"] = this.password;
    data["type"] = this.type;
    return data;
  }
}