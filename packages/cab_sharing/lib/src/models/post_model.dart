import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';

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

  String getMargin()
  {
    if(margin == 1)
      {
        return "Can leave upto 1 hr early";
      }
    else if(margin == 2)
      {
        return "Can leave upto 2 hr early";
      }
    return "Need to leave at exact time";
  }

  String getTime()
  {
    String answer;
    String time = travelDateTime.substring(11,16);
    int hours = int.parse(time.substring(0,2));
    if(hours == 0)
    {
      answer = '12${time.substring(2)} AM';
    }
    else if(hours < 12)
    {
      answer = '$hours${time.substring(2)} AM';
    }
    else if(hours == 12)
    {
      answer = '$hours${time.substring(2)} PM';
    }
    else
    {
      hours = hours - 12;
      answer = '$hours${time.substring(2)} PM';
    }
    return answer;
  }
}
