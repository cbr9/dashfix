import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashfix/pages/posts_page.dart';
import 'package:dashfix/post_bank.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const DashFix());
  FirebaseFirestore db = FirebaseFirestore.instance;
  final users = db.collection('users');
  print(users);
}

class DashFix extends StatelessWidget {
  const DashFix({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostBank.random(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DashFix',
        theme: ThemeData(
          colorSchemeSeed: Colors.blueGrey,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {'/': (context) => PostsPage()},
      ),
    );
  }
}
