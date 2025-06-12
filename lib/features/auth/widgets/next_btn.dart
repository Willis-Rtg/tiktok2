import 'package:flutter/material.dart';
import 'package:tiktok2/utils.dart';

class NextBtn extends StatelessWidget {
  const NextBtn({
    super.key,
    required this.disabled,
    required this.text,
    required this.fn,
  });

  final bool disabled;
  final String text;
  final void Function(BuildContext context) fn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => disabled ? null : fn(context),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color:
              disabled
                  ? isDarkMode(context)
                      ? Colors.grey.shade800
                      : Colors.grey.shade400
                  : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 300),
            style: TextStyle(
              color:
                  disabled
                      ? isDarkMode(context)
                          ? Colors.grey.shade400
                          : Colors.black45
                      : Colors.white,
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
