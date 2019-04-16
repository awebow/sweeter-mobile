class Sweet {

  int no;
  int author;
  String content;
  DateTime sweetAt;
  DateTime deleteAt;

  Sweet.fromJson(Map<String, dynamic> json)
    : no = json['no'], author = json['author'], content = json['content'],
    sweetAt = DateTime.parse(json['sweet_at']),
    deleteAt = (json['delete_at'] == null ? null : DateTime.parse(json['delete_at']));

}