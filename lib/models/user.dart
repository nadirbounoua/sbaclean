



class User {
  String id;
  String username;
  String email;
  String first_name;
  String last_name;
  String phone_number;
  String address;
  String city;
  String authToken;


  
  User({this.id= '1' , this.username, this.email, this.first_name, this.last_name, this.phone_number, this.address, this.city,
       this.authToken = "485d5e2f79512be1280a9f82b8b95c3ecb934bf4"});
  
  factory User.fromJson(Map<String,dynamic> json){
    //print(json['username']);
    return User(id: json['pk'].toString(),username: json['username'] as String,email: json['email'] as String,first_name: json['first_name'] as String, last_name: json['last_name'] as String, phone_number: json['phone_number'] as String, address: json['address'] as String, city: json['city'].toString());
  }

}