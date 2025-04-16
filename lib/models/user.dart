import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart'; // JSONサポートしたい場合のみ

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    @Default(0) int age,
  }) = _User;

  // JSONサポートする場合（任意）
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}