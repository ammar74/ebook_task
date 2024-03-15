import 'package:ebook_task/core/models/user.dart';
import 'package:ebook_task/core/utils/constants.dart';
import 'package:ebook_task/core/widgets/custom_button.dart';
import 'package:ebook_task/core/widgets/show_snackbar.dart';
import 'package:ebook_task/features/admin_panel/presentation/pages/admin_page.dart';
import 'package:ebook_task/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:ebook_task/features/book_management/presentation/pages/books_listView.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String id = 'RegisterScreen';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  UserModel user = UserModel();

  String dropdownvalue = 'User';
  // List of items in our dropdown menu
  var items = [
    'User',
    'Admin',
  ];

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
                  colorBlendMode: BlendMode.color,
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
                      'Register',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Register As..   ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Colors.white,
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                      onTap: () {
                        if (dropdownvalue == 'Admin') {
                          user.isAdmin = true;
                          setState(() {});
                        } else {
                          user.isAdmin = false;
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                CustomButton(
                  buttonText: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        if (user.isAdmin == true) {
                          Navigator.pushNamed(
                              context.mounted as BuildContext, AdminPage.id);
                        } else {
                          Navigator.pushNamed(context.mounted as BuildContext,
                              BooksListViewPage.id);
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context.mounted as BuildContext,
                              'password is too weak.');
                        } else if (e.code == 'Email already in-use') {
                          showSnackBar(context.mounted as BuildContext,
                              'Account already exists.');
                        }
                      } catch (e) {
                        showSnackBar(
                            context.mounted as BuildContext, e.toString());
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account ? ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        ' Sign In !',
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

  Future<void> registerUser() async {
    // ignore: unused_local_variable
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email!, password: user.password!);
  }
}
