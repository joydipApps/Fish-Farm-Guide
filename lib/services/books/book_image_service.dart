import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/book_image_model.dart';
import '../../utils/http_urls.dart';

class BookImageService {
  final String baseUrl = Urls.bookImageEndPoint;

  Future<BookImageModelList?> getBookImageData({required String bookId}) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({"book_id": bookId}),
      );

      debugPrint('Service - Request URL: $baseUrl');
      debugPrint('Service - Response Status Code: ${response.statusCode}');
      debugPrint(
          'Service - Response Body: ${response.body.substring(0, min(100000, response.body.length))}...');
      debugPrint('Service - Response Body: End going to read Details');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> detailsList = responseData['Details'];
        debugPrint('Service - Number of Records: ${detailsList.length}');

        // Correcting the mapping of BulletinListModel
        final List<BookImageModel> listModels = detailsList
            .map((listDetails) => BookImageModel.fromJson(listDetails))
            .toList();

        final bookImageModelList = BookImageModelList(
          bookImageList: listModels.toList(),
        );

        debugPrint(' ***Bulletin Returning bookList');

        return bookImageModelList;
      } else {
        debugPrint('Service - API Error: ${response.body}');
        debugPrint('Service - Response Body: End -- Testing2');
        return null;
      }
    } catch (e) {
      debugPrint('Service - Error: $e');
      debugPrint('Service - Response Body: End -- Testing3');
      return null;
    }
  }
}
