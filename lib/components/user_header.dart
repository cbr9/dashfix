import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({
    super.key,
    required this.username,
    required this.datePosted,
  });

  final String username;
  final DateTime datePosted;

  @override
  Widget build(BuildContext context) {
    final day = datePosted.day.toString().padLeft(2, '0');
    final month = datePosted.month.toString().padLeft(2, '0');
    final minute = datePosted.minute.toString().padLeft(2, '0');
    final hour = datePosted.hour.toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.account_box),
            onPressed: () {},
          ),
          const SizedBox(
            width: 10,
          ),
          Text(username),
          const SizedBox(
            width: 5,
          ),
          Text(
            'on $day/$month/${datePosted.year}',
          ),
          const SizedBox(
            width: 5,
          ),
          Text('at $hour:$minute')
        ],
      ),
    );
  }
}
