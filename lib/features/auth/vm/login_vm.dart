import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok2/features/auth/repos/auth_repo.dart';
import 'package:tiktok2/utils.dart';

class LoginVm extends AsyncNotifier<void> {
  late final AuthRepo _repo;

  @override
  Future<void> build() async {
    _repo = ref.read(authRepoProvider);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.login(email, password);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error!);
    } else {
      context.go("/home");
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginVm, void>(() {
  return LoginVm();
});
