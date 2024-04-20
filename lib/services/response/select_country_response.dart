import 'dart:convert';

class SelectCountryResponse {
  String? profileStatus;
  String? role;
  dynamic selectedCountry;
  List<Country>? countries;

  SelectCountryResponse({
    this.profileStatus,
    this.role,
    this.selectedCountry,
    this.countries,
  });

  SelectCountryResponse copyWith({
    String? profileStatus,
    String? role,
    dynamic selectedCountry,
    List<Country>? countries,
  }) =>
      SelectCountryResponse(
        profileStatus: profileStatus ?? this.profileStatus,
        role: role ?? this.role,
        selectedCountry: selectedCountry ?? this.selectedCountry,
        countries: countries ?? this.countries,
      );

  factory SelectCountryResponse.fromRawJson(String str) => SelectCountryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectCountryResponse.fromJson(Map<String, dynamic> json) => SelectCountryResponse(
    profileStatus: json["profile_status"],
    role: json["role"],
    selectedCountry: json["selected_country"],
    countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "profile_status": profileStatus,
    "role": role,
    "selected_country": selectedCountry,
    "countries": countries == null ? [] : List<dynamic>.from(countries!.map((x) => x.toJson())),
  };
}

class Country {
  int? id;
  String? name;
  String? flag;
  String? image;
  bool isSelected;

  Country({
    this.id,
    this.name,
    this.flag,
    this.image,
    required this.isSelected,
  });

  Country copyWith({
    int? id,
    String? name,
    String? flag,
    String? image,
    bool? isSelect,
  }) =>
      Country(
        id: id ?? this.id,
        name: name ?? this.name,
        flag: flag ?? this.flag,
        image: image ?? this.image,
        isSelected: isSelect ?? isSelected,
      );

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    flag: json["flag"],
    image: json["image"],
    isSelected: json["isSelected"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "flag": flag,
    "image": image,
    "isSelected": isSelected,
  };
}
