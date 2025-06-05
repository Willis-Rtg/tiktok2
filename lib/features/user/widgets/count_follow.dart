import 'package:flutter/material.dart';
import 'package:tiktok2/constants/gaps.dart';

class CountFollow extends StatelessWidget {
  final String count;
  final String label;

  const CountFollow({super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Gaps.h4,
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
