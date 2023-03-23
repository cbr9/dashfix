import 'package:flutter/material.dart';

class PostMetadataCard extends StatelessWidget {
  final String? value;
  final String label;

  const PostMetadataCard({super.key, required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (value != null)
            ? Text(
                '$label: $value',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
      ),
    );
  }
}
