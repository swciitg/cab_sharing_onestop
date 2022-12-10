// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyModel _$ReplyModelFromJson(Map<String, dynamic> json) => ReplyModel(
      replyid: json['_id'] as String,
      name: json['name'] as String,
      message: json['message'] as String,
      time: json['time'] as String? ?? '',
    );

Map<String, dynamic> _$ReplyModelToJson(ReplyModel instance) =>
    <String, dynamic>{
      '_id': instance.replyid,
      'name': instance.name,
      'message': instance.message,
      'time': instance.time,
    };
