/// chat_box - account
/// Created by xhz on 28/05/2022
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pivot_chat/model/identifable.dart';
import 'package:pivot_chat/model/base_model.dart';

part 'account.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class PCLocalAccount extends PCAccount {
  @JsonKey(name: 'token')
  @HiveField(3)
  String? token;

  @JsonKey(name: 'rem_passwd', defaultValue: 0)
  @HiveField(4)
  int rememberPasswd;

  PCLocalAccount({required super.name, required super.id, required super.email, required this.rememberPasswd});

  factory PCLocalAccount.fromJson(Map<String, dynamic> map) => _$PCLocalAccountFromJson(map);

  @override
  Map<String, dynamic> toJson() => _$PCLocalAccountToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PCGroupAccount extends PCAccount {
  @JsonKey(name: 'type_in_group')
  int standing;

  PCGroupAccount({required super.name, required super.id, required super.email, required this.standing});

  factory PCGroupAccount.fromJson(Map<String, dynamic> map) => _$PCGroupAccountFromJson(map);

  @override
  Map<String, dynamic> toJson() => _$PCGroupAccountToJson(this);
}

@JsonSerializable()
class PCAccount with PCBaseModel, Identifable<int> {
  static const unknownAccount = PCAccount(name: 'unknown', id: -1, email: 'None');
  @override
  @JsonKey(name: 'user_id')
  @HiveField(0)
  final int id;
  @JsonKey(name: 'email')
  @HiveField(1)
  final String email;
  @JsonKey(name: 'user_name')
  @HiveField(2)
  final String name;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool banned = false;

  const PCAccount({
    required this.name,
    required this.id,
    required this.email,
  });

  factory PCAccount.fromJson(Map<String, dynamic> map) => _$PCAccountFromJson(map);

  @override
  Map<String, dynamic> toJson() => _$PCAccountToJson(this);
}
