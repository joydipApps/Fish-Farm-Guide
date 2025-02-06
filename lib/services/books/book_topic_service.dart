import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/books_topic_model.dart';
import '../../utils/http_urls.dart';

class BookTopicService {
  final String baseUrl = Urls.bookTopicEndPoint;

  Future<BookTopicModel?> getBookTopicData({required String bookId}) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({"book_id": bookId}),
      );

      debugPrint('Request URL: $baseUrl');
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint(
          'Response Body: ${response.body.substring(0, min(100000, response.body.length))}...');
      debugPrint('Response Body: End going to read Details');

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        // Check if the response is a map
        if (responseData is Map<String, dynamic>) {
          // Handle the case where the response is a single record
          final List<dynamic> detailsList = responseData['Details'];

          if (detailsList.isNotEmpty) {
            final dynamic details = detailsList[0];
            if (details is Map<String, dynamic>) {
              final BookTopicModel bookModel = BookTopicModel.fromJson(details);
              debugPrint('book_id: ${bookModel.bookId}');
              debugPrint('book_name: ${bookModel.bookName}');
              debugPrint('language_code: ${bookModel.languageCode}');
              debugPrint('book_details: ${bookModel.bookDetails}');

              debugPrint(' *** Returning Model ***');
              return bookModel;
            } else {
              debugPrint('Invalid format inside "Details"');
              return null;
            }
          } else {
            debugPrint('"Details" array is empty');
            return null;
          }
        } else {
          // Handle unexpected response format
          debugPrint('Unexpected response format: $responseData');
          return null;
        }
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
