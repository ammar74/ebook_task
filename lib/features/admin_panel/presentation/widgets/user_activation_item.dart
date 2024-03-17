import 'package:ebook_task/core/utils/constants.dart';
import 'package:flutter/material.dart';

class UserActivationItem extends StatefulWidget {
  UserActivationItem({super.key, required this.email, required this.isActive});

  String email;
  bool isActive;

  @override
  State<UserActivationItem> createState() => _UserActivationItemState();
}

class _UserActivationItemState extends State<UserActivationItem> {
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
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.email,
              style: const TextStyle(
                fontSize: 16,
                color: kPrimaryColor,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  widget.isActive = true;
                  print('66666 user is activated ${widget.isActive}');
                },
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
