import 'package:dashfix/pages/posts_page.dart';
import 'package:dashfix/post_bank.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const DashFix());
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
