import 'package:dashfix/components/appbar.dart';
import 'package:dashfix/components/post.dart';
import 'package:dashfix/post_bank.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortFilterMenu extends StatelessWidget {
  const SortFilterMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var postBank = context.watch<PostBank>();

    return Scaffold(
      appBar: buildAppBar(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final navigator = Navigator.of(context);
          var newPosts = Set<Post>.from(postBank.filterByOffer());
          postBank.posts = newPosts
              .intersection(Set.from(postBank.filterByDistance()))
              .toList();
          navigator.pop();
        },
        label: const Text('Apply'),
        icon: const Icon(Icons.check),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Offer (${postBank.minOffer.toStringAsFixed(0)}-${postBank.maxOffer.toStringAsFixed(0)}):',
                      ),
                      Expanded(
                        child: RangeSlider(
                          divisions: 20,
                          max: 500,
                          min: 0,
                          values:
                              RangeValues(postBank.minOffer, postBank.maxOffer),
                          onChanged: (values) {
                            postBank.minOffer = values.start;
                            postBank.maxOffer = values.end;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Max Distance (${postBank.maxDistance.toStringAsFixed(0)}):',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Slider(
                          divisions: 100,
                          max: 5000,
                          min: 0,
                          value: postBank.maxDistance,
                          onChanged: (value) {
                            postBank.maxDistance = value;
                            print('max distance ${postBank.maxDistance}');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
