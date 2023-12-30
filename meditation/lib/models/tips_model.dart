// ignore_for_file: public_member_api_docs, sort_constructors_first

class Tips {
  int? id;
  String? text;
  String? author;
  List? upvotes;
  List? downvotes;
  Tips({
    this.id,
    this.text,
    this.author,
    this.upvotes,
    this.downvotes,
  });
  Tips.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int?;
      text = json['text'] as String?;
      author = json['author'] as String;
      upvotes = json['upvotes'] as List?;
      downvotes = json['downvotes'] as List?;
    } catch (e) {
      print(e.toString());
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['text'] = text;
    json['author'] = author;
    json['upvotes'] = upvotes;
    json['downvotes'] = downvotes;
    return json;
  }
}
