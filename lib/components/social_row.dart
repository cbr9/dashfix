import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ShareButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.share),
    );
  }
}

class CommentButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CommentButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.comment_bank),
    );
  }
}

class MessageButton extends StatelessWidget {
  final VoidCallback onPressed;
  const MessageButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.message),
    );
  }
}

class SocialRow extends StatelessWidget {
  final VoidCallback onShare;
  final VoidCallback onComment;
  final VoidCallback onMessage;
  const SocialRow({
    super.key,
    required this.onShare,
    required this.onComment,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      children: [
        CommentButton(
          onPressed: onComment,
        ),
        ShareButton(
          onPressed: onShare,
        ),
        MessageButton(
          onPressed: onMessage,
        ),
      ],
    );
  }
}
