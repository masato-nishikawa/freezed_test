import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 自作の freezed クラスをインポート
import 'models/user.dart'; 
import 'providers/user_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp()
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<User>> userList = ref.watch(userListProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ユーザーリスト')),
        body: userList.when(
          data: (users) => ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text('年齢: ${user.age}'),
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('エラー: $error')),
        ),
      ),
    );
  }
}