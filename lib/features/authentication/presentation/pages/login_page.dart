import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_task/core/utils/constants.dart';
import 'package:ebook_task/core/widgets/custom_button.dart';
import 'package:ebook_task/core/widgets/show_snackbar.dart';
import 'package:ebook_task/features/admin_panel/presentation/pages/admin_page.dart';
import 'package:ebook_task/features/authentication/data/user_model.dart';
import 'package:ebook_task/features/authentication/presentation/pages/registration_page.dart';
import 'package:ebook_task/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:ebook_task/features/book_management/presentation/pages/books_listView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String id = 'LoginScreen';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  UserModel user = UserModel();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'E-Books',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'pacifico'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                const Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomFormTextField(
                  onChanged: (data) {
                    user.email = data;
                  },
                  hintText: 'Email',
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomFormTextField(
                  obsecureText: true,
                  onChanged: (data) {
                    user.password = data;
                  },
                  hintText: 'Password',
                  icon: const Icon(Icons.password),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                CustomButton(
                  buttonText: 'Login',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      loginUser(user.email!, user.password!);
                    } else {}
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ? ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        ' Register Now !',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "Admin") {
          Navigator.pushNamed(
            context,
            AdminPage.id,
          );
        } else {
          Navigator.pushNamed(context, BooksListViewPage.id);
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      route();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'User not found.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong Password.');
      } else {
        showSnackBar(context, e.toString());
      }
    }
  }
}
