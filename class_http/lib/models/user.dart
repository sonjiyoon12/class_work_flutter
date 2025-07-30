class User {
  int? id;
  int? name;
  String? username;
  String? email;
  String? address;
  String? phone;
  String? website;
  String? company;

  User.fromJson(Map<String, dynamic> json) {}
}

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  String? geo;
}
