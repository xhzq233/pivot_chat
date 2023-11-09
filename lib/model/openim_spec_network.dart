/// pivot_chat - openim_spec_network
/// Created by xhz on 11/8/23
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:framework/logger.dart';
import 'package:json_annotation/json_annotation.dart';

part 'openim_spec_network.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class OpenIMBaseResp<T> {
  @JsonKey(name: 'errCode')
  final int code;
  @JsonKey(name: 'errMsg')
  final String msg;
  @JsonKey(name: 'errDlt')
  final String dlt;
  @JsonKey(name: 'data')
  final T? data;

  const OpenIMBaseResp({
    required this.code,
    required this.msg,
    required this.dlt,
    this.data,
  });

  factory OpenIMBaseResp.fromJson(Map<String, dynamic> map, T Function(Object? json) fromJsonT) =>
      _$OpenIMBaseRespFromJson(map, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$OpenIMBaseRespToJson(this, toJsonT);
}

extension OpenIMRespCheck on OpenIMBaseResp<dynamic>? {
  // 0	✅ 没有错误
// 500	🚨 服务器内部错误，通常为内部网络错误，需要检查服务器各节点运行是否正常
// 1001	❌ 参数错误，需检查 body 参数及 header 参数是否正确
// 1002	🚫 权限不足，通常为 header 参数中携带 token 不正确或权限越级操作
// 1003	💽 数据库主键重复
// 1004	🚫 数据库记录未找到
// 1101	🚫 用户 ID 不存在
// 1102	🚫 用户已经注册
// 1201	🚫 群不存在
// 1202	🚫 群已存在
// 1203	🚫 用户不在群组中
// 1204	🚫 群组已解散
// 1205	🚫 不支持的群类型
// 1206	🚫 群申请已被处理，不需重复处理
// 1301	🚫 不能添加自己为好友
// 1302	🚫 已被对方拉黑
// 1303	🚫 对方不是自己的好友
// 1304	🚫 已是好友关系，不需重复申请
// 1401	🚫 消息已读功能被关闭
// 1402	🚫 你已被禁言，不能在群里发言
// 1403	🚫 群已被禁言，不能发言
// 1404	🚫 该消息已被撤回
// 1405	🚫 授权过期
// 1501	🚫 token 已过期
// 1502	🚫 token 无效
// 1503	🚫 token 格式错误
// 1504	🚫 token 还未生效
// 1505	🚫 未知 token 错误
// 1506	🚫 被踢出的 token，无效
// 1507	🚫 token 不存在
// 1601	🚫 连接数超过网关最大限制
// 1602	🚫 连接握手参数错误
// 1701	🚫 文件上传过期

  bool check() {
    final t = this;
    if (t == null) return false;
    if (t.code == 0) {
      return true;
    }
    SmartDialog.showToast(t.msg);
    logger.e('NETWORK', 'code: ${t.code}, msg: ${t.msg}, dlt: ${t.dlt}');
    return false;
  }
}

//   "data": {
//     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiJvcGVuSU1BZG1pbiIsIlBsYXRmb3JtSUQiOjEsImV4cCI6MTY5Njc1NDgwNSwibmJmIjoxNjg4OTc4NTA1LCJpYXQiOjE2ODg5Nzg4MDV9.SAu86X3PzfYjtjBeYA4vZefNr1IiFKRgg12FeiXSm14",
//     "expireTimeSeconds": 7776000
//   }
@JsonSerializable()
class OpenIMTokenResp {
  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'expireTimeSeconds')
  final int expireTimeSeconds;

  const OpenIMTokenResp({
    required this.token,
    required this.expireTimeSeconds,
  });

  factory OpenIMTokenResp.fromJson(Map<String, dynamic> map) => _$OpenIMTokenRespFromJson(map);

  Map<String, dynamic> toJson() => _$OpenIMTokenRespToJson(this);
}
