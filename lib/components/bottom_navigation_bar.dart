import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar() {
  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
      BottomNavigationBarItem(icon: Icon(Icons.messenger), label: 'Messages'),
    ],
  );
}
