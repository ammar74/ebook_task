import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_task/features/admin_panel/presentation/widgets/user_activation_item.dart';
import 'package:flutter/material.dart';

class UserActivationSection extends StatefulWidget {
  const UserActivationSection({Key? key}) : super(key: key);

  @override
  State<UserActivationSection> createState() => _UserActivationSectionState();
}

class _UserActivationSectionState extends State<UserActivationSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        height: 400,
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
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show a loading indicator while waiting
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No users found'));
                  }
                  final filteredDocs = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final role = data['role'] as String?;
                    return role != 'Admin';
                  }).toList();
                  print(' 55555 ${filteredDocs.toString()}');
                  return ListView(
                    children: filteredDocs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      print('${data['isActive']}');
                      return UserActivationItem(
                        email: data['email'],
                        isActive: data['isActive'],
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
