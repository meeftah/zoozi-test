import 'package:json_annotation/json_annotation.dart';
import 'package:zoozitest/features/authentication/domain/entities/user.dart';

part 'user.model.g.dart';

@JsonSerializable()
class UserModel extends User {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

   UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
          id: id ?? 0,
          email: email ?? '',
          name: name ?? '',
          createdAt: createdAt ?? '',
          updatedAt: updatedAt ?? '',
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}