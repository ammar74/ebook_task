import 'package:ebook_task/core/utils/firebase_options.dart';
import 'package:ebook_task/features/admin_panel/presentation/pages/admin_page.dart';
import 'package:ebook_task/features/authentication/presentation/pages/login_page.dart';
import 'package:ebook_task/features/authentication/presentation/pages/registration_page.dart';
import 'package:ebook_task/features/book_management/presentation/pages/books_listView.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EbookApp());
}

class EbookApp extends StatelessWidget {
  const EbookApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        BooksListViewPage.id: (context) => const BooksListViewPage(),
        AdminPage.id: (context) => const AdminPage(),
      },
      initialRoute: LoginPage.id,
    );
  }
}
