// ignore_for_file: library_private_types_in_public_api, unnecessary_import, file_names, avoid_print

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redqteam/Aman_Work/AdminForm/Models/Functions.dart';
import 'package:redqteam/Aman_Work/Support%20Pages/Pages/AlertPage.dart';
import 'package:redqteam/Aman_Work/Support%20Pages/Pages/Pages.dart';
import 'package:redqteam/ui/HomePage/user_home_page.dart';
import 'package:redqteam/ui/profile/userprofilepage.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({Key? key}) : super(key: key);

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

int pageIndex = 0;
double barPosition = 0.0;
final pages = [
  const UserHomeScreen(),
  const Page2(),
  const AlertPage(),
  const UserProfilePage()
];

class _UserMainPageState extends State<UserMainPage> {
  @override
  void initState() {
    final cuser = FirebaseAuth.instance.currentUser!;
    storeUserId(cuser.uid, cuser.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: Stack(
        children: [
          Container(
              height: 60,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color(0xff000000)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 32,
                    child: Center(
                      child: IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            pageIndex = 0;
                          });
                        },
                        icon: pageIndex == 0
                            ? const Icon(
                                CupertinoIcons.house_fill,
                                size: 32,
                                color: CupertinoColors.white,
                              )
                            : const Icon(
                                CupertinoIcons.home,
                                size: 32,
                                color: CupertinoColors.white,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    child: Center(
                      child: IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        icon: pageIndex == 1
                            ? const Icon(
                                CupertinoIcons.location_fill,
                                size: 32,
                                color: CupertinoColors.white,
                              )
                            : const Icon(
                                CupertinoIcons.location,
                                size: 32,
                                color: CupertinoColors.white,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: Center(
                      child: IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            pageIndex = 2;
                          });
                        },
                        icon: pageIndex == 2
                            ? const Icon(
                                CupertinoIcons.exclamationmark_circle_fill,
                                size: 32,
                                color: CupertinoColors.white,
                              )
                            : const Icon(
                                CupertinoIcons.exclamationmark_circle,
                                size: 32,
                                color: CupertinoColors.white,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    child: Center(
                      child: IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            setState(() {
                              pageIndex = 3;
                            });
                          },
                          icon: pageIndex == 3
                              ? const Icon(
                                  CupertinoIcons.person_circle_fill,
                                  size: 32,
                                  color: CupertinoColors.white,
                                )
                              : const Icon(
                                  CupertinoIcons.person_circle,
                                  size: 32,
                                  color: CupertinoColors.white,
                                )),
                    ),
                  ),
                ],
              )),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            left: (((MediaQuery.of(context).size.width - 128) / 4) *
                    (2 * pageIndex + 1) /
                    2) +
                pageIndex * 32 +
                16 -
                14,
            top: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.red,
              ),
              width: 42,
              height: 5,
            ),
          ),
        ],
      ),
    );
  }
}
