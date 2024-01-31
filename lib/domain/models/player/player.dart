import 'package:json_annotation/json_annotation.dart';
part 'player.g.dart';

@JsonSerializable()
class PlayerModel {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'nickname')
  final String nickname;
  @JsonKey(name: 'idPlayerPosition')
  final int? idPlayerPosition;
  @JsonKey(name: 'position')
  final String? position;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'confirmPassword')
  final String? confirmPassword;

  PlayerModel({
    this.id,
    required this.email,
    required this.name,
    required this.idPlayerPosition,
    this.position,
    this.password,
    this.confirmPassword,
    required this.nickname,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}
