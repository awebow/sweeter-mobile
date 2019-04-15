class User {
  
  int no;
  String id;
  String name;

  User.fromJson(Map<String, dynamic> json)
    : no = json['no'], id = json['id'], name = json['name'];

}