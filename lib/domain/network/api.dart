import 'dart:convert';

import 'package:energise_test/data/model/ip_model.dart';
import 'package:http/http.dart' as http;

abstract class ApiCall {}

class IpApiCall implements ApiCall {
  Future<IpCallModel> fetchIpData() async {
    final response = await http.get(Uri.parse('http://ip-api.com/json/'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return IpCallModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ip data');
    }
  }
}
