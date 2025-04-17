import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 自作の freezed クラスをインポート
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
    final users = ref.watch(userListProvider);
    final notifier = ref.read(userListProvider.notifier);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ユーザーリスト')),
        body: users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text('年齢: ${user.age}'),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // ここでユーザーリストを操作
            //notifier.shuffleUsers();
            // notifier.addDummyUser();
            notifier.incrementAges();
          },
          child: const Icon(Icons.swap_vert),
        ),
      ),
    );
  }
}