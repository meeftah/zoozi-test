import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/access.token.dart';

part 'token.model.g.dart';

@JsonSerializable()
class TokenModel extends AccessToken {
  @JsonKey(name: 'access_token')
  final String accessToken;

   const TokenModel({required this.accessToken}) : super(accessToken: accessToken);

  factory TokenModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$TokenModelToJson(this);

  factory TokenModel.fromEntity(AccessToken token) {
    return TokenModel(
      accessToken: token.accessToken,
    );
  }
}