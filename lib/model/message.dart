/// chat_box - message
/// Created by xhz on 23/04/2022
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pivot_chat/model/identifable.dart';

part 'message.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class PCMessage with Identifable<String> {
  @override
  String get id => '$groupID-$msgSeq';

  @JsonKey(name: 'seq')
  @HiveField(0)
  final int msgSeq;

  @JsonKey(name: 'group_id')
  @HiveField(1)
  final int groupID;

  @JsonKey(name: 'sender_id')
  @HiveField(2)
  final int senderID;

  @JsonKey(name: 'type')
  @HiveField(3)
  final int type;

  @JsonKey(name: 'data')
  @HiveField(4)
  final String content;

  @JsonKey(name: 'time', fromJson: DateTime.parse)
  @HiveField(5)
  final DateTime time;

  @JsonKey(name: 'reply_to')
  @HiveField(6)
  final int repTo;

  static const kMTImage = 1;
  static const kMTPlain = 0;

  //内部使用
  static const kMTHint = 11;

  const PCMessage(
    this.msgSeq,
    this.content,
    this.time,
    this.groupID,
    this.senderID,
    this.type,
    this.repTo,
  );

  static final nothingHere = PCMessage(0, 'nothing here',
      DateTime.fromMillisecondsSinceEpoch(0), 0, 0, kMTPlain, 0);

  factory PCMessage.fromJson(Map<String, dynamic> json) =>
      _$PCMessageFromJson(json);

  //sender服务器那边有，time和id在存数据库时提供
  Map<String, dynamic> toJson() => _$PCMessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PCMessagesChunk {
  static const orientationHistory = 1;
  static const orientationNewMessage = 0;

  const PCMessagesChunk({
    required this.content,
    required this.groupID,
    required this.userID,
    required this.maxSeq,
  });

  @JsonKey(name: 'data')
  final List<PCMessage> content;

  @JsonKey(name: 'group_id')
  final int groupID;

  @JsonKey(name: 'user_id')
  final int userID;

  @JsonKey(name: 'max_seq')
  final int maxSeq;

  factory PCMessagesChunk.fromJson(Map<String, dynamic> json) =>
      _$PCMessagesChunkFromJson(json);

  //sender服务器那边有，time和id在存数据库时提供
  Map<String, dynamic> toJson() => _$PCMessagesChunkToJson(this);
}
