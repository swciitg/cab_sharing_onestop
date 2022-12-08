import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const String _api = "https://swc.iitg.ac.in/onestopapi/v2/campus-travel";
  static Future<Map<String, dynamic>> postSellData(
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
          'travelDateTime' : data['travelDateTime'],
          'email': data['email'],
          'name': data['name']
        }),
        headers: {
          'Content-Type': 'application/json',
          'security-key': 'WeLoveThisWorld3000'
        });
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }
}