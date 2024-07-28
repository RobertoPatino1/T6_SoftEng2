import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:logging/logging.dart';

Future<dynamic> postRequest(String url, Map<String, dynamic> body) async {
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
  Logger.root.info("POST: ${response.body}");
  return jsonDecode(response.body);
}

Future<dynamic> getRequest(String url) async {
  final response = await http.get(Uri.parse(url));
  Logger.root.info("GET: ${response.body}");
  return jsonDecode(response.body);
}

Future<dynamic> putRequest(String url, Map<String, dynamic> body) async {
  final response = await http.put(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
  Logger.root.info("PUT: ${response.body}");
  return jsonDecode(response.body);
}

Future<dynamic> deleteRequest(String url) async {
  final response = await http.delete(Uri.parse(url));
  Logger.root.info("DELETE: ${response.body}");
  return jsonDecode(response.body);
}
