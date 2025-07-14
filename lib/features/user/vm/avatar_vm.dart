import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok2/features/auth/repos/auth_repo.dart';
import 'package:tiktok2/features/user/repos/user_repo.dart';
import 'package:tiktok2/features/user/vm/users_vm.dart';

class AvatarVm extends AsyncNotifier<void> {
  late final UserRepo _userRepo;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void build() {
    _userRepo = ref.read(userRepoProvider);
    Future.delayed(Duration(seconds: 3));
  }

  Future<void> setAvatar(File file) async {
    state = const AsyncValue.loading();
    final filename = ref.read(authRepoProvider).user?.uid;
    state = await AsyncValue.guard(() async {
      await _userRepo.setAvatar(filename!, file);
      await ref.read(usersVMProvider.notifier).onAvatarSet();
    });
  }
}

final avatarVmProvider = AsyncNotifierProvider<AvatarVm, void>(() {
  return AvatarVm();
});
