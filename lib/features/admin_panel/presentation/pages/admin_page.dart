import 'package:ebook_task/core/utils/constants.dart';
import 'package:ebook_task/core/widgets/custom_app_bar.dart';
import 'package:ebook_task/features/admin_panel/presentation/widgets/user_activation_section.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  static String id = 'AdminPage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          children: [
            CustomAppBar(
              title: 'E-Books',
              icon: Icons.logout_outlined,
              onPressed: () {},
            ),
            const UserActivationSection(),
          ],
        ),
      ),
    );
  }
}
