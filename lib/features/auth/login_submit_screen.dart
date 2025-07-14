import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/auth/vm/login_vm.dart';
import 'package:tiktok2/features/auth/widgets/next_btn.dart';

class LoginSubmitScreen extends ConsumerStatefulWidget {
  const LoginSubmitScreen({super.key});

  @override
  ConsumerState<LoginSubmitScreen> createState() => _LoginSubmitScreenState();
}

class _LoginSubmitScreenState extends ConsumerState<LoginSubmitScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref
          .read(loginProvider.notifier)
          .login(formData["email"]!, formData["password"]!, context);
      // context.push("/interests");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gaps.v24,
              TextFormField(
                decoration: InputDecoration(hintText: "Email"),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  formData["email"] = value!;
                },
              ),
              Gaps.v16,
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: "Password"),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  formData["password"] = value!;
                },
              ),
              Gaps.v24,
              NextBtn(
                disabled: ref.watch(loginProvider).isLoading,
                text: "Login",
                fn: (context) {
                  _onSubmitTap();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
