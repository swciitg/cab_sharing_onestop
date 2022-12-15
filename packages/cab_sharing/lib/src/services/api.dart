import 'dart:convert';

import 'package:cab_sharing/src/functions/title_case.dart';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';
import '../models/reply_model.dart';

class APIService {
  static const String _api =
      "https://swc.iitg.ac.in/onestopapi/v2/campus-travel";
  static const String _path = "/onestopapi/v2/campus-travel";
  static const String _host = "swc.iitg.ac.in";

  static Future<List<Map<String, List<PostModel>>>> getAllPosts(
      Map<String, dynamic> data) async {
    http.Response response = await http.get(Uri.parse(_api), headers: {
      'Content-Type': 'application/json',
      'security-key': String.fromEnvironment('SECURITY-KEY')!,
    });
    if (response.statusCode == 200) {
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
    } else {
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
      'security-key': String.fromEnvironment('SECURITY-KEY')!,
    });
    if (response.statusCode == 200) {
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
    } else {
      throw Exception('Search Results could not be fetched');
    }
  }

  static Future<List<PostModel>> getMyPosts(Map<String, dynamic> data) async {
    final queryParameters = {'email': data['email']};
    final uri = Uri.https(_host, '$_path/myads', queryParameters);
    http.Response response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'security-key': String.fromEnvironment('SECURITY-KEY')!,
    });
    if (response.statusCode == 200) {
      var posts = jsonDecode(response.body)['details'] as List<dynamic>;
      List<PostModel> answer = [];
      for (var post in posts) {
        answer.add(PostModel.fromJson(post));
      }
      return answer;
    } else {
      throw Exception('My Posts could not be fetched');
    }
  }

  static Future<Map<String, dynamic>> postTripData(
      Map<String, dynamic> data) async {
    var res = await http.post(Uri.parse(_api),
        body: jsonEncode(
          {
            'to': data['to'],
            'from': data['from'],
            'margin': data['margin'],
            'note': data['note'],
            'phonenumber': data['phonenumber'],
            'travelDateTime': data['travelDateTime'],
            'email': data['email'],
            'name': (data['name'] as String).toTitleCase(),
          },
        ),
        headers: {
          'Content-Type': 'application/json',
          'security-key': String.fromEnvironment('SECURITY-KEY')!,
        });
    return jsonDecode(res.body);
  }

  static Future<bool> deletePost(Map<String, String> data) async {
    try {
      var res = await http.delete(
          Uri.parse("$_api?travelPostId=${data['postId']}"),
          body: jsonEncode({'email': data['email']}),
          headers: {
            'Content-Type': 'application/json',
            'security-key': String.fromEnvironment('SECURITY-KEY')!,
          });
      var jsonResponse = jsonDecode(res.body);
      if (jsonResponse['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // static Future<Map<String, dynamic>> deleteAllPost(
  //     Map<String, dynamic> data) async {
  //   var res = await http.delete(Uri.parse('$_api/all'), headers: {
  //     'Content-Type': 'application/json',
  //     'security-key': data['security-key']!
  //   });
  //   return jsonDecode(res.body);
  // }

  static Future<List<ReplyModel>> getPostReplies(String chatId) async {
    final queryParameters = {
      'chatId': chatId,
    };
    final uri = Uri.https(_host, '$_path/chat', queryParameters);
    try {
      http.Response response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body);
      List<dynamic> listReplies = jsonResponse['replies'];
      var replies = listReplies.map((e) => ReplyModel.fromJson(e)).toList();
      return replies;
    } catch (e) {
      throw Exception("An error occurred in fetching replies");
    }
  }

  static Future<bool> postReply(
      String name, String email, String message, String chatId, String securityKey) async {
    final queryParameters = {
      'chatId': chatId,
    };
    final uri = Uri.https(_host, '$_path/chat', queryParameters);
    try {
      var res = await http.post(uri,
          body: jsonEncode(
            {
              'name': name.toTitleCase(),
              'message': message,
              'email':email,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
            'security-key': String.fromEnvironment('SECURITY-KEY')!,
          });
      var jsonResponse = jsonDecode(res.body);
      if (jsonResponse['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
