import 'package:cab_sharing/src/functions/title_case.dart';
import 'package:cab_sharing/src/stores/login_store.dart';
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
      options.headers["Authorization"] =
          "Bearer ${await AuthUserHelpers.getAccessToken()}";
      handler.next(options);
    }, onError: (error, handler) async {
      var response = error.response;
      if (response != null && response.statusCode == 401) {
        if ((await AuthUserHelpers.getAccessToken()).isEmpty) {
          showSnackBar("Login to continue!!");
        } else {
          bool couldRegenerate = await regenerateAccessToken();
          // ignore: use_build_context_synchronously
          if (couldRegenerate) {
            // retry
            return handler.resolve(await retryRequest(response));
          } else {
            showSnackBar("Your session has expired!! Login again.");
          }
        }
      } else if (response != null && response.statusCode == 403) {
        showSnackBar("Access not allowed in guest mode");
      } else if (response != null && response.statusCode == 400) {
        showSnackBar(response.data["message"]);
      }
      // admin user with expired tokens
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> retryRequest(Response response) async {
    RequestOptions requestOptions = response.requestOptions;
    response.requestOptions.headers[BackendHelper.authorization] =
        "Bearer ${await AuthUserHelpers.getAccessToken()}";
    final options =
        Options(method: requestOptions.method, headers: requestOptions.headers);
    Dio retryDio = Dio(BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {'Security-Key': Endpoints.apiSecurityKey}));
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
          receiveTimeout: const Duration(seconds: 5)));
      Response resp = await regenDio.post("/user/accesstoken",
          options: Options(headers: {
            'Security-Key': Endpoints.apiSecurityKey,
            "authorization": "Bearer $refreshToken"
          }));
      var data = resp.data!;

      await AuthUserHelpers.setAccessToken(data[BackendHelper.accesstoken]);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<List<Map<String, List<PostModel>>>> getAllPosts(
      Map<String, dynamic> data) async {
    var response = await dio.get(Endpoints.cabSharingURL);
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
    return answer;
  }

  Future<Map<String, List<PostModel>>> getSearchResults(
      Map<String, dynamic> data) async {
    final queryParameters = {
      'travelDateTime': data['travelDateTime'],
      'to': data['to'],
      'from': data['from'],
    };
    var response = await dio.get(Endpoints.cabSharingURL,
        queryParameters: queryParameters);
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
    return answer;
  }

  Future<List<PostModel>> getMyPosts(Map<String, dynamic> data) async {
    final queryParameters = {'email': data['email']};
    var response = await dio.get(Endpoints.cabSharingMyAdsURL,
        queryParameters: queryParameters);
    var posts = response.data['details'];
    List<PostModel> answer = [];
    for (var post in posts) {
      answer.add(PostModel.fromJson(post));
    }
    return answer;
  }

  Future<Map<String, dynamic>> postTripData(Map<String, dynamic> data) async {
    var response = await dio.post(Endpoints.cabSharingURL, data: {
      'to': data['to'],
      'from': data['from'],
      'margin': data['margin'],
      'note': data['note'],
      'phonenumber': data['phonenumber'],
      'travelDateTime': data['travelDateTime'],
      'email': data['email'],
      'name': (data['name'] as String).toTitleCase(),
    });
    return response.data;
  }

  Future<bool> deletePost(Map<String, String> data) async {
    try {
      var response = await dio.delete(Endpoints.cabSharingURL,
          queryParameters: {"travelPostId": data['postId']},
          data: {'email': LoginStore.userData['email']});
      var jsonResponse = response.data;
      if (jsonResponse['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<List<ReplyModel>> getPostReplies(String chatId) async {
    final queryParameters = {
      'chatId': chatId,
    };
    var response = await dio.get(Endpoints.cabSharingChatURL,
        queryParameters: queryParameters);
    List<dynamic> listReplies = response.data['replies'];
    List<ReplyModel> replies = [];
    for (var reply in listReplies) {
      replies.add(ReplyModel.fromJson(reply));
    }
    return replies;
  }

  Future<bool> postReply(String name, String email, String message,
      String chatId, String securityKey) async {
    final queryParameters = {
      'chatId': chatId,
    };
    var response = await dio.post(Endpoints.cabSharingChatURL,
        data: {
          'name': name.toTitleCase(),
          'message': message,
          'email': email,
        },
        queryParameters: queryParameters);
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
