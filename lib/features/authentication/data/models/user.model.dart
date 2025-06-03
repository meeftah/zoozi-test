import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user.model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(User user) {
    return UserModel(
      accessToken: user.accessToken,
    );
  }
}