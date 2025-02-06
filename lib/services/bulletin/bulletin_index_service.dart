import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/bulletin_index_model.dart';
import '../../utils/http_urls.dart';
import 'package:flutter/material.dart';

import '../../utils/local_shared_Storage.dart';

class BulletinIndexService {
  final String baseUrl = Urls.bulletinIndexEndPoint;

  Future<BulletinIndexModelList?> getBulletinIndexData() async {
    String languageCode = await LocalSharedStorage().getLanguageCode();
    debugPrint('Bulletin Language Code: $languageCode');
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({"bulletin_language": languageCode}),
      );

      debugPrint('Bulletin Request URL: $baseUrl');
      debugPrint('Bulletin Response Status Code: ${response.statusCode}');
      debugPrint('Bulletin Response Body: ${response.body}');
      debugPrint('Bulletin Response Body: End -- Testing1');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> indexDetailsList = responseData['Details'];
        debugPrint('Bulletin Number of Records: ${indexDetailsList.length}');

        // Correcting the mapping of BulletinIndexModel
        final List<BulletinIndexModel> indexModels = indexDetailsList
            .map((indexDetails) => BulletinIndexModel.fromJson(indexDetails))
            .toList();

        final bulletinIndexModelList =
            BulletinIndexModelList(bulletinIndex: indexModels.toSet());
        debugPrint(' ***Bulletin Returning Model ***');

        return bulletinIndexModelList;
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
