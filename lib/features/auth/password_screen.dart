import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/auth/birthday_screen.dart';
import 'package:tiktok2/features/auth/widgets/next_btn.dart';
import 'package:tiktok2/utils.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _password = "";
  bool _obscureText = true;

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => BirthdayScreen()));
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _password = _emailController.text;
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
                "Set your password",
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
                  contentPadding: EdgeInsets.only(left: 4, top: 16),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _emailController.clear();
                        },
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      Gaps.h8,
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  // errorText: _isPasswordValid(),
                  hintText: "Password",
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
                obscureText: _obscureText,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onEditingComplete: _onSubmit,
                // onSubmitted: (value) => _onSubmit(),
              ),
              Gaps.v16,
              Text(
                "Your password must have:",
                style: TextStyle(
                  color:
                      isDarkMode(context)
                          ? Colors.grey.shade300
                          : Colors.black54,
                ),
              ),
              Gaps.v16,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: 16,
                    color:
                        _isPasswordValid()
                            ? Colors.green
                            : Colors.grey.shade500,
                  ),
                  Gaps.h8,
                  Text("8 to 20 characters"),
                ],
              ),
              Gaps.v16,
              NextBtn(
                disabled: !_isPasswordValid(),
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
