import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/repositories/auth_repository.dart';

class GetUser {
  const GetUser(this.authRepository);

  final AuthRepository authRepository;

  Stream<User> get call => authRepository.getUser;
}
