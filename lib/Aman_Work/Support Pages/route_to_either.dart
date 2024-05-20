import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redqteam/Aman_Work/Support%20Pages/Pages/AdminMainPage.dart';
import 'package:redqteam/Aman_Work/Support%20Pages/Pages/UserMainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteToEitherController extends StatefulWidget {
  const RouteToEitherController({super.key});

  @override
  State<RouteToEitherController> createState() =>
      _RouteToEitherControllerState();
}

class _RouteToEitherControllerState extends State<RouteToEitherController> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.data()!['role'] == 'user') {
              return UserMainPage();
            } else {
              return AdminMainPage();
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
