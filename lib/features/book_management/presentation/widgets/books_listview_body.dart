import 'package:ebook_task/features/book_management/presentation/widgets/books_listview_item.dart';
import 'package:flutter/material.dart';

class BooksListViewBody extends StatefulWidget {
  const BooksListViewBody({super.key});

  @override
  State<BooksListViewBody> createState() => _BooksListViewBodyState();
}

class _BooksListViewBodyState extends State<BooksListViewBody> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const BooksListViewItem();
      },
    );
  }
}
