import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok2/features/auth/repos/auth_repo.dart';
import 'package:tiktok2/utils.dart';

class SocialAuthVm extends AsyncNotifier<void> {
  late final AuthRepo _authRepo;

  @override
  Future<void> build() async {
    _authRepo = ref.read(authRepoProvider);
  }

  Future<void> githubLogin(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _authRepo.githubLogin();
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error!);
    } else {
      context.go("/home");
    }
  }
}

final socialAuthProvider = AsyncNotifierProvider<SocialAuthVm, void>(() {
  return SocialAuthVm();
});
