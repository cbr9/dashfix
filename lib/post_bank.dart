import 'dart:math';

import 'package:dashfix/components/comment.dart';
import 'package:dashfix/components/post.dart';
import 'package:dashfix/utils.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

enum SortBy { DatePosted, Offer, Distance }

class Sort {
  SortBy by;
  bool descending;
  Sort({required this.by, required this.descending});
}

class PostBank extends ChangeNotifier {
  List<Post> _allPosts = [];
  late List<Post> _shownPosts;
  var _sortDescending = true;
  var _sortBy = SortBy.Offer;

  double _maxOffer = 500;
  double _minOffer = 0;
  double _maxDistance = 5000;

  PostBank.random() {
    _allPosts = List.generate(
      Random().nextInt(20),
      (index) {
        return Post(
          type: PostType.inPerson,
          datePosted: getRandomDateTime(),
          username: faker.internet.userName(),
          message: lipsum.createParagraph(),
          likes: Random().nextInt(10),
          comments: List.generate(
            Random().nextInt(15) + 5,
            (index) => Comment(
              message: lipsum.createSentence(),
              username: faker.internet.userName(),
              datePosted: getRandomDateTime(),
            ),
          ),
          offer: Random().nextInt(500),
          longitude: Random().nextInt(30).toDouble(),
          latitude: Random().nextInt(30).toDouble(),
        );
      },
    );
    _shownPosts = _allPosts;
  }

  PostBank(List<Post> posts) {
    _allPosts = posts;
  }

  double get minOffer {
    return _minOffer;
  }

  set minOffer(value) {
    _minOffer = value;
    notifyListeners();
  }

  double get maxDistance {
    return _maxDistance;
  }

  set maxDistance(value) {
    _maxDistance = value;
    notifyListeners();
  }

  double get maxOffer {
    return _maxOffer;
  }

  set maxOffer(value) {
    _maxOffer = value;
    notifyListeners();
  }

  List<Post> get posts {
    return _shownPosts;
  }

  bool get sortDescending {
    return _sortDescending;
  }

  set sortDescending(value) {
    _sortDescending = value;
    notifyListeners();
  }

  SortBy get sortBy {
    return _sortBy;
  }

  set sortBy(value) {
    _sortBy = value;
    notifyListeners();
  }

  set posts(value) {
    _shownPosts = value;
    notifyListeners();
  }

  List<Post> sortByOffer(bool descending) {
    var copy = [..._allPosts];
    if (descending) {
      copy.sort((a, b) => a.offer.compareTo(b.offer));
    } else {
      copy.sort((a, b) => b.offer.compareTo(a.offer));
    }
    return copy;
  }

  List<Post> sortByDistance(
    bool descending,
    double userLatitude,
    double userLongitude,
  ) {
    var copy = [..._allPosts];
    if (descending) {
      copy.sort((a, b) {
        return Geolocator.distanceBetween(
                  a.latitude!,
                  a.longitude!,
                  userLatitude,
                  userLongitude,
                ) <
                Geolocator.distanceBetween(
                  b.latitude!,
                  b.longitude!,
                  userLatitude,
                  userLongitude,
                )
            ? 1
            : 0;
      });
    } else {
      copy.sort((a, b) {
        return Geolocator.distanceBetween(
                  b.latitude!,
                  b.longitude!,
                  userLatitude,
                  userLongitude,
                ) <
                Geolocator.distanceBetween(
                  a.latitude!,
                  a.longitude!,
                  userLatitude,
                  userLongitude,
                )
            ? 1
            : 0;
      });
    }
    return copy;
  }

  List<Post> sortByDatePosted(bool descending) {
    var copy = [..._allPosts];
    if (descending) {
      copy.sort((a, b) => a.datePosted.compareTo(b.datePosted));
    } else {
      copy.sort((a, b) => b.datePosted.compareTo(a.datePosted));
    }
    return copy;
  }

  List<Post> filterByOffer(double? min, double? max) {
    var copy = [..._allPosts];

    if (min != null) {
      copy.retainWhere((element) => element.offer >= min);
    }
    if (max != null) {
      copy.retainWhere((element) => element.offer <= max);
    }
    return copy;
  }

  List<Post> filterByDistance(
    double max,
    double userLatitude,
    double userLongitude,
  ) {
    var copy = [..._allPosts];
    copy.retainWhere((element) {
      return Geolocator.distanceBetween(
                element.latitude!,
                element.longitude!,
                userLatitude,
                userLongitude,
              ) /
              1000 <=
          max;
    });
    return copy;
  }
}
