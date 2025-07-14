import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok2/features/auth/repos/auth_repo.dart';
import 'package:tiktok2/features/user/vm/users_vm.dart';
import 'package:tiktok2/features/video/models/video_model.dart';
import 'package:tiktok2/features/video/repos/video_repo.dart';

class UploadVM extends AsyncNotifier<void> {
  late final VideoRepo _repo;
  @override
  FutureOr<void> build() {
    _repo = ref.read(videoRepoProvider);
  }

  Future<void> uploadVideo(File file, BuildContext context) async {
    state = const AsyncValue.loading();
    final uid = ref.read(authRepoProvider).user?.uid;
    final userProfile = ref.read(usersVMProvider.notifier).state.value;
    if (uid == null || userProfile == null) {
      throw Exception("User is null");
    }
    try {
      await AsyncValue.guard(() async {
        final task = await _repo.uploadVideo(file, uid);
        if (task.snapshot.state == TaskState.success) {
          final downloadUrl = await task.snapshot.ref.getDownloadURL();
          await _repo.saveVideo(
            VideoModel(
              title: "",
              description: "",
              fileUrl: downloadUrl.toString(),
              thumbnailUrl: "",
              createdAt: DateTime.now(),
              likes: 0,
              comments: 0,
              uid: uid,
              creator: userProfile.name,
            ),
          );
          if (context.mounted) {
            context.pushReplacement("/home");
          }
        }
      });
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

final uploadVMProvider = AsyncNotifierProvider<UploadVM, void>(() {
  return UploadVM();
});
