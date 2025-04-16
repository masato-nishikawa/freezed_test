import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 自作の freezed クラスをインポート
import '../models/user.dart'; 

class UserLoader {
  static Future<List<User>> loadListFromAssets() async {
    final path = ('assets/sample.json');
    final jsonString = await rootBundle.loadString(path);
    final jsonList = json.decode(jsonString) as List<dynamic>;

    return jsonList.map((e) => User.fromJson(e)).toList();
  }
}

final userListProvider = FutureProvider<List<User>>((ref) async {
  return await UserLoader.loadListFromAssets();
});