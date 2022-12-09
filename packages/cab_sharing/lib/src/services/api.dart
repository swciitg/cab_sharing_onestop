import 'dart:convert';
import 'package:cab_sharing/src/models/posto_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  static const String _api = "https://swc.iitg.ac.in/onestopapi/v2/campus-travel";
  static const String _path = "/onestopapi/v2/campus-travel";
  static const String _host = "swc.iitg.ac.in";

  static Future<List<Map<String, List<PostModel>>>> getAllPosts(
      Map<String, dynamic> data) async {
    http.Response response = await http.get(Uri.parse(_api), headers: {
      'Content-Type': 'application/json',
      'security-key': data['security-key']!
    });
    if(response.statusCode == 200)
      {
        var map = jsonDecode(response.body)['details'] as Map<String, dynamic>;
        List<Map<String, List<PostModel>>> answer = [];
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
    else
      {
        throw Exception('Posts could not be fetched');
      }

  }

  static Future<Map<String, List<PostModel>>> getSearchResults(
      Map<String, dynamic> data) async {
    final queryParameters = {
      'travelDateTime': data['travelDateTime'],
      'to': data['to'],
      'from': data['from'],
    };
    final uri = Uri.https(_host, _path, queryParameters);
    http.Response response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'security-key': data['security-key']!
    });
    if(response.statusCode == 200)
      {
        var map = jsonDecode(response.body)['details'] as Map<String, dynamic>;
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
    else
      {
        throw Exception('Search Results could not be fetched');
      }

  }

  static Future<List<PostModel>> getMyPosts(Map<String, dynamic> data) async {
    final queryParameters = {'email': data['email']};
    final uri = Uri.https(_host, '$_path/myads', queryParameters);
    http.Response response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'security-key': data['security-key']!
    });
    if(response.statusCode == 200)
      {
        var posts = jsonDecode(response.body)['details'] as List<dynamic>;
        List<PostModel> answer = [];
        for (var post in posts) {
          answer.add(PostModel.fromJson(post));
        }
        return answer;
      }
    else
      {
        throw Exception('My Posts could not be fetched');
      }

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
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> deletePost(
      Map<String, String> data) async {
    print('delete post called');
    var res = await http.delete(Uri.parse("$_api?travelPostId=${data['postId']}"),
        body:jsonEncode({
          'email': data['email']
        }),
        headers: {
      'Content-Type': 'application/json',
      'security-key': data['security-key']!
    });
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> deleteAllPost(
      Map<String, dynamic> data) async {
    var res = await http.delete(Uri.parse('$_api/all'), headers: {
      'Content-Type': 'application/json',
      'security-key': data['security-key']!
    });
    return jsonDecode(res.body);
  }
}
