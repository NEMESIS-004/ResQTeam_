import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agency"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return AdminProfileView(
                name: snapshot.data!.data()!['name'],
                email: snapshot.data!.data()!['email'],
                agency: snapshot.data!.data()!['Agency Name'] ??
                    "Update to newer version of app.",
                post: snapshot.data!.data()!['role'],
                phone: snapshot.data!.data()!['Agency_Contact_Number'] ??
                    "Update to newer version of app.",
                loc: [
                  snapshot.data!.data()!['Agency_District'] ??
                      "Update to newer version of app",
                  snapshot.data!.data()!['Agency_State'] ?? " "
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

class AdminProfileView extends StatefulWidget {
  AdminProfileView(
      {super.key,
      required this.name,
      required this.email,
      required this.agency,
      required this.post,
      required this.phone,
      required this.loc});
  String name;
  String email;
  String agency;
  String post;
  String phone;
  List<String> loc;
  @override
  State<AdminProfileView> createState() => _AdminProfileViewState();
}

class _AdminProfileViewState extends State<AdminProfileView> {
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
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.work),
                  title: Text(widget.agency),
                  titleTextStyle: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleMedium),
                ),
                SizedBox(
                  height: 8,
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(widget.phone),
                  titleTextStyle: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleMedium),
                ),
                SizedBox(
                  height: 8,
                ),
                ListTile(
                  leading: Icon(Icons.mail),
                  title: Text(widget.email),
                  titleTextStyle: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleMedium),
                ),
                SizedBox(
                  height: 8,
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(widget.loc[0] + ", " + widget.loc[1]),
                  titleTextStyle: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleMedium),
                ),
                SizedBox(
                  height: 8,
                ),
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
