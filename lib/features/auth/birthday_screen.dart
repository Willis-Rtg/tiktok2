import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/auth/widgets/next_btn.dart';
import 'package:tiktok2/features/onboarding/interests_screen.dart';
import 'package:tiktok2/utils.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime initialDate = DateTime.now();

  void setDate() {
    var date = initialDate.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: date);
  }

  @override
  void initState() {
    super.initState();
    setDate();
  }

  void onNextTap(BuildContext context) {
    context.push("/interests");
  }

  void _onDateTimeChanged(DateTime dateTime) {
    setState(() {
      initialDate = dateTime;
      setDate();
    });
  }

  @override
  void dispose() {
    _birthdayController.dispose();
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
                "When's your birthday?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Gaps.v8,
              Text(
                "Your birthday won't be shown publicly",
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
                enabled: false,
                style: TextStyle(
                  color: isDarkMode(context) ? Colors.white : Colors.black,
                ),
                controller: _birthdayController,
                decoration: InputDecoration(
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
              NextBtn(
                disabled:
                    _birthdayController.value.text == DateTime.now().toString(),
                text: "Next",
                fn: onNextTap,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 250,
          child: CupertinoDatePicker(
            maximumDate: DateTime.now(),
            initialDateTime: initialDate,
            onDateTimeChanged: _onDateTimeChanged,
            mode: CupertinoDatePickerMode.date,
          ),
        ),
      ),
    );
  }
}
