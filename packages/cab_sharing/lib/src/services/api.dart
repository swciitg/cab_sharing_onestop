import 'package:cab_sharing/src/functions/title_case.dart';
import 'package:cab_sharing/src/stores/login_store.dart';
import 'package:cab_sharing/src/utilities/show_snackbar.dart';
import 'package:onestop_kit/onestop_kit.dart';

import '../globals/endpoints.dart';
import '../models/booking_model.dart';
import '../models/post_model.dart';
import '../models/reply_model.dart';

class APIService extends OneStopApi {
  APIService()
    : super(
        onestopSecurityKey: Endpoints.apiSecurityKey,
        onestopBaseUrl: Endpoints.baseUrl,
        serverBaseUrl: Endpoints.baseUrl,
        onRefreshTokenExpired: () async {
          await LoginStore.clearAppData();
          showSnackBar("Your session has expired!! Login again.");
        },
      );

  Future<List<Map<String, List<PostModel>>>> getAllPosts(
    Map<String, dynamic> data,
  ) async {
    var response = await serverDio.get(Endpoints.cabSharingURL);
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
    Map<String, dynamic> data,
  ) async {
    final queryParameters = {
      'travelDateTime': data['travelDateTime'],
      'to': data['to'],
      'from': data['from'],
    };
    var response = await serverDio.get(
      Endpoints.cabSharingURL,
      queryParameters: queryParameters,
    );
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
    var response = await serverDio.get(
      Endpoints.cabSharingMyAdsURL,
      queryParameters: queryParameters,
    );
    var posts = response.data['details'];
    List<PostModel> answer = [];
    for (var post in posts) {
      answer.add(PostModel.fromJson(post));
    }
    return answer;
  }

  Future<bool> postTripData(Map<String, dynamic> data) async {
    var response = await serverDio.post(
      Endpoints.cabSharingURL,
      data: {
        'to': data['to'],
        'from': data['from'],
        'margin': data['margin'],
        'note': data['note'],
        'phonenumber': data['phonenumber'],
        'travelDateTime': data['travelDateTime'],
        'email': data['email'],
        'name': (data['name'] as String).toTitleCase(),
        'totalSeats': data['totalSeats'],
        'availableSeats': data['availableSeats'],
      },
    );
    return response.data['success'] as bool;
  }

  Future<bool> deletePost(Map<String, String> data) async {
    try {
      var response = await serverDio.delete(
        Endpoints.cabSharingURL,
        queryParameters: {"travelPostId": data['postId']},
        data: {'email': LoginStore.userData['email']},
      );
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
    final queryParameters = {'chatId': chatId};
    var response = await serverDio.get(
      Endpoints.cabSharingChatURL,
      queryParameters: queryParameters,
    );
    List<dynamic> listReplies = response.data['replies'];
    List<ReplyModel> replies = [];
    for (var reply in listReplies) {
      replies.add(ReplyModel.fromJson(reply));
    }
    return replies;
  }

  Future<bool> postReply(
    String name,
    String email,
    String message,
    String chatId,
    String securityKey,
  ) async {
    final queryParameters = {'chatId': chatId};
    var response = await serverDio.post(
      Endpoints.cabSharingChatURL,
      data: {'name': name.toTitleCase(), 'message': message, 'email': email},
      queryParameters: queryParameters,
    );
    var jsonResponse = response.data;
    if (jsonResponse['success'] == true) {
      return true;
    }
    return false;
  }

  Future<bool> createBooking({
    required String postId,
    required String name,
    required String email,
    String? phoneNumber,
  }) async {
    try {
      var response = await serverDio.post(
        Endpoints.cabSharingRequestToJoinURL,
        queryParameters: {'travelPostId': postId},
        data: {
          'email': email,
          'name': name.toTitleCase(),
          if (phoneNumber != null) 'phonenumber': phoneNumber,
        },
      );
      return response.data['success'] as bool;
    } catch (e) {
      return false;
    }
  }

  Future<List<BookingModel>> getPostBookings(String postId) async {
    var response = await serverDio.get(
      Endpoints.cabSharingURL,
      queryParameters: {'postId': postId},
    );
    List<dynamic> list = response.data['bookings'] ?? [];
    return list.map((json) => BookingModel.fromJson(json)).toList();
  }

  Future<bool> acceptBooking({
    required String postId,
    required String bookingId,
  }) async {
    try {
      var response = await serverDio.patch(
        Endpoints.cabSharingAcceptBookingURL(postId, bookingId),
      );
      return response.data['success'] as bool;
    } catch (e) {
      return false;
    }
  }
}
