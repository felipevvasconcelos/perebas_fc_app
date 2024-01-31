// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) => PlayerModel(
      id: int.tryParse(json['id']),
      email: json['email'] as String,
      name: json['name'] as String,
      idPlayerPosition: json['idPlayerPosition'] as int?,
      position: json['position'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'nickname': instance.nickname,
      'idPlayerPosition': instance.idPlayerPosition,
      'position': instance.position,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
