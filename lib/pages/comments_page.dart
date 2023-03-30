import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashfix/components/appbar.dart';
import 'package:dashfix/components/comment.dart';
import 'package:dashfix/components/post.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  final Post post;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CommentsPage({super.key, required this.post});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  String newComment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () {
          return () async {
            widget.post.comments = await widget.post.fetchComments();
            return widget.post.comments;
          }();
        },
        child: Column(
          children: [
            widget.post,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: FutureBuilder(
                    future: widget.post.fetchComments(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        widget.post.comments = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.post.comments.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                widget.post.comments[index],
                                index != widget.post.comments.length - 1
                                    ? const Divider()
                                    : const SizedBox(
                                        height: 10,
                                      ),
                              ],
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.account_box_rounded),
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    width: 20,
                    indent: 10,
                    endIndent: 11,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      cursorColor: Colors.red,
                      minLines: 1,
                      maxLines: 4,
                      onChanged: (value) {
                        newComment = value;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Leave your thoughts here',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Post'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
