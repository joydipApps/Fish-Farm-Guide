import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/bulletin_list_model.dart';
import '../../utils/http_urls.dart';
import 'package:flutter/material.dart';

class BulletinListService {
  final String baseUrl = Urls.bulletinListEndPoint;

  Future<BulletinListModelList?> getBulletinListData(
      {required String bulletinLanguage, required int bulletinIndexId}) async {
    // String languageCode = await LocalSharedStorage().getLanguageCode();
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({
          "bulletin_language": bulletinLanguage,
          "bulletin_index_id": bulletinIndexId,
        }),
      );

      debugPrint('Bulletin Request URL: $baseUrl');
      debugPrint('Bulletin Response Status Code: ${response.statusCode}');
      debugPrint('Bulletin Response Body: ${response.body}');
      debugPrint('Bulletin Response Body: End -- Testing1');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> listDetailsList = responseData['Details'];
        debugPrint('Bulletin Number of Records: ${listDetailsList.length}');

        // Correcting the mapping of BulletinListModel
        final List<BulletinListModel> listModels = listDetailsList
            .map((listDetails) => BulletinListModel.fromJson(listDetails))
            .toList();

        final bulletinListModelList =
            BulletinListModelList(bulletinList: listModels.toList());

        debugPrint(' ***Bulletin Returning Model ***');

        return bulletinListModelList;
      } else {
        debugPrint('Bulletin API Error: ${response.body}');
        debugPrint('Bulletin Response Body: End -- Testing2');
        return null; // Return null in case of API error
      }
    } catch (e) {
      debugPrint('Bulletin Error: $e');
      debugPrint('Bulletin Response Body: End -- Testing3');
      return null; // Return null in case of an exception
    }
  }
}
