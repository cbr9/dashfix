import 'package:flutter/material.dart';

buildAppBar(BuildContext context) {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          child: IconButton(
            icon: const Icon(Icons.account_box),
            onPressed: () {},
          ),
        ),
      )
    ],
    title: Text(
      'DashFix',
      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
    ),
    backgroundColor: Theme.of(context).colorScheme.primary,
  );
}
