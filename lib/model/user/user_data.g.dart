// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      codeNumber: json['codeNumber'] as String,
      pin: json['pin'] as String,
      point: json['point'] as int,
      studentName: json['studentName'] as String,
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'codeNumber': instance.codeNumber,
      'pin': instance.pin,
      'point': instance.point,
      'studentName': instance.studentName,
    };
