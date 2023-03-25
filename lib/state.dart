import 'package:dashfix/post_bank.dart';
import 'package:flutter/material.dart';

class GlobalStore extends ChangeNotifier {
  late var postBank = PostBank.random();
}
