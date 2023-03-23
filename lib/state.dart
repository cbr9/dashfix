import 'package:dashfix_new/post_bank.dart';
import 'package:flutter/material.dart';

class GlobalStore extends ChangeNotifier {
  late var postBank = PostBank.random();
}
