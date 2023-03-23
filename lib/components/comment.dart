import 'package:dashfix_new/components/user_header.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String username;
  final DateTime datePosted;
  final String message;
  const Comment({
    super.key,
    required this.username,
    required this.message,
    required this.datePosted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserHeader(username: username, datePosted: datePosted),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: Text(message)),
            ],
          ),
        )
      ],
    );
  }
}
