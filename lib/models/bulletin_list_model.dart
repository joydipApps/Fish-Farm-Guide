import 'package:flutter_riverpod/flutter_riverpod.dart';

class BulletinListModel {
  int bulletinId;
  String bulletinDate;
  int bulletinIndexId;
  String bulletinHeader;
  String bulletinText;
  String bulletinImageBase64;
  String isActive;
  String bulletinLanguage;
  String bulletinCategory;
  String bulletinUrl;

  BulletinListModel({
    required this.bulletinId,
    required this.bulletinDate,
    required this.bulletinIndexId,
    required this.bulletinHeader,
    required this.bulletinText,
    required this.bulletinImageBase64,
    required this.isActive,
    required this.bulletinLanguage,
    required this.bulletinCategory,
    required this.bulletinUrl,
  });

  factory BulletinListModel.fromJson(Map<String, dynamic> json) {
    return BulletinListModel(
      bulletinId: int.tryParse(json['bulletin_id'].toString()) ?? 0,
      bulletinDate: json['bulletin_date'] ?? '',
      bulletinIndexId: int.tryParse(json['bulletin_index_id'].toString()) ?? 0,
      bulletinHeader: json['bulletin_header'] ?? '',
      bulletinText: json['bulletin_text'] ?? '',
      bulletinImageBase64: json['bulletin_image_base64'] ?? '',
      isActive: json['is_active'] ?? '',
      bulletinLanguage: json['bulletin_language'] ?? '',
      bulletinCategory: json['bulletin_category'] ?? '',
      bulletinUrl: json['bulletin_url'] ?? '',
    );
  }
}

class BulletinListModelList {
  final List<BulletinListModel> bulletinList;

  BulletinListModelList({required this.bulletinList});
}

class BulletinListModelListNotifier
    extends StateNotifier<BulletinListModelList> {
  BulletinListModelListNotifier()
      : super(BulletinListModelList(bulletinList: <BulletinListModel>[]));

  void updateBulletinList(BulletinListModelList newBulletinList) {
    state = newBulletinList;
  }

  // add one record
  void addBulletinListModel(BulletinListModel newBulletinList) {
    final updatedList = [...state.bulletinList, newBulletinList];
    state = BulletinListModelList(bulletinList: updatedList);
  }

  // add multiple records
  void addBulletinListModels(BulletinListModelList newListes) {
    final updatedLists = [...state.bulletinList, ...newListes.bulletinList];
    state = BulletinListModelList(bulletinList: updatedLists);
  }

  void removeBulletinListModel(BulletinListModel listToRemove) {
    final updatedLists =
        state.bulletinList.where((list) => list != listToRemove).toList();
    state = BulletinListModelList(bulletinList: updatedLists);
  }
}
