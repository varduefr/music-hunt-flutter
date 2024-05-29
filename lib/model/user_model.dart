// class AddUserModel {
//
//   String? name;
//   String? id;
//   String? email;
//   String? password;
//
//   String? address;
//
//   String? postalCode;
//   String? city;
//   String? country;
//   // String? trainPlace;
//   // String? diet;
//
//
//
//
//
//   AddUserModel({
//     this.email,
//     this.name,
//     this.password,
//     this.address,
//     this.postalCode,
//     this.city,
//     this.country,
//     this.id,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       "email": email,
//       "name": name,
//       "password": password,
//       "address": address,
//       "postalCode": postalCode,
//       "city": city,
//       "country": country,
//
//       "id": id,
//
//     };
//   }
//
//   factory AddUserModel.fromJson(Map<String, dynamic> json) {
//     return AddUserModel(
//       email: json["email"] ?? "",
//       name: json["name"] ?? "",
//       address: json["address"] ?? "",
//       city: json["city"] ?? "",
//       postalCode: json["postalCode"] ?? "",
//       password: json["password"] ?? "",
//       country: json["country"] ?? "",
//
//       id: json["id"] ??"",
//
//     );
//   }
// }

class AddUserModel {
  String? name;
  String? id;
  String? email;
  String? password;
  String? address;
  String? postalCode;
  String? city;
  String? country;
  double? latitude;
  double? longitude;

  AddUserModel({
    this.email,
    this.name,
    this.password,
    this.address,
    this.postalCode,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "password": password,
      "address": address,
      "postalCode": postalCode,
      "city": city,
      "country": country,
      "latitude": latitude,
      "longitude": longitude,
      "id": id,
    };
  }

  factory AddUserModel.fromJson(Map<String, dynamic> json) {
    return AddUserModel(
      email: json["email"] ?? "",
      name: json["name"] ?? "",
      address: json["address"] ?? "",
      city: json["city"] ?? "",
      postalCode: json["postalCode"] ?? "",
      password: json["password"] ?? "",
      country: json["country"] ?? "",
      latitude: json["latitude"] != null ? json["latitude"].toDouble() : null,
      longitude: json["longitude"] != null ? json["longitude"].toDouble() : null,
      id: json["id"] ?? "",
    );
  }
}
