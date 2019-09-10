import 'package:geolocator/geolocator.dart';

class User {
  int id;
  String username;
  String email;
  String first_name;
  String last_name;
  int phone_number;
  String address;
  String city;
  String authToken;
  Position position;
  String password;

  
  User({this.id , this.username, this.email, this.first_name, this.last_name, this.phone_number, this.address, this.city,
       this.authToken, this.position, this.password});
  
  factory User.fromJson(Map<String,dynamic> json){
    print(json);
    print(json['username']);
    return User(id: json['id']  == null ? json['pk'] as int : json['id'] as int,
                username: json['username'] as String,
                email: json['email'] as String,
                first_name: json['first_name'] as String, 
                last_name: json['last_name'] as String, 
                phone_number: json['phone_number'] as int, 
                address: json['address'] as String, 
                city: json['city'].toString(),
                authToken: json['authToken'] as String
                );
                
  }

      @override
    String toString() {
        return '''{
                id: $id,
                username: $username,
                email: $email,
                first_name: $first_name,
                last_name: $last_name,
                phone_number: $phone_number,
                city: $city,
                authToken: $authToken
            }''';
    }

    Map<String, dynamic> toJSON() => <String, dynamic>{
                'id': id,
                'username': username,
                'email': email,
                'first_name': first_name,
                'last_name': last_name,
                'phone_number': phone_number,
                'city': city,
                'authToken': authToken
    };

}