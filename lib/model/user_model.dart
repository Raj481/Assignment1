import 'dart:convert';

class UserModel {
  dynamic profileStatus;
  dynamic role;
  dynamic phone;
  dynamic phoneVerifiedAt;
  dynamic accessToken;
  dynamic tokenType;
  dynamic expiresIn;

  UserModel({
    this.profileStatus,
    this.role,
    this.phone,
    this.phoneVerifiedAt,
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  UserModel copyWith({
    String? profileStatus,
    String? role,
    String? phone,
    DateTime? phoneVerifiedAt,
    String? accessToken,
    String? tokenType,
    int? expiresIn,
  }) =>
      UserModel(
        profileStatus: profileStatus ?? this.profileStatus,
        role: role ?? this.role,
        phone: phone ?? this.phone,
        phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
      );

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    profileStatus: json["profile_status"],
    role: json["role"],
    phone: json["phone"],
    phoneVerifiedAt: json["phone_verified_at"] == null ? null : DateTime.parse(json["phone_verified_at"]),
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
  );

  Map<String, dynamic> toJson() => {
    "profile_status": profileStatus,
    "role": role,
    "phone": phone,
    "phone_verified_at": phoneVerifiedAt?.toIso8601String(),
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
  };
}
