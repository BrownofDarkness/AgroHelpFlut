class Culture {
  int? id;
  String? photo;
  String? name;
  String? category;
  String? description;

  Culture({this.id, this.photo, this.name, this.category, this.description});

  Culture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> culure = <String, dynamic>{};
    culure['id'] = id;
    culure['photo'] = photo;
    culure['name'] = name;
    culure['category'] = category;
    culure['description'] = description;
    return culure;
  }
}