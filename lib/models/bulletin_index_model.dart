import 'package:flutter_riverpod/flutter_riverpod.dart';

class BulletinIndexModel {
  int bulletinIndexId;
  String bulletinIndexName;
  String bulletinIndexIconKey;
  int totalRecord;

  BulletinIndexModel({
    required this.bulletinIndexId,
    required this.bulletinIndexName,
    required this.bulletinIndexIconKey,
    required this.totalRecord,
  });

  factory BulletinIndexModel.fromJson(Map<String, dynamic> json) {
    return BulletinIndexModel(
      bulletinIndexId: int.tryParse(json['bulletin_index_id'].toString()) ?? 0,
      bulletinIndexName: json['bulletin_index_name'] ?? '',
      bulletinIndexIconKey: json['bulletin_index_icon_key'] ?? '',
      totalRecord: int.tryParse(json['total_record'].toString()) ?? 0,
    );
  }
}

class BulletinIndexModelList {
  final Set<BulletinIndexModel> bulletinIndex;

  BulletinIndexModelList({required this.bulletinIndex});
}

class BulletinIndexModelListNotifier
    extends StateNotifier<BulletinIndexModelList> {
  BulletinIndexModelListNotifier()
      : super(BulletinIndexModelList(bulletinIndex: <BulletinIndexModel>{}));

  void updateBulletinIndexList(BulletinIndexModelList newBulletinIndex) {
    state = newBulletinIndex;
  }

  // add one record
  void addBulletinIndex(BulletinIndexModel newBulletinIndex) {
    final updatedIndex = {...state.bulletinIndex, newBulletinIndex};
    state = BulletinIndexModelList(bulletinIndex: updatedIndex);
  }

  // add multiple record
  void addBulletinIndexes(BulletinIndexModelList newIndexes) {
    final updatedIndexes = {
      ...state.bulletinIndex,
      ...newIndexes.bulletinIndex
    };
    state = BulletinIndexModelList(bulletinIndex: updatedIndexes);
  }

  void removeBulletinIndex(BulletinIndexModel indexToRemove) {
    final updatedIndexes =
        state.bulletinIndex.where((index) => index != indexToRemove).toSet();
    state = BulletinIndexModelList(bulletinIndex: updatedIndexes);
  }
}
