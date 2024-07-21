import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perhutaniwisata_app/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Icon(
            Icons.person,
            size: 72,
          ),
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'My Details',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          MyTextBox(
            text: 'ojan',
            sectionName: 'ussername',
            onPressed: () => editField('username'),
          ),
          MyTextBox(
            text: 'empty bio',
            sectionName: 'bio',
            onPressed: () => editField('bio'),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'My Favorite',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
