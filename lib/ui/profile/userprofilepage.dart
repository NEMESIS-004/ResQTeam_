import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<UserProfilePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return UserProfileView(
                name: snapshot.data!.data()!['name'],
                email: snapshot.data!.data()!['email'],
                post: snapshot.data!.data()!['role'],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

class UserProfileView extends StatefulWidget {
  UserProfileView({
    super.key,
    required this.name,
    required this.email,
    required this.post,
  });
  String name;
  String email;
  String post;
  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0), // Add rounded corners
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/user.png"),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        // Customize text color
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.post,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.email,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(
            height: 8,
          ),
          TextButton(
            onPressed: () {
              // Add action for "Home" button
            },
            child: const ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
          ),
          TextButton(
            onPressed: () {
              // Add action for "Phone" button
            },
            child: const ListTile(
              leading: Icon(Icons.phone),
              title: Text("Helplines"),
            ),
          ),
          TextButton(
            onPressed: () {
              // Add action for "Language" button
            },
            child: const ListTile(
              leading: Icon(Icons.translate),
              title: Text("Language"),
            ),
          ),
          TextButton(
            onPressed: () {
              // Add action for "Do's and Don't" button
            },
            child: const ListTile(
              leading: Icon(Icons.cancel),
              title: Text("Do's and Don't"),
            ),
          ),
          TextButton(
            onPressed: () {
              // Add action for "Sign out" button
            },
            child: const ListTile(
              leading: Icon(Icons.exit_to_app), // Change the icon
              title: Text("Sign out"),
            ),
          ),
          TextButton(
            onPressed: () {
              // Add action for "Delete Account" button
            },
            child: const ListTile(
              leading: Icon(Icons.delete), // Change the icon
              title: Text("Delete Account"),
            ),
          ),
        ],
      ),
    );
  }
}
