import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceListModel {
  final String serviceId;
  final String serviceName;
  final String serviceRate;
  final String maxServiceCount;
  final DateTime startDate;
  final DateTime endDate;

  ServiceListModel({
    required this.serviceId,
    required this.serviceName,
    required this.serviceRate,
    required this.maxServiceCount,
    required this.startDate,
    required this.endDate,
  });

  factory ServiceListModel.fromJson(Map<String, dynamic> json) {
    DateTime parsedStartDate = DateTime.tryParse(json['created_dt'] ?? '') ??
        DateTime(2000); // Meaningful default date
    DateTime parsedEndDate = DateTime.tryParse(json['expiery_dt'] ?? '') ??
        DateTime(2000); // Handle invalid date gracefully

    return ServiceListModel(
      serviceId: json['service_id'] ?? '',
      serviceName: json['service_name'] ?? '',
      serviceRate: json['service_rate'] ?? '',
      maxServiceCount: json['max_service_count'] ?? '',
      startDate: parsedStartDate,
      endDate: parsedEndDate.add(
          const Duration(days: 365)), // Consider if this is truly necessary
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
  final List<ServiceListModel> serviceList;
  ServiceList({required this.serviceList});
}

class ServiceListModelNotifier extends StateNotifier<List<ServiceListModel>> {
  ServiceListModelNotifier() : super(<ServiceListModel>[]);

  void updateServiceListModel(List<ServiceListModel> newList) {
    state = newList;
  }

  void addServiceListModel(ServiceListModel newService) {
    state = [...state, newService];
  }

  void addServiceListModels(List<ServiceListModel> newLists) {
    state = [...state, ...newLists];
  }

  void removeServiceListModel(ServiceListModel serviceToRemove) {
    state = state.where((service) => service != serviceToRemove).toList();
  }
}
