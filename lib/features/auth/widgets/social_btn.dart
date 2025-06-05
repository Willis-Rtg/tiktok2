import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/constants/sizes.dart';

class SocialBtn extends StatelessWidget {
  final String text;
  final Color color;
  final Function() onTap;
  final IconData icon;

  const SocialBtn({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size14,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(alignment: Alignment.centerLeft, child: FaIcon(icon)),
            Gaps.h10,
            Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
