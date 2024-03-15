import 'package:ebook_task/core/utils/constants.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  static String id = 'AdminPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ' This is the Admin Page ',
            style: TextStyle(color: Colors.white, fontSize: 24),
          )
        ],
      ),
    );
  }
}
