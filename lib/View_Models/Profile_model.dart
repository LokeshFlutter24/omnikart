class profilemodel {
  final int id;
  final String name;
  final String number;
  final String email;
  final String address;
  final String password;
  final String? profileImage;

  profilemodel({
    required this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.address,
    required this.password,
    this.profileImage,
  });

  factory profilemodel.fromJson(Map<String, dynamic> json) {
    return profilemodel(
      id: int.parse(json['id'].toString()),
      name: json['name'] ?? '',
      number: json['number'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      password: json['password'] ?? '',
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "number": number,
      "email": email,
      "address": address,
      "password": password,
      "profile_image": profileImage,
    };
  }
}
class ProfileResponseModel {

  final bool status;

  final List<profilemodel> data;

  ProfileResponseModel({
    required this.status,
    required this.data,
  });

  factory ProfileResponseModel.fromJson(
      Map<String, dynamic> json) {

    return ProfileResponseModel(

      status: json['status'],

      data: List<profilemodel>.from(

        json['data'].map(
              (x) => profilemodel.fromJson(x),
        ),
      ),
    );
  }
}