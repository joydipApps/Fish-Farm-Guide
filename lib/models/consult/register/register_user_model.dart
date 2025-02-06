import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterUserModel {
  String userPhNo;
  String userName;
  String userType;
  String locationName;
  String pinCode;
  String postOffice;
  String district;
  String state;
  String country;

  RegisterUserModel({
    required this.userPhNo,
    required this.userName,
    required this.userType,
    required this.locationName,
    required this.pinCode,
    required this.postOffice,
    required this.district,
    required this.state,
    required this.country,
  });

  factory RegisterUserModel.fromJson(Map<String, dynamic> jsonData) {
    return RegisterUserModel(
      userPhNo: jsonData["user_phno"] ?? "",
      userName: jsonData["user_name"] ?? "",
      userType: jsonData["user_type"] ?? "",
      locationName: jsonData["location_name"] ?? "",
      pinCode: jsonData["pincode"] ?? "",
      postOffice: jsonData["block"] ?? "",
      district: jsonData["district"] ?? "",
      state: jsonData["state"] ?? "",
      country: jsonData["country"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user_phno"] = userPhNo;
    data["user_name"] = userName;
    data["user_type"] = userType;
    data["location_name"] = locationName;
    data["pincode"] = pinCode;
    data["block"] = postOffice;
    data["district"] = district;
    data["state"] = state;
    data["country"] = country;
    return data;
  }
}

class RegisterUserModelNotifier extends StateNotifier<RegisterUserModel?> {
  RegisterUserModelNotifier() : super(null);

  void updateUser(RegisterUserModel newUser) {
    state = newUser;
  }

  void addUser(RegisterUserModel newUser) {
    final updatedUser = RegisterUserModel(
      userPhNo: newUser.userPhNo,
      userName: newUser.userName,
      userType: newUser.userType,
      locationName: newUser.locationName,
      pinCode: newUser.pinCode,
      postOffice: newUser.postOffice,
      district: newUser.district,
      state: newUser.state,
      country: newUser.country,
    );
    state = updatedUser;
  }
}
