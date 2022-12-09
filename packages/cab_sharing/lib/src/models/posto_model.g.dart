// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      name: json['name'] as String,
      email: json['email'] as String,
      travelDateTime: json['travelDateTime'] as String,
      to: json['to'] as String,
      from: json['from'] as String,
      note: json['note'] as String,
      margin: json['margin'] as int,
      chatId: json['chatId'] as String,
      id: json['_id'] as String,
      phonenumber: (json['phonenumber'] == null)? null :json['phonenumber']  as String?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'travelDateTime': instance.travelDateTime,
      'to': instance.to,
      'from': instance.from,
      'note': instance.note,
      'margin': instance.margin,
      'chatId': instance.chatId,
      'phonenumber': instance.phonenumber,
    };
