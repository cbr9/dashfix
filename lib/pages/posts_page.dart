import 'package:dashfix/components/appbar.dart';
import 'package:dashfix/components/bottom_navigation_bar.dart';
import 'package:dashfix/pages/filter_sort_menu.dart';
import 'package:dashfix/post_bank.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class PostsPage extends StatelessWidget {
  PostsPage({super.key});

  final drawerItems = ['Account'];

  @override
  Widget build(BuildContext context) {
    var postBank = context.watch<PostBank>();

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
                                  final location =
                                      await Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.best,
                                  );
                                  postBank.sortBy = SortBy.Distance;
                                  postBank.posts = postBank.sortByDistance(
                                    postBank.sortDescending,
                                    location.altitude,
                                    location.longitude,
                                  );
                                } else if (value == 'Offer') {
                                  postBank.sortBy = SortBy.Offer;
                                  postBank.posts = postBank
                                      .sortByOffer(postBank.sortDescending);
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
                              onPressed: () async {
                                postBank.sortDescending =
                                    !postBank.sortDescending;
                                switch (postBank.sortBy) {
                                  case SortBy.Offer:
                                    postBank.posts = postBank
                                        .sortByOffer(postBank.sortDescending);
                                    break;
                                  case SortBy.Distance:
                                    final location =
                                        await Geolocator.getCurrentPosition(
                                      desiredAccuracy: LocationAccuracy.best,
                                    );
                                    postBank.posts = postBank.sortByDistance(
                                      postBank.sortDescending,
                                      location.latitude,
                                      location.longitude,
                                    );
                                    break;
                                  default:
                                    break;
                                }
                              },
                              icon: Icon(
                                postBank.sortDescending
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
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
