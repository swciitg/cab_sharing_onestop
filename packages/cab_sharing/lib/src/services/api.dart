import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const String _api =
      "https://swc.iitg.ac.in/onestopapi/v2/campus-travel";
  static Future<Map<String, dynamic>> postTripData(
      Map<String, dynamic> data) async {
    print("debug");
    print(data);
    var res = await http.post(Uri.parse(_api),
        body: jsonEncode({
          'to': data['to'],
          'from': data['from'],
          'margin': data['margin'],
          'note': data['note'],
          'phonenumber': data['phonenumber'],
          'travelDateTime': data['travelDateTime'],
          'email': data['email'],
          'name': data['name']
        }),
        headers: {
          'Content-Type': 'application/json',
          'security-key': data['security-key']!
        });
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> getSearchResults(
      Map<String, dynamic> data) async {
    print("debug");
    print(data);
    var res = await http.post(Uri.parse(_api),
        body: jsonEncode({
          'to': data['to'],
          'from': data['from'],
          'travelDateTime': data['travelDateTime'],
        }),
        headers: {
          'Content-Type': 'application/json',
          'security-key': data['security-key']!
        });
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }
}
