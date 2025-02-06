import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerRequestModel {
  final String requestId;
  final String serviceId;
  final String userPhNo;
  final String smePhNo;
  final String catId;
  final String qesId;
  final String questionDetails;
  final String status;
  final bool payment;

  CustomerRequestModel({
    required this.requestId,
    required this.serviceId,
    required this.userPhNo,
    required this.smePhNo,
    required this.catId,
    required this.qesId,
    required this.questionDetails,
    required this.status,
    required this.payment,
  });

  factory CustomerRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerRequestModel(
      requestId: json['req_id'] ?? '',
      serviceId: json['service_id'] ?? '',
      userPhNo: json['service_id'] ?? '',
      smePhNo: json['service_id'] ?? '',
      catId: json['service_id'] ?? '',
      qesId: json['service_name'] ?? '',
      questionDetails: json['service_rate'] ?? '',
      status: json['service_rate'] ?? '',
      payment: json['service_rate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'service_name': serviceName,
      'service_rate': serviceRate,
      'max_service_count': maxServiceCount,
      'created_dt': startDate.toIso8601String(),
      'expiery_dt': endDate.toIso8601String(),
    };
  }
}

class ServiceList {
  final List<CustomerRequestModel> serviceList;
  ServiceList({required this.serviceList});
}

class CustomerRequestModelNotifier
    extends StateNotifier<List<CustomerRequestModel>> {
  CustomerRequestModelNotifier() : super(<CustomerRequestModel>[]);

  void updateCustomerRequestModel(List<CustomerRequestModel> newList) {
    state = newList;
  }

  void addCustomerRequestModel(CustomerRequestModel newService) {
    state = [...state, newService];
  }

  void addCustomerRequestModels(List<CustomerRequestModel> newLists) {
    state = [...state, ...newLists];
  }

  void removeCustomerRequestModel(CustomerRequestModel serviceToRemove) {
    state = state.where((service) => service != serviceToRemove).toList();
  }
}
