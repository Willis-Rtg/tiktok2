import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/auth/widgets/next_btn.dart';
import 'package:tiktok2/features/onboarding/interests_screen.dart';

class LoginSubmitScreen extends StatefulWidget {
  const LoginSubmitScreen({super.key});

  @override
  State<LoginSubmitScreen> createState() => _LoginSubmitScreenState();
}

class _LoginSubmitScreenState extends State<LoginSubmitScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.push("/interests");
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
                disabled: false,
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
