import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok2/features/auth/repos/auth_repo.dart';
import 'package:tiktok2/features/user/models/user_profile_model.dart';
import 'package:tiktok2/features/user/repos/user_repo.dart';

class UsersVM extends AsyncNotifier<UserProfileModel> {
  late final UserRepo _repo;
  late final AuthRepo _authRepo;

  @override
  FutureOr<UserProfileModel> build() async {
    _repo = ref.read(userRepoProvider);
    _authRepo = ref.read(authRepoProvider);
    if (_authRepo.isLoggedin) {
      final profile = await _repo.findProfile(_authRepo.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(
    UserCredential credential,
    DateTime? birthday,
  ) async {
    state = const AsyncValue.loading();
    if (credential.user == null) {
      throw Exception("User is null");
    }
    final profile = UserProfileModel(
      bio: "undefined",
      link: "undefiend",
      birthday: birthday,
      name: credential.user!.displayName ?? "Anon",
      uid: credential.user!.uid,
      email: credential.user!.email ?? "ano@anon.com",
      hasAvatar: false,
    );
    await _repo.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarSet() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _repo.updateProfile(state.value!.uid, {"hasAvatar": true});
  }

  Future<void> updateBio(String bio) async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(bio: bio));
    await _repo.updateProfile(state.value!.uid, {"bio": bio});
  }

  Future<void> updateLink(String link) async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(link: link));
    await _repo.updateProfile(state.value!.uid, {"link": link});
  }
}

final usersVMProvider = AsyncNotifierProvider<UsersVM, UserProfileModel>(
  () => UsersVM(),
);
