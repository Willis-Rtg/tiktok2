import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoBtn extends StatelessWidget {
  const VideoBtn({
    super.key,
    required this.icon,
    required this.onTap,
    required this.text,
  });

  final IconData icon;
  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          FaIcon(icon, color: Colors.white, size: 24),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
