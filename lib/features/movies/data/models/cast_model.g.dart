// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastModel _$CastModelFromJson(Map<String, dynamic> json) => CastModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  character: json['character'] as String,
  profilePath: json['profile_path'] as String?,
);

Map<String, dynamic> _$CastModelToJson(CastModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'character': instance.character,
  'profile_path': instance.profilePath,
};
