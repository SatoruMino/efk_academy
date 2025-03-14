import 'package:efk_academy/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.id, required super.username});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(id: map['id'] ?? '', username: map['username'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
    };
  }
}
