class SessionModel {
  int? id;
  String? title;
  String? file;

  SessionModel({
    this.id,
    this.title,
    this.file,
  });

  SessionModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int?;
      title = json['title'] as String?;
      file = json['file'];
    } catch (e) {
      print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['file'] = this.file;

    return data;
  }
}
