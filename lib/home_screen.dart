import 'package:ebook_task/core/utils/constants.dart';
import 'package:ebook_task/core/widgets/custom_button.dart';
import 'package:ebook_task/features/admin_panel/presentation/pages/admin_page.dart';
import 'package:ebook_task/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String id = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 100,
              colorBlendMode: BlendMode.color,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to E-Books',
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
                  'Continue As..',
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
            CustomButton(
              buttonText: 'Admin',
              onTap: () => Navigator.pushNamed(context, AdminPage.id),
            ),
            CustomButton(
              buttonText: 'User',
              onTap: () => Navigator.pushNamed(context, LoginPage.id),
            ),
          ],
        ),
      ),
    );
  }
}
