import 'package:dashfix/components/appbar.dart';
import 'package:dashfix/components/bottom_navigation_bar.dart';
import 'package:dashfix/pages/filter_sort_menu.dart';
import 'package:dashfix/post_bank.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsPage extends StatelessWidget {
  PostsPage({super.key});

  final drawerItems = ['Account'];

  @override
  Widget build(BuildContext context) {
    var postBank = Provider.of<PostBank>(context);
    if (postBank.isEmpty) {
      postBank.fetch();
    }
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: buildBottomNavigationBar(),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: drawerItems.length,
          itemBuilder: (context, index) => Text(drawerItems[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Card(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      child: Card(
                        child: Row(
                          children: [
                            PopupMenuButton(
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'Distance',
                                  child: Text('Distance'),
                                ),
                                const PopupMenuItem(
                                  value: 'Offer',
                                  child: Text('Offer'),
                                ),
                              ],
                              onSelected: (value) async {
                                if (value == 'Distance') {
                                  postBank.sortByDistance();
                                } else if (value == 'Offer') {
                                  postBank.sortByOffer();
                                }
                              },
                              initialValue: 'Offer',
                              child: TextButton.icon(
                                icon: const Icon(Icons.sort),
                                label: Text(postBank.sortBy.name),
                                onPressed: null,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                postBank.sortDescending =
                                    !postBank.sortDescending;
                                switch (postBank.sortBy) {
                                  case SortBy.Offer:
                                    postBank.sortByOffer();
                                    break;
                                  case SortBy.Distance:
                                    postBank.sortByDistance();
                                    break;
                                  default:
                                    break;
                                }
                              },
                              icon: Icon(
                                postBank.sortDescending
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 4, top: 4, bottom: 4),
                        child: TextButton.icon(
                          icon: const Icon(Icons.filter_list),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SortFilterMenu(),
                              ),
                            );
                          },
                          label: const Text('Filter'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: postBank.posts.length,
                  itemBuilder: (context, index) => postBank.posts[index],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
