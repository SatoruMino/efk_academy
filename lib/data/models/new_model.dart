import 'package:efk_academy/domain/entities/new.dart';

class NewModel extends New {
  NewModel({
    required super.name,
    required super.message,
    required super.createdAt,
  });

  factory NewModel.fromJson(Map<String, dynamic> map) {
    return NewModel(
      name: map['name'] ?? '',
      message: map['message'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
