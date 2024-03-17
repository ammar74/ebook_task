import 'package:ebook_task/features/book_management/data/models/book_model.dart';

abstract class BookRepo {
  Future<List<BookModel>> fetchBooksFromFirebase();
}
