import 'package:ebook_task/features/admin_panel/presentation/widgets/user_activation_item.dart';
import 'package:flutter/material.dart';

class UserActivationSection extends StatefulWidget {
  const UserActivationSection({super.key});

  @override
  State<UserActivationSection> createState() => _UserActivationSectionState();
}

class _UserActivationSectionState extends State<UserActivationSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ' Users Activation ',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const Divider(
            thickness: 1,
            color: Colors.white60,
            endIndent: 150,
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const UserActivationItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}
