class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phoneNo;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phoneNo,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      fullName: data['fullName'],
      email: data['email'],
      phoneNo: data['phone'],
    );
  }
}
