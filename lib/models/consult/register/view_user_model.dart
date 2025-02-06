import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewUserModel {
  int userId;
  String userName;
  String userPhNo;
  String userType;
  String locationName;
  String pinCode;
  String postOffice;
  String district;
  String state;
  String country;

  ViewUserModel({
    required this.userId,
    required this.userName,
    required this.userPhNo,
    required this.userType,
    required this.locationName,
    required this.pinCode,
    required this.postOffice,
    required this.district,
    required this.state,
    required this.country,
  });

  factory ViewUserModel.fromJson(Map<String, dynamic> jsonData) {
    return ViewUserModel(
      userId: int.tryParse(jsonData["user_id"].toString()) ?? 0,
      userName: jsonData["user_name"] ?? "",
      userPhNo: jsonData["user_phno"] ?? "",
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
    data["user_id"] = userId;
    data["user_name"] = userName;
    data["user_phno"] = userPhNo;
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

class ViewUserModelNotifier extends StateNotifier<ViewUserModel?> {
  ViewUserModelNotifier() : super(null);

  void updateUser(ViewUserModel newUser) {
    state = newUser;
  }

  void addUser(ViewUserModel newUser) {
    final updatedUser = ViewUserModel(
      userId: newUser.userId,
      userName: newUser.userName,
      userPhNo: newUser.userPhNo,
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
