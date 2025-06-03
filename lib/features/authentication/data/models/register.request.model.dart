import 'package:json_annotation/json_annotation.dart';

part 'register.request.model.g.dart';

@JsonSerializable()
class RegisterRequestModel {
  final String email;
  final String password;
  final String? name;

  const RegisterRequestModel({
    required this.email,
    required this.password,
    this.name,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => 
      _$RegisterRequestModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}