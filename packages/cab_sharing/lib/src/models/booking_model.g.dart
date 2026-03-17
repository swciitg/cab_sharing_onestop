// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
  id: json['_id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  phoneNumber: _readPhoneNumber(json, 'phoneNumber') as String?,
  status: json['status'] as String,
);

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'status': instance.status,
    };
