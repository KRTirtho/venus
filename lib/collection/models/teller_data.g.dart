// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teller_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TellerUser _$TellerUserFromJson(Map<String, dynamic> json) => TellerUser(
      id: json['id'] as String,
    );

Map<String, dynamic> _$TellerUserToJson(TellerUser instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

TellerInstitution _$TellerInstitutionFromJson(Map<String, dynamic> json) =>
    TellerInstitution(
      name: json['name'] as String,
    );

Map<String, dynamic> _$TellerInstitutionToJson(TellerInstitution instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

TellerEnrollment _$TellerEnrollmentFromJson(Map<String, dynamic> json) =>
    TellerEnrollment(
      id: json['id'] as String,
      institution: TellerInstitution.fromJson(
          json['institution'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TellerEnrollmentToJson(TellerEnrollment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'institution': instance.institution,
    };

TellerData _$TellerDataFromJson(Map<String, dynamic> json) => TellerData(
      accessToken: json['accessToken'] as String,
      signatures: (json['signatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      user: TellerUser.fromJson(json['user'] as Map<String, dynamic>),
      enrollment:
          TellerEnrollment.fromJson(json['enrollment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TellerDataToJson(TellerData instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'signatures': instance.signatures,
      'user': instance.user,
      'enrollment': instance.enrollment,
    };
