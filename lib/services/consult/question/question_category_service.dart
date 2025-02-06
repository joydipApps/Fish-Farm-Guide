import 'dart:convert';
import 'dart:io'; // Import this for HttpHeaders
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/consult/question/question_category_list.dart';
import '../../../utils/http_urls.dart';
import '../../../utils/show_progress_dialog.dart';
import '../../../utils/show_snack_dialog.dart';

class QuestionCategoryListService {
  final String baseUrl = Urls.getQuestionCategoryListEndPoint;

  Future<List<QuestionCategoryListModel>?> fetchQuestionCategoryList(
      BuildContext context) async {
    // Show loading dialog
    showProgressDialogSync(context); // Show loading indicator

    try {
      // Make the HTTP request
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      );

      // Check if response status is OK
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Check if response contains "Details" key
        if (responseData.containsKey("Details")) {
          final List<dynamic>? details = responseData["Details"];

          // Check if "Details" is not null and return parsed list
          if (details != null) {
            // TODO  update June8
            // final List<QuestionCategoryListModel> fishList =
            //     details.map(QuestionCategoryListModel.fromJson).toList();
            final List<QuestionCategoryListModel> fishList = details
                .map<QuestionCategoryListModel>((item) =>
                    QuestionCategoryListModel.fromJson(
                        item as Map<String, dynamic>))
                .toList();

            //displaySnackBar(context, 1, "Data Saved successfully.");
            return fishList;
          } else {
            // showSnackDialog(context, 2, "No data found, try later.");
            return []; // Return null for empty "Details"
          }
        } else {
          // showSnackDialog(context, 2, "No data found, try later.");
          return []; // Return null for missing "Details"
        }
      } else {
        // showSnackDialog(context, 2, "No data found, try later.");
        return []; // Return null for failed status code
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }

      return null;
    } on http.ClientException catch (e) {
      if (context.mounted) {
        showSnackDialog(context, 2, "Network Error, try later.");
      }

      return []; // Return null for network errors
    } on FormatException catch (e) {
      debugPrint('[F8] Format Error: $e');
      // showSnackDialog(context, 2, "Format Error, try later.");
      return []; // Return null for format errors
    } catch (e) {
      if (context.mounted) {
        showSnackDialog(context, 2, "Unknown Error, try later.");
      }

      return []; // Return null for unknown errors
    } finally {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      // Dismiss the loading indicator
    }
  }
}
