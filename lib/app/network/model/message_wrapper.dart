
import 'dart:convert';

class MessageWrapper{
  int conversationType;
  dynamic data;

  MessageWrapper({
    required this.conversationType,
    required this.data
  });

  factory MessageWrapper.fromJson(Map<String, dynamic> json) => MessageWrapper(
    conversationType: json["conversationType"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "conversationType": conversationType,
    "data": data,
  };

  String toJsonString() {
    return jsonEncode(toJson());
  }
}