import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class ForgetPassword implements Usecase<void, String> {
  const ForgetPassword(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call(String param) async {
    return await authRepository.forgetPassword(param);
  }
}
