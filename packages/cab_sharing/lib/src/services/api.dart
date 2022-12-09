import 'dart:convert';
import 'package:cab_sharing/src/models/posto_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  static const String _api =
      "https://swc.iitg.ac.in/onestopapi/v2/campus-travel";
  static const String _myAds = "$_api/myads";

  static Future<List<Map<String,List<PostModel>>>> getAllPosts(Map<String, dynamic> data) async {
    var res = await http.get(Uri.parse(_api), headers: {
      'Content-Type': 'application/json',
      'security-key': data['security-key']!
    });
    var map = jsonDecode(res.body)['details'] as Map<String, dynamic>;
    List<Map<String,List<PostModel>>> answer = [];
    map.forEach((key, value) {
      var postList = value as List<dynamic>;
      List<PostModel> posts = [];
      for (var json in postList) {
        posts.add(PostModel.fromJson(json));
      }
      answer.add({key: posts});
    });
    return answer;
  }

  static Future<Map<String,List<PostModel>>> getSearchResults(
      Map<String, dynamic> data) async {
    final queryParameters = {
      'travelDateTime': data['travelDateTime'],
      'to': data['to'],
      'from': data['from'],
    };
    final uri = Uri.https(
        'swc.iitg.ac.in', '/onestopapi/v2/campus-travel', queryParameters);
    var res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'security-key': data['security-key']!
    });
    var map = jsonDecode(res.body)['details'] as Map<String,dynamic>;
    Map<String, List<PostModel>> answer = {};
    map.forEach((key, value) {
      var postList = value as List<dynamic>;
      List<PostModel> posts = [];
      for (var json in postList) {
        posts.add(PostModel.fromJson(json));
      }
      answer[key] = posts;
    });
    return answer;
  }

  static Future<List<PostModel>> getMyPosts(
      Map<String, dynamic> data) async {
    final queryParameters = {
      'email': data['email']
    };
    final uri = Uri.https(
        'swc.iitg.ac.in', '/onestopapi/v2/campus-travel', queryParameters);
    var res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'security-key': data['security-key']!
    });
    var map = jsonDecode(res.body)['details'] as Map<String, dynamic>;
    List<PostModel> answer = [];
    map.forEach((key, value) {
      var postList = value as List<dynamic>;
      for (var json in postList) {
        answer.add(PostModel.fromJson(json));
      }
    });
    print(answer);
    return answer;
  }
  static Future<Map<String, dynamic>> postTripData(
      Map<String, dynamic> data) async {
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
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> deleteAllPost(
      Map<String, dynamic> data) async {
    var res = await http.delete(
        Uri.parse('$_api/all'),
        headers: {
          'Content-Type': 'application/json',
          'security-key': data['security-key']!
        }
    );
    return jsonDecode(res.body);
  }


}
