import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashfix/components/post.dart';
import 'package:dashfix/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

enum SortBy { datePosted, offer, distance }

class Sort {
  SortBy by;
  bool descending;
  Sort({required this.by, required this.descending});
}

class PostBank extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late List<Post> _allPosts = [];
  late List<Post> _shownPosts = [];
  var _sortDescending = true;
  var _sortBy = SortBy.offer;

  double _maxOffer = 500;
  double _minOffer = 0;
  double _maxDistance = 5000;

  Future<void> refresh() async {
    _allPosts = [];
    _shownPosts = [];

    final tasksSnapshot = await _db.collection('Tasks').get();
    final position = await getUserLocation();
    final posts = tasksSnapshot.docs.map((task) async {
      double? latitude;
      double? longitude;
      double? distance;
      if (task.data().containsKey('Location')) {
        latitude = task.get('Location').latitude;
        longitude = task.get('Location').longitude;
        distance = Geolocator.distanceBetween(
              latitude!,
              longitude!,
              position.latitude,
              position.longitude,
            ) /
            1000;
      }
      DocumentReference user = task.get('UserID');

      return Post(
        amount: task.get('Amount'),
        id: task.id,
        comments: const [],
        datePosted: task.get('PostedOn').toDate(),
        username: await user.get().then((value) => value.get('name')),
        description: task.get('Description'),
        requiredBy: task.get('RequiredBy').toDate(),
        status: task.get('Status'),
        title: task.get('Title'),
        type: task.get('Type'),
        visualizations: 0,
        distance: distance,
      );
    }).toList();
    _allPosts = await Future.wait(posts);
    _shownPosts = [..._allPosts];
    notifyListeners();
  }

  bool get isEmpty {
    return _allPosts.isEmpty;
  }

  PostBank();

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

  sortByOffer() {
    var copy = [..._shownPosts];
    if (_sortDescending) {
      copy.sort((a, b) => a.amount.compareTo(b.amount));
    } else {
      copy.sort((a, b) => b.amount.compareTo(a.amount));
    }
    posts = copy;
    sortBy = SortBy.offer;
  }

  sortByDistance() {
    var copy = [..._shownPosts];
    if (_sortDescending) {
      copy.sort((a, b) {
        if (a.distance != null && b.distance != null) {
          return a.distance!.compareTo(b.distance!);
        } else {
          return 1;
        }
      });
    } else {
      copy.sort((a, b) {
        if (a.distance != null && b.distance != null) {
          return b.distance!.compareTo(a.distance!);
        } else {
          return 1;
        }
      });
    }
    posts = copy;
    sortBy = SortBy.distance;
  }

  sortByDatePosted(bool descending) {
    var copy = [..._shownPosts];
    if (descending) {
      copy.sort((a, b) => a.datePosted.compareTo(b.datePosted));
    } else {
      copy.sort((a, b) => b.datePosted.compareTo(a.datePosted));
    }
    posts = copy;
    sortBy = SortBy.datePosted;
  }

  List<Post> filterByOffer() {
    return _allPosts
        .where(
          (element) =>
              element.amount >= _minOffer && element.amount <= _maxOffer,
        )
        .toList();
  }

  List<Post> filterByDistance() {
    return _allPosts
        .where(
          (element) =>
              element.distance != null && element.distance! <= _maxDistance,
        )
        .toList();
  }
}
