class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
  });
  

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phoneNo,
      'password': password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      fullName: data['fullName'],
      email: data['email'],
      phoneNo: data['phone'],
      password: data['password'],
    );
  }
}




