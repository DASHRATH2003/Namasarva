import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  _fetchCityList();
}

Future<void> _fetchCityList() async {
  const String url =
      "https://namma-savaari-api-backend-9mpl.vercel.app/city-list";
  const Map<String, String> headers = {
    "Content-Type": "application/json",
    "Api-Token": "Namma@90434#34",
  };

  const Map<String, String> body = {
    "ClientId": "180187",
    "UserName": "Namma434",
    "Password": "Namma@4341",
    "EndUserIp": "157.48.136.69"
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      if (data["Error"]["ErrorCode"] == 1 && data["Result"] != null) {
      } else {
        debugPrint(data["Error"]["ErrorMessage"] ?? "Unknown error");
      }
    } else {
      debugPrint("Failed to fetch data. Status code: ${response.statusCode}");
    }
  } catch (e) {
    debugPrint("An error occurred: $e");
  } finally {
    debugPrint('api call completed');
  }
}
