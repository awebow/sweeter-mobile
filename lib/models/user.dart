class User {
  
  int no;
  String id;
  String name = "";
  String picture;

  User();

  User.fromJson(Map<String, dynamic> json)
    : no = json['no'], id = json['id'], name = json['name'], picture = json['picture'];

}