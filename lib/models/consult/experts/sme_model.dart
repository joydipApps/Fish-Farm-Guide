import 'package:flutter_riverpod/flutter_riverpod.dart';

class SMEModel {
  final String expertId;
  final String expertName;
  final String expertPosition;
  final String expertSubject;
  final String expertDetails;
  final String expertYears;
  final String expertPhone;
  final String expertEmail;
  final String expertAddress;
  final String expertPicture;

  SMEModel({
    required this.expertId,
    required this.expertName,
    required this.expertPosition,
    required this.expertSubject,
    required this.expertDetails,
    required this.expertYears,
    required this.expertPhone,
    required this.expertEmail,
    required this.expertAddress,
    required this.expertPicture,
  });

  factory SMEModel.fromJson(Map<String, dynamic> json) {
    return SMEModel(
      expertId: json['expert_id'] ?? "",
      expertName: json['expert_name'] ?? "",
      expertPosition: json['expert_professionalism'] ?? "",
      expertSubject: json['expert_subject'] ?? "",
      expertDetails: json['expert_details'] ?? "",
      expertYears: json['expert_year'] ?? "",
      expertPhone: json['expert_phno'] ?? "",
      expertEmail: json['expert_email'] ?? "",
      expertAddress: json['expert_address'] ?? "",
      expertPicture: json['expert_picture'] ?? "",
    );
  }
}

class SMEModelList {
  final List<SMEModel> smeList;

  SMEModelList({required this.smeList});
}

// Modify SMEModelListNotifier to provide a List<SMEModel> state directly
class SMEModelListNotifier extends StateNotifier<List<SMEModel>> {
  SMEModelListNotifier() : super(<SMEModel>[]);

  void updateSMEModelList(List<SMEModel> newList) {
    state = newList;
  }

  // Add a single record
  void addSMEModel(SMEModel newSME) {
    state = [...state, newSME];
  }

  // Add multiple records
  void addSMEModels(List<SMEModel> newLists) {
    state = [...state, ...newLists];
  }

  // Remove a record
  void removeSMEModel(SMEModel smeToRemove) {
    state = state.where((sme) => sme != smeToRemove).toList();
  }
}
