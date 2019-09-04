class Profile{
  String id;
  String username;
  String first_name;
  String last_name;
  String email;
  String phone;
  String address;
  String city;


  Profile({this.id,this.username,this.first_name, this.last_name, this.email, this.phone, this.address, this.city});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(id:json['pk'].toString(),username: json['username'], first_name:json['first_name'], last_name: json['last_name'], email: json['email'], phone: json['phone_number'], address: json['address'],city: json['city'].toString());
  }
}
