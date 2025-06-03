import 'package:json_annotation/json_annotation.dart';

part 'login.request.model.g.dart';

@JsonSerializable()
class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => 
      _$LoginRequestModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}