import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/auth/models/signup_form_model.dart';
import 'package:tiktok2/features/auth/vm/signup_vm.dart';
import 'package:tiktok2/features/auth/widgets/next_btn.dart';
import 'package:tiktok2/utils.dart';

class EmailScreenArgs {
  final String username;

  const EmailScreenArgs({required this.username});
}

class EamilScreen extends ConsumerStatefulWidget {
  const EamilScreen({super.key, required this.args});

  final EmailScreenArgs args;

  @override
  ConsumerState<EamilScreen> createState() => _EamilScreenState();
}

class _EamilScreenState extends ConsumerState<EamilScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _email = "";

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_email)) {
      return "Not valid";
    }
    return null;
  }

  void _onSubmit() {
    final state = ref.read(signupFormProvider);
    ref.read(signupFormProvider.notifier).state = SignupFormModel(
      email: _email,
      password: state.password,
      username: widget.args.username,
      birthday: state.birthday,
    );
    if (_email.isEmpty || _isEmailValid() != null) return;
    context.push("/auth/password");
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.args.username);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text("Sign up"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What is your email?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Gaps.v8,
              Text(
                "You can always change this later.",
                style: TextStyle(
                  fontSize: 14,
                  color:
                      isDarkMode(context)
                          ? Colors.grey.shade300
                          : Colors.black54,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  errorText: _isEmailValid(),
                  hintText: "abcd@example.com",
                  hintStyle: TextStyle(
                    color:
                        isDarkMode(context)
                            ? Colors.grey.shade300
                            : Colors.black54,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onEditingComplete: _onSubmit,
                // onSubmitted: (value) => _onSubmit(),
              ),
              Gaps.v16,
              NextBtn(
                disabled: _email.isEmpty || _isEmailValid() != null,
                text: "Next",
                fn: (context) {
                  _onSubmit();
                },
              ),
              // TextButton(onPressed: () {}, child: Text("Hello")),
            ],
          ),
        ),
      ),
    );
  }
}
