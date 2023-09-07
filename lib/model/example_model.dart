import 'package:framework/list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example_model.g.dart';

/*
```shell
dart pub run build_runner build
```
 */
@JsonSerializable()
class PCExampleModel extends BaseItemModel<int> {
  const PCExampleModel(this.hello);

  @JsonKey(defaultValue: 'world')
  final String hello;

  factory PCExampleModel.fromJson(Map<String, dynamic> json) => _$PCExampleModelFromJson(json);

  Map<String, dynamic> toJson() => _$PCExampleModelToJson(this);

  @override
  int get key => hello.hashCode;
}
