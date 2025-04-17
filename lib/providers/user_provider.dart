import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 自作の freezed クラスをインポート
import '../models/user.dart'; 

class UserListNotifier extends StateNotifier<List<User>> {
  //「コンストラクタ」と「初期化処理」を組み合わせた記述
  UserListNotifier() : super([]) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    final jsonString = await rootBundle.loadString('assets/sample.json');
    final jsonList = json.decode(jsonString) as List<dynamic>;
    state = jsonList.map((e) => User.fromJson(e)).toList();
  }

  // 内容をランダムにシャッフルして差し替える
  void shuffleUsers() {
    final newList = [...state]..shuffle();
    state = newList;
  }

  // ユーザーを追加
  void addDummyUser() {
    final dummy = User(name: '新しいユーザー', id: '999', age: 99);
    state = [...state, dummy];
  }

  // 全員の年齢を1増やす
  void incrementAges() {
      state = state
          .map((user) => user.copyWith(age: user.age + 1))
          .toList();
    }

  void incrementIdAge() {
    state = state.map((user) {
      if (user.name == '山田太郎') {
        return user.copyWith(age: user.age + 1);
      } else {
        return user;
      }
    }).toList();
  }
}

final userListProvider =
    StateNotifierProvider<UserListNotifier, List<User>>((ref) {
  return UserListNotifier();
});