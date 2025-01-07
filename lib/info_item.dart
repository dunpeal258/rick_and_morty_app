import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const InfoItem({required this.title, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70),
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}