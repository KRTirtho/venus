import 'package:json_annotation/json_annotation.dart';

part 'teller_data.g.dart';

@JsonSerializable()
class TellerUser {
  final String id;
  const TellerUser({required this.id});

  factory TellerUser.fromJson(Map<String, dynamic> json) =>
      _$TellerUserFromJson(json);

  Map<String, dynamic> toJson() => _$TellerUserToJson(this);
}

@JsonSerializable()
class TellerInstitution {
  final String name;
  const TellerInstitution({required this.name});

  factory TellerInstitution.fromJson(Map<String, dynamic> json) =>
      _$TellerInstitutionFromJson(json);

  Map<String, dynamic> toJson() => _$TellerInstitutionToJson(this);
}

@JsonSerializable()
class TellerEnrollment {
  final String id;
  final TellerInstitution institution;

  const TellerEnrollment({
    required this.id,
    required this.institution,
  });

  factory TellerEnrollment.fromJson(Map<String, dynamic> json) =>
      _$TellerEnrollmentFromJson(json);

  Map<String, dynamic> toJson() => _$TellerEnrollmentToJson(this);
}

@JsonSerializable()
class TellerData {
  final String accessToken;
  final List<String> signatures;
  final TellerUser user;
  final TellerEnrollment enrollment;

  const TellerData({
    required this.accessToken,
    required this.signatures,
    required this.user,
    required this.enrollment,
  });

  factory TellerData.fromJson(Map<String, dynamic> json) =>
      _$TellerDataFromJson(json);

  Map<String, dynamic> toJson() => _$TellerDataToJson(this);
}
