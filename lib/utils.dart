import 'dart:math';

import 'package:random_date/random_date.dart';

DateTime getRandomDateTime() {
  final year = DateTime.now().year;
  final rng = RandomDate.withRange(year, year);
  final hour = Random().nextInt(24);
  final minute = Random().nextInt(60);
  final second = Random().nextInt(60);
  return DateTimeCopyWith(rng.random())
      .copyWith(hour: hour, minute: minute, second: second);
}
