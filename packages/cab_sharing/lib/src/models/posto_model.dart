import 'package:json_annotation/json_annotation.dart';
part 'posto_model.g.dart';

@JsonSerializable()
class PostModel {
  /// The generated code assumes these values exist in JSON.
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String travelDateTime;
  final String to;
  final String from;
  final String note;
  final int margin;
  final String chatId;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  final String? phonenumber;


  const PostModel(
      {required this.name,
      required this.email,
      required this.travelDateTime,
      required this.to,
      required this.from,
      required this.note,
      required this.margin,
      required this.chatId,
      required this.id,
      this.phonenumber});

  /// Connect the generated [_$PostModelFromJson] function to the `fromJson`
  /// factory.
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  /// Connect the generated [_$PostModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
