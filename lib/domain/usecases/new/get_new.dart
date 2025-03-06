import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/new.dart';
import 'package:efk_academy/domain/repositories/new_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetNew implements Usecase<List<New>, NoParam> {
  final NewRepository newRepository;

  const GetNew(this.newRepository);

  @override
  Future<Either<Failure, List<New>>> call(NoParam param) async {
    return await newRepository.getNew();
  }
}
