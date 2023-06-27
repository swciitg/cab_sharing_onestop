import 'dart:convert';

import 'package:cab_sharing/src/functions/title_case.dart';
import 'package:cab_sharing/src/stores/login_store.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../globals/database_strings.dart';
import '../globals/endpoints.dart';
import '../models/post_model.dart';
import '../models/reply_model.dart';
import '../utilities/auth_user_helpers.dart';
import '../utilities/show_snackbar.dart';

class APIService {

  final dio = Dio(BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: Endpoints.getHeader()));

  APIService() {

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      print("THIS IS TOKEN");
      print(await AuthUserHelpers.getAccessToken());
      print(options.path);
      options.headers["Authorization"] =
      "Bearer ${await AuthUserHelpers.getAccessToken()}";
      handler.next(options);
    }, onError: (error, handler) async {
      var response = error.response;
      if (response != null && response.statusCode == 401) {
        if((await AuthUserHelpers.getAccessToken()).isEmpty){
          showSnackBar("Login to continue!!");
        }
        else{
          print(response.requestOptions.path);
          bool couldRegenerate = await regenerateAccessToken();
          // ignore: use_build_context_synchronously
          if (couldRegenerate) {
            // retry
            return handler.resolve(await retryRequest(response));
          } else {
            showSnackBar("Your session has expired!! Login again.");
          }
        }
      }
      else if(response != null && response.statusCode == 403){
        showSnackBar("Access not allowed in guest mode");
      }
      // admin user with expired tokens
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> retryRequest(Response response) async {
    RequestOptions requestOptions = response.requestOptions;
    response.requestOptions.headers[BackendHelper.authorization] =
    "Bearer ${await AuthUserHelpers.getAccessToken()}";
    final options = Options(method: requestOptions.method, headers: requestOptions.headers);
    Dio retryDio = Dio(BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {
          'Security-Key': Endpoints.apiSecurityKey
        }));
    if (requestOptions.method == "GET") {
      return retryDio.request(requestOptions.path,
          queryParameters: requestOptions.queryParameters, options: options);
    } else {
      return retryDio.request(requestOptions.path,
          queryParameters: requestOptions.queryParameters,
          data: requestOptions.data,
          options: options);
    }
  }

  Future<bool> regenerateAccessToken() async {
    String refreshToken = await AuthUserHelpers.getRefreshToken();
    try {
      Dio regenDio = Dio(BaseOptions(
          baseUrl: Endpoints.baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {
            'Security-Key': Endpoints.apiSecurityKey
          }));
      Response<Map<String, dynamic>> resp = await regenDio.post(
          "/user/accesstoken",
          options: Options(headers: {"authorization": "Bearer $refreshToken"}));
      var data = resp.data!;
      await AuthUserHelpers.setAccessToken(data["token"]);
      return true;
    } catch (err) {
      return false;
    }
  }


  static const String _api = const String.fromEnvironment('SERVER-URL') + '/campus-travel';

  Future<List<Map<String, List<PostModel>>>> getAllPosts(Map<String, dynamic> data) async {
    var response = await dio.get(Endpoints.cabSharingURL);
    print(response.data);
    var map = response.data['details'];
    List<Map<String, List<PostModel>>> answer = [];
    map.forEach((key, value) {
      var postList = value as List<dynamic>;
      List<PostModel> posts = [];
      for (var json in postList) {
        posts.add(PostModel.fromJson(json));
      }
      answer.add({key: posts});
    });
    print(answer);
    return answer;
    // http.Response response = await http.get(Uri.parse(_api), headers: {
    //   'Content-Type': 'application/json',
    //   'security-key': data['security-key']!
    // });
    // if (response.statusCode == 200) {
    //   var map = jsonDecode(response.body)['details'] as Map<String, dynamic>;
    //   List<Map<String, List<PostModel>>> answer = [];
    //   map.forEach((key, value) {
    //     var postList = value as List<dynamic>;
    //     List<PostModel> posts = [];
    //     for (var json in postList) {
    //       posts.add(PostModel.fromJson(json));
    //     }
    //     answer.add({key: posts});
    //   });
    //   return answer;
    // } else {
    //   throw Exception('Posts could not be fetched');
    // }
  }

  Future<Map<String, List<PostModel>>> getSearchResults(Map<String, dynamic> data) async {
    print(data);
    final queryParameters = {
      'travelDateTime': data['travelDateTime'],
      'to': data['to'],
      'from': data['from'],
    };
    print(queryParameters);
    var response = await dio.get(Endpoints.cabSharingURL,queryParameters: queryParameters);
    print(response.data);
    var map = response.data['details'];
    Map<String, List<PostModel>> answer = {};
    map.forEach((key, value) {
      var postList = value;
      List<PostModel> posts = [];
      for (var json in postList) {
        posts.add(PostModel.fromJson(json));
      }
      answer[key] = posts;
    });
    print(answer);
    return answer;
    // final uri = Uri.https(_api,"", queryParameters);
    // http.Response response = await http.get(uri, headers: {
    //   'Content-Type': 'application/json',
    //   'security-key': data['security-key']!
    // });
    // if (response.statusCode == 200) {
    //   var map = jsonDecode(response.body)['details'] as Map<String, dynamic>;
    //   Map<String, List<PostModel>> answer = {};
    //   map.forEach((key, value) {
    //     var postList = value as List<dynamic>;
    //     List<PostModel> posts = [];
    //     for (var json in postList) {
    //       posts.add(PostModel.fromJson(json));
    //     }
    //     answer[key] = posts;
    //   });
    //   return answer;
    // } else {
    //   throw Exception('Search Results could not be fetched');
    // }
  }

  Future<List<PostModel>> getMyPosts(Map<String, dynamic> data) async {
    final queryParameters = {'email': data['email']};
    var response = await dio.get(Endpoints.cabSharingMyAdsURL,queryParameters: queryParameters);
    var posts = response.data['details'];
    List<PostModel> answer = [];
    for (var post in posts) {
      answer.add(PostModel.fromJson(post));
    }
    return answer;
    // final uri = Uri.https(_api, '/myads', queryParameters);
    // http.Response response = await http.get(uri, headers: {
    //   'Content-Type': 'application/json',
    //   'security-key': data['security-key']!
    // });
    // if (response.statusCode == 200) {
    //   var posts = jsonDecode(response.body)['details'] as List<dynamic>;
    //   List<PostModel> answer = [];
    //   for (var post in posts) {
    //     answer.add(PostModel.fromJson(post));
    //   }
    //   return answer;
    // } else {
    //   throw Exception('My Posts could not be fetched');
    // }
  }

  Future<Map<String, dynamic>> postTripData(Map<String, dynamic> data) async {
    var response = await dio.post(Endpoints.cabSharingURL,
      data: {
      'to': data['to'],
      'from': data['from'],
      'margin': data['margin'],
      'note': data['note'],
      'phonenumber': data['phonenumber'],
      'travelDateTime': data['travelDateTime'],
      'email': data['email'],
      'name': (data['name'] as String).toTitleCase(),
    });
    // var res = await http.post(Uri.parse(_api),
    //     body: jsonEncode(
    //       {
    //         'to': data['to'],
    //         'from': data['from'],
    //         'margin': data['margin'],
    //         'note': data['note'],
    //         'phonenumber': data['phonenumber'],
    //         'travelDateTime': data['travelDateTime'],
    //         'email': data['email'],
    //         'name': (data['name'] as String).toTitleCase(),
    //       },
    //     ),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'security-key': data['security-key']!
    //     });
    return response.data;
  }

  Future<bool> deletePost(Map<String, String> data) async {
    try {
      var response = await dio.delete(
        "${Endpoints.cabSharingURL}?travelPostId=${data['postId']}",
        data: {
          'email' : LoginStore.userData['email']
        }
      );
      // var res = await http.delete(
      //     Uri.parse(),
      //     body: jsonEncode({'email': data['email']}),
      //     headers: {
      //       'Content-Type': 'application/json',
      //       'security-key': data['security-key']!
      //     });
      var jsonResponse = response.data;
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

  Future<List<ReplyModel>> getPostReplies(String chatId) async {
    final queryParameters = {
      'chatId': chatId,
    };
    var response = await dio.get(Endpoints.cabSharingChatURL,queryParameters: queryParameters);
    List<dynamic> listReplies = response.data['replies'];
    List<ReplyModel> replies = [];
    for (var reply in listReplies) {
      replies.add(ReplyModel.fromJson(reply));
    }
    return replies;
    // final uri = Uri.https(_api, '/chat', queryParameters);
    // try {
    //   http.Response response = await http.get(uri);
    //   var jsonResponse = jsonDecode(response.body);
    //   List<dynamic> listReplies = jsonResponse['replies'];
    //   var replies = listReplies.map((e) => ReplyModel.fromJson(e)).toList();
    //   return replies;
    // } catch (e) {
    //   throw Exception("An error occurred in fetching replies");
    // }
  }

  Future<bool> postReply(String name, String email, String message, String chatId, String securityKey) async {
    final queryParameters = {
      'chatId': chatId,
    };
    var response = await dio.post(Endpoints.cabSharingChatURL,data: {
      'name': name.toTitleCase(),
      'message': message,
      'email':email,
    });
    var jsonResponse = response.data;
    if (jsonResponse['success'] == true) {
      return true;
    }
    return false;
    // final uri = Uri.https(_api, '/chat', queryParameters);
    // try {
    //   var res = await http.post(uri,
    //       body: jsonEncode(
    //         {
    //           'name': name.toTitleCase(),
    //           'message': message,
    //           'email':email,
    //         },
    //       ),
    //       headers: {
    //         'Content-Type': 'application/json',
    //         'security-key': securityKey
    //       });
    //   var jsonResponse = jsonDecode(res.body);
    //   if (jsonResponse['success'] == true) {
    //     return true;
    //   }
    //   return false;
    // } catch (e) {
    //   return false;
    // }
  }
}
