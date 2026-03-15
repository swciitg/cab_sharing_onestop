import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  @JsonKey(name: '_id')
  final String id;
  final String email;
  final String name;
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
