import 'package:dashfix/components/user_header.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String username;
  final DateTime datePosted;
  final String message;
  final Comment? parent;
  const Comment({
    super.key,
    required this.username,
    required this.message,
    required this.datePosted,
    this.parent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserHeader(username: username, datePosted: datePosted),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 20),
          child: Row(
            children: [
              Text(message),
            ],
          ),
        )
      ],
    );
  }
}
