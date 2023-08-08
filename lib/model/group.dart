/// chat_box - group
/// Created by xhz on 28/05/2022

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pivot_chat/model/identifable.dart';

part 'group.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class PCGroup with Identifable<int> {
  @override
  @JsonKey(name: 'group_id')
  @HiveField(0)
  final int id;

  @JsonKey(name: 'owner_id')
  @HiveField(1)
  final int ownerID;

  @JsonKey(name: 'name')
  @HiveField(2)
  final String name;

  @JsonKey(name: 'introduction')
  @HiveField(3)
  final String introduction;

  @JsonKey(name: 'user_num')
  @HiveField(4)
  final int userNum;

  @JsonKey(name: 'create_time', fromJson: DateTime.parse)
  @HiveField(5)
  final DateTime createTime;

  @JsonKey(name: 'max_seq', defaultValue: 0)
  @HiveField(6)
  final int maxSeq;

  const PCGroup(
    this.id,
    this.name,
    this.introduction,
    this.userNum,
    this.createTime,
    this.ownerID,
    this.maxSeq,
  );

  factory PCGroup.fromJson(Map<String, dynamic> json) => _$PCGroupFromJson(json);

  Map<String, dynamic> toJson() => _$PCGroupToJson(this);
}
