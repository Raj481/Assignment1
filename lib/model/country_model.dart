import 'dart:convert';

class CountryModel {
  int? id;
  String? name;
  String? code;
  String? telCode;
  dynamic timezone;
  String? flag;
  DateTime? createdAt;
  DateTime? updatedAt;

  CountryModel({
    this.id,
    this.name,
    this.code,
    this.telCode,
    this.timezone,
    this.flag,
    this.createdAt,
    this.updatedAt,
  });

  CountryModel copyWith({
    int? id,
    String? name,
    String? code,
    String? telCode,
    dynamic timezone,
    String? flag,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CountryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        telCode: telCode ?? this.telCode,
        timezone: timezone ?? this.timezone,
        flag: flag ?? this.flag,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CountryModel.fromRawJson(String str) => CountryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    telCode: json["tel_code"],
    timezone: json["timezone"],
    flag: json["flag"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "tel_code": telCode,
    "timezone": timezone,
    "flag": flag,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
