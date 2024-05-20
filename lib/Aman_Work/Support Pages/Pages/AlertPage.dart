// ignore_for_file: file_names, library_private_types_in_public_api, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redqteam/Aman_Work/AdminForm/Models/Data.dart';

import 'package:redqteam/Aman_Work/Support%20Pages/Shimmer/ShimmerEffect.dart';
import 'package:redqteam/Aman_Work/AdminForm/Models/Functions.dart';
import 'package:redqteam/Aman_Work/Support%20Pages/Widgets/AlertWidgetSpecific.dart';

import '../Widgets/AlertWidget.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Events',
            style: GoogleFonts.poppins(
                fontSize: 24,
                letterSpacing: 1.3,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700),
          ),
          bottom: const TabBar(tabs: [
            Tab(
              child: Text("All"),
            ),
            Tab(
              child: Text("NearBY You"),
            )
          ]),
        ),
        body: TabBarView(children: [
          FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerEffect();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Ensure Internet Connection",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: 1.3,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700),
                  ),
                );
              } else {
                final eventData = snapshot.data;
                return AlertWidget(eventdata: eventData!);
              }
            },
          ),
          (latitude == -1 && longitude == -1)
              ? (FutureBuilder<int>(
                  future: getCurrentLocation(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ShimmerEffect();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Ensure Internet Connection",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1.3,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    } else {
                      final locationFetch = snapshot.data;
                      if (locationFetch == 1) {
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future: fetchSpecificEvents(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ShimmerEffect();
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "Ensure Internet Connection",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      letterSpacing: 1.3,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700),
                                ),
                              );
                            } else {
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text("Nothing to show here!"),
                                );
                              }
                              final eventData = snapshot.data;
                              return AlertWidgetSpecific(eventdata: eventData!);
                            }
                          },
                        );
                      } else {
                        return Container(
                          child: const Center(
                            child: Text("Something Went wrong"),
                          ),
                        );
                      }
                    }
                  },
                ))
              : (FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchSpecificEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ShimmerEffect();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Ensure Internet Connection",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1.3,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    } else {
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('Nothing to show here!'),
                        );
                      }
                      final eventData = snapshot.data;
                      return AlertWidgetSpecific(eventdata: eventData!);
                    }
                  },
                ))
        ]),
      ),
    );
  }
}
