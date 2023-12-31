class ExercisesModel {
  int? id;
  String? title;
  String? file;
  bool? finished;

  ExercisesModel({this.id, this.title, this.file, this.finished});

  ExercisesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    file = json['file'];
    finished = json['finished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['file'] = this.file;
    data['finished'] = this.finished;
    return data;
  }
}
