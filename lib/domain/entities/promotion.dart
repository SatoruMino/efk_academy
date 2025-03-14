import 'package:equatable/equatable.dart';

class Promotion extends Equatable {
  const Promotion({required this.imageUrl});
  final String imageUrl;

  @override
  List<Object?> get props => [imageUrl];
}
