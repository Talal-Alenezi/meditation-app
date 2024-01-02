class Music {
  int? id;
  String? title;
  String? file;

  Music({this.id, this.title, this.file});

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['file'] = this.file;
    return data;
  }
}
