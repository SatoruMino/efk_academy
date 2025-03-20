import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.username,
  });

  final String id;
  final String email;
  final String username;

  @override
  List<Object?> get props => [id, email, username];

  static const User empty = User(
    id: '',
    email: '',
    username: '',
  );
}
