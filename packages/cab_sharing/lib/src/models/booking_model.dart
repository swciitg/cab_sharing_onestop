import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  @JsonKey(name: '_id')
  final String id;
  final String email;
  final String name;
  @JsonKey(readValue: _readPhoneNumber)
  final String? phoneNumber;
  final String status; // "pending" | "approved"

  const BookingModel({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    required this.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
}

/// Helper to read either `phoneNumber` or `phonenumber` from the backend response
String? _readPhoneNumber(Map<dynamic, dynamic> json, String key) {
  return json['phoneNumber'] as String? ?? json['phonenumber'] as String?;
}
