import 'package:dashfix/components/appbar.dart';
import 'package:dashfix/components/post.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatelessWidget {
  final Post post;

  const CommentsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          Positioned(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  post,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: List.generate(post.comments.length, (index) {
                          return Column(
                            children: [
                              post.comments[index],
                              index != post.comments.length - 1
                                  ? const Divider()
                                  : const SizedBox(
                                      height: 10,
                                    ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Leave your thoughts here',
                        ),
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('Post'))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
