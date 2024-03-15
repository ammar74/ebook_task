import 'package:ebook_task/core/utils/constants.dart';
import 'package:flutter/material.dart';

class BooksListViewPage extends StatelessWidget {
  const BooksListViewPage({super.key});

  static String id = 'BooksListViewScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ' This is the BookListView Page ',
            style: TextStyle(color: Colors.white, fontSize: 24),
          )
        ],
      ),
    );
  }
}
