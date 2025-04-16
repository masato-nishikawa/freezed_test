import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
// 自作の freezed クラスをインポート
import 'models/user.dart'; 

void main() async {
  //　非同期処理を main() の中で使いたいときに必要な初期化処理
  WidgetsFlutterBinding.ensureInitialized();
  // 非同期処理の内容でusersを取得して渡す
  final users = await UserLoader.loadListFromAssets();

  runApp(MyApp(users: users));
}

class MyApp extends StatelessWidget {
  final List<User> users;

  const MyApp({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ユーザーリスト')),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text('年齢: ${user.age}'),
            );
          },
        ),
      ),
    );
  }
}

class UserLoader {
  static Future<List<User>> loadListFromAssets() async {
    final path = ('assets/sample.json');
    final jsonString = await rootBundle.loadString(path);
    final jsonList = json.decode(jsonString) as List<dynamic>;

    return jsonList.map((e) => User.fromJson(e)).toList();
  }
}