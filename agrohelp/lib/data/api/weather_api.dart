import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';

String apiUrl = 'https://api.example.com/weather';

getData(String uri,{Map<String, String>? headers}) async {
  try {
    http.Response response = await http.get(
      Uri.parse(apiUrl),
    );
    return response;
  } catch (e) {
    print(e.toString());
    return null;
  }
}