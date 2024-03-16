import 'package:ebook_task/core/utils/constants.dart';
import 'package:ebook_task/features/book_management/presentation/widgets/books_listview_body.dart';
import 'package:flutter/material.dart';

class BooksListViewPage extends StatefulWidget {
  const BooksListViewPage({super.key});

  static String id = 'BooksListViewScreen';

  @override
  State<BooksListViewPage> createState() => _BooksListViewPageState();
}

class _BooksListViewPageState extends State<BooksListViewPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BooksListViewBody(),
        ],
      ),
    );
  }
}
