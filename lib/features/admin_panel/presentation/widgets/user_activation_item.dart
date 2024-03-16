import 'package:ebook_task/core/utils/constants.dart';
import 'package:flutter/material.dart';

class UserActivationItem extends StatefulWidget {
  const UserActivationItem({super.key});

  @override
  State<UserActivationItem> createState() => _UserActivationItemState();
}

class _UserActivationItemState extends State<UserActivationItem> {
  // var userEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'userEmail',
              style: TextStyle(
                fontSize: 16,
                color: kPrimaryColor,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.check_box,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.disabled_by_default,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
