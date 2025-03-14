import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangeUsername implements Usecase<void, String> {
  const ChangeUsername(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call(String param) async {
    return await authRepository.changeUsername(param);
  }
}
