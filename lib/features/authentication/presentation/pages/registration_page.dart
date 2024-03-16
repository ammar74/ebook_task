import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_task/core/utils/constants.dart';
import 'package:ebook_task/core/widgets/custom_button.dart';
import 'package:ebook_task/core/widgets/show_snackbar.dart';
import 'package:ebook_task/features/authentication/data/user_model.dart';
import 'package:ebook_task/features/authentication/presentation/pages/login_page.dart';
import 'package:ebook_task/features/authentication/presentation/widgets/custom_text_field.dart';
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

  String _currentItemSelected = 'User';
  // List of items in our dropdown menu
  var items = [
    'User',
    'Admin',
  ];
  var role = 'User';

  final _auth = FirebaseAuth.instance;
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
                    DropdownButton<String>(
                      isDense: true,
                      isExpanded: false,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconEnabledColor: Colors.white,
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Colors.white,
                      items: items.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          _currentItemSelected = newValue!;
                          role = newValue;
                        });
                      },
                      value: _currentItemSelected,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                CustomButton(
                  buttonText: 'Register',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      registerUser(user.email!, user.password!, role);

                      setState(() {
                        isLoading = false;
                      });
                      showSnackBar(context.mounted as BuildContext, 'Success.');
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

  Future<void> registerUser(String email, String password, String role) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, role)})
          .catchError((e) {});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context.mounted as BuildContext, 'password is too weak.');
      } else if (e.code == 'Email already in-use') {
        showSnackBar(
            context.mounted as BuildContext, 'Account already exists.');
      }
    } catch (e) {
      showSnackBar(context.mounted as BuildContext, e.toString());
    }
  }

  postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': user.email, 'role': role});
    Navigator.pushNamed(context, LoginPage.id);
  }
}
