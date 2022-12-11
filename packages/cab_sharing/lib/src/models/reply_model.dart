import 'package:json_annotation/json_annotation.dart';

part 'reply_model.g.dart';

@JsonSerializable()
class ReplyModel {
  @JsonKey(name:'_id')
  String replyid;
  String name;
  String message;
  @JsonKey(defaultValue: "")
  String time;

  ReplyModel({
    required this.replyid,
    required this.name,
    required this.message,
    required this.time,
  });
  factory ReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyModelToJson(this);
}
