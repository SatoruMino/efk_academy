import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/poster.dart';
import 'package:efk_academy/domain/repositories/poster_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetPoster implements Usecase<List<Poster>, NoParam> {
  final PosterRepository posterRepository;

  const GetPoster(this.posterRepository);

  @override
  Future<Either<Failure, List<Poster>>> call(NoParam param) async {
    return await posterRepository.getPosters();
  }
}
