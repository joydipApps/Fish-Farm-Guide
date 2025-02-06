import 'dart:convert';
import 'dart:io';
import '../../../utils/http_urls.dart';
import '../../../utils/show_progress_dialog.dart';
import '../../../utils/show_snack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PinCodeDataService {
  final String baseUrl = Urls.getPinCodeDataEndPoint;

  Future<Map<String, dynamic>?> getData(
      BuildContext context, String pinCode) async {
    // Show loading indicator
    showProgressDialogSync(context); // Show loading indicator

    final url = "$baseUrl/$pinCode";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['Status'] == 'Error') {
          showSnackDialog(context, 5, "Pin Code is not valid.");
          return null;
        } else {
          final postOfficeArray = jsonResponse['PostOffice'] as List;
          final data = postOfficeArray.isNotEmpty ? postOfficeArray[0] : null;

          if (data == null) {
            showSnackDialog(context, 2, "No data found for this Pin Code.");
            return null;
          }

          return data;
        }
      } else {
        showSnackDialog(context, 5, "Failed to fetch data. Please try again.");
        return null;
      }
    } on SocketException {
      showSnackDialog(
          context, 5, "Network error. Please check your connection.");
      return null;
    } on http.ClientException {
      showSnackDialog(context, 5, "Client error. Try again later.");
      return null;
    } on FormatException {
      showSnackDialog(context, 5, "Invalid data format received.");
      return null;
    } catch (e) {
      showSnackDialog(context, 6, 'Error occurred. Please try again.');
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      } // Dismiss the loading indicator
    }
  }
}
