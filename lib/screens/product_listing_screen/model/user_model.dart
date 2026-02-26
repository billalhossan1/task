class UserModel {
  final int id;
  final String email;
  final String username;
  final String phone;
  final UserName name;
  final UserAddress address;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as int,
    email: json['email'] as String,
    username: json['username'] as String,
    phone: json['phone'] as String,
    name: UserName.fromJson(json['name'] as Map<String, dynamic>),
    address: UserAddress.fromJson(json['address'] as Map<String, dynamic>),
  );

  String get fullName => '${name.firstname} ${name.lastname}';
}

class UserName {
  final String firstname;
  final String lastname;

  UserName({required this.firstname, required this.lastname});

  factory UserName.fromJson(Map<String, dynamic> json) => UserName(
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
  );
}

class UserAddress {
  final String city;
  final String street;
  final String zipcode;

  UserAddress({
    required this.city,
    required this.street,
    required this.zipcode,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
    city: json['city'] as String,
    street: json['street'] as String,
    zipcode: json['zipcode'] as String,
  );

  String get full => '$street, $city $zipcode';
}
