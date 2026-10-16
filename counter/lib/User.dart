
class User{
  final String name;
  final String avatar;
  final String Aa;
  final String id;

    User({
    required this.name,
    required this.avatar,
    required this.Aa,
    required this.id,
  });


  factory User.fromJson(Map<String,dynamic> json){
    return User(
      name: json['name'] ?? '',
      avatar : json['avatar'] ?? '',
      Aa : json['Aa'] ?? '',
      id : json['id'] ?? ''
    );
  }

}