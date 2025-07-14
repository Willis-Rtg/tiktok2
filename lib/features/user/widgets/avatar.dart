import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok2/features/auth/repos/auth_repo.dart';
import 'package:tiktok2/features/user/vm/avatar_vm.dart';

class Avatar extends ConsumerWidget {
  const Avatar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  });

  final String name;
  final bool hasAvatar;
  final String uid;

  Future<void> onAvatarTap(WidgetRef ref) async {
    XFile? xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile == null) return;
    final file = File(xfile.path);
    ref.read(avatarVmProvider.notifier).setAvatar(file);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarVmProvider).isLoading;
    return GestureDetector(
      onTap: () => onAvatarTap(ref),
      child:
          isLoading
              ? Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const CircularProgressIndicator.adaptive(),
              )
              : CircleAvatar(
                radius: 52,
                foregroundImage:
                    hasAvatar
                        ? NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/tiktok2-willis-abc.firebasestorage.app/o/avatars%2F$uid?alt=media&token=9bde7d23-6d77-4990-9cfb-0a78f760b9b0&time=${DateTime.now().toString()}",
                        )
                        : null,
                child: Text(name),
              ),
    );
  }
}
