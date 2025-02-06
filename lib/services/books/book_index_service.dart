import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/books_index_model.dart';
import '../../translate/language_store.dart';
import '../../utils/http_urls.dart';
import 'package:flutter/material.dart';

import '../../utils/local_shared_Storage.dart';

class BookIndexService {
  final String baseUrl = Urls.bookIndexEndPoint;

  Future<BookIndexModelList?> getBookIndexData() async {
    String languageCode = await LocalSharedStorage().getLanguageCode();

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({"language_code": languageCode}),
      );

      debugPrint('Request URL language_code: $languageCode');
      debugPrint('Request URL: $baseUrl');
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');
      debugPrint('Response Body: End -- Testing1');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> bookDetailsList = responseData['Details'];
        debugPrint('Number of Records: ${bookDetailsList.length}');
        final List<BookIndexModel> bookModels = bookDetailsList
            .map((bookDetails) => BookIndexModel.fromJson(bookDetails))
            .toList();

        final bookIndexModel = BookIndexModelList(books: bookModels.toSet());
        debugPrint(' *** Returning Model ***');

        return bookIndexModel;
      } else {
        debugPrint('API Error: ${response.body}');
        debugPrint('Response Body: End -- Testing2');
        return null; // Return null in case of API error
      }
    } catch (e) {
      debugPrint('Error: $e');
      debugPrint('Response Body: End -- Testing3');
      return null; // Return null in case of an exception
    }
  }
}
