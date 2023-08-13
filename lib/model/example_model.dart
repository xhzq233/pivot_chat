import 'package:json_annotation/json_annotation.dart';
import 'package:pivot_chat/model/base_model.dart';

part 'example_model.g.dart';

/*
```shell
dart pub run build_runner build
```
 */
@JsonSerializable()
class PCExampleModel with PCBaseModel {
  PCExampleModel(this.hello);

  @JsonKey(defaultValue: 'world')
  final String hello;

  factory PCExampleModel.fromJson(Map<String, dynamic> json) =>
      _$PCExampleModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PCExampleModelToJson(this);
}
