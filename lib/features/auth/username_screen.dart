import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/auth/email_screen.dart';
import 'package:tiktok2/features/auth/widgets/next_btn.dart';
import 'package:tiktok2/utils.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  void onNextTap(BuildContext context) {
    if (_username.isEmpty) return;
    context.push("/auth/email", extra: EmailScreenArgs(username: _username));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                "Create username",
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
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
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
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onEditingComplete: () {},
              ),
              Gaps.v16,
              NextBtn(disabled: _username.isEmpty, text: "Next", fn: onNextTap),
            ],
          ),
        ),
      ),
    );
  }
}
