import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok2/features/auth/models/signup_form_model.dart';
import 'package:tiktok2/features/auth/repos/auth_repo.dart';
import 'package:tiktok2/features/user/vm/users_vm.dart';
import 'package:tiktok2/utils.dart';

class SignupVm extends AsyncNotifier<void> {
  late final AuthRepo _authRepo;

  @override
  Future<void> build() async {
    _authRepo = ref.read(authRepoProvider);
  }

  Future<void> signup(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signupFormProvider);
    final usersProvider = ref.read(usersVMProvider.notifier);
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignup(
        form.email,
        form.password,
      );
      print("userCredential ${userCredential.user}");
      await usersProvider.createProfile(userCredential, form.birthday);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error!);
    } else {
      context.go("/interests");
    }
  }
}

final signupFormProvider = StateProvider((ref) {
  return SignupFormModel(
    email: "",
    password: "",
    username: "",
    birthday: DateTime.now(),
  );
});

final signupProvider = AsyncNotifierProvider<SignupVm, void>(() {
  return SignupVm();
});
