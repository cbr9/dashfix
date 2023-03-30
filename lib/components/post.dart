import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashfix/components/comment.dart';
import 'package:dashfix/components/post_metadata.dart';
import 'package:dashfix/components/social_row.dart';
import 'package:dashfix/components/user_header.dart';
import 'package:dashfix/pages/comments_page.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

enum PostType {
  inPerson,
  remote,
  hybrid,
}

const typeString = {
  PostType.inPerson: 'In Person',
  PostType.remote: 'Remote',
  PostType.hybrid: 'Hybrid',
};

enum Status { toDo, workInProgress, done }

// ignore: must_be_immutable
class Post extends StatelessWidget {
  final String id;
  final String username;
  final String description;
  final DateTime datePosted;
  final String status;
  List<Comment> comments = [];
  final DateTime requiredBy;
  final String title;
  final int visualizations;
  final int amount;
  final String type;
  final double? distance;

  Post({
    super.key,
    required this.id,
    required this.type,
    required this.username,
    required this.status,
    required this.description,
    required this.datePosted,
    required this.requiredBy,
    required this.title,
    required this.amount,
    required this.visualizations,
    required this.comments,
    required this.distance,
  });

  Future<List<Comment>> fetchComments() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final commentsSnapshot = await db.collection('comments').get();
    final filteredDocs =
        commentsSnapshot.docs.where((element) => element.get('Task').id == id);

    return Future.wait(
      filteredDocs.map((element) async {
        final DocumentReference associatedUser = element.get('User');
        return Comment(
          datePosted: element.get('PostedOn').toDate(),
          message: element.get('Message'),
          username:
              await associatedUser.get().then((value) => value.get('name')),
          parent: null,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isInPostsPage = ModalRoute.of(context)?.settings.name == '/';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserHeader(
              username: username,
              datePosted: datePosted,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isInPostsPage
                  ? ExpandableText(
                      description,
                      expandText: 'show more',
                      maxLines: 4,
                      collapseText: 'show less',
                    )
                  : Text(description),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  PostMetadataCard(
                    label: 'Offers',
                    value: '$amount€',
                  ),
                  PostMetadataCard(label: type),
                  distance != null
                      ? PostMetadataCard(
                          label: 'Distance',
                          value: '${distance!.toStringAsFixed(2)}km',
                        )
                      : Container()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SocialRow(
                onComment: () {
                  if (isInPostsPage) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsPage(post: this),
                      ),
                    );
                  }
                },
                onShare: () {
                  Share.share('Look what I found!');
                },
                onMessage: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
