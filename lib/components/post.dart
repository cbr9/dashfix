import 'package:dashfix_new/components/post_metadata.dart';
import 'package:dashfix_new/components/social_row.dart';
import 'package:dashfix_new/components/user_header.dart';
import 'package:dashfix_new/pages/comments_page.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'comment.dart';

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

class Post extends StatelessWidget {
  final String username;
  final String message;
  final DateTime datePosted;
  final List<Comment> comments;
  final int likes;
  final int offer;
  final double? longitude;
  final double? latitude;
  final PostType type;

  const Post({
    super.key,
    required this.type,
    required this.username,
    required this.message,
    required this.datePosted,
    required this.comments,
    required this.likes,
    required this.offer,
    this.longitude,
    this.latitude,
  });

  Future<double> getDistance() async {
    var userLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    final rounded = (Geolocator.distanceBetween(
              latitude!,
              longitude!,
              userLocation.latitude,
              userLocation.altitude,
            ) /
            1000)
        .toStringAsFixed(2);

    return double.parse(rounded);
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
                      message,
                      expandText: 'show more',
                      maxLines: 4,
                      collapseText: 'show less',
                    )
                  : Text(message),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  PostMetadataCard(
                    label: 'Offers',
                    value: '$offer€',
                  ),
                  PostMetadataCard(label: typeString[type]!),
                  (longitude != null && latitude != null)
                      ? FutureBuilder(
                          future: getDistance(),
                          builder: (context, snapshot) => PostMetadataCard(
                            label: 'Distance',
                            value: '${snapshot.data}km',
                          ),
                        )
                      : Container(),
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
                onShare: () {},
                onMessage: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
