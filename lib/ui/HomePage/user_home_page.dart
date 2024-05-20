// ignore_for_file: unused_element, deprecated_member_use, non_constant_identifier_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:redqteam/Aman_Work/AdminForm/Models/Functions.dart';
import 'package:redqteam/ui/search_and_filter/search_and_filter_view.dart';
import 'package:url_launcher/url_launcher.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  Future<void> _callEmergency() async {
    // You can replace '112' with the actual emergency number in your country.
    const phoneNumber = '112';
    const url = 'tel:$phoneNumber';
    launch(url);
  }

  bool isalert = false;
  String showtext = 'Report Disaster';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ResQteam',
          textAlign: TextAlign.start,
          style: GoogleFonts.poppins(
              fontSize: 24,
              letterSpacing: 1.3,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () async {
              await getOfflineLocation();
              // Add notification button action here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10.0),
            // // if there is any active alert in that location
            // Text('Active Alert in Your Area'),
            // // if no active alert
            // Text('No Active Alert in Your Area'),
            // Example of displaying an alert with intensity
            const AlertContainer(
              alertName: 'Thunderstorm with Lightning',
              issuingAuthority: 'Issued By West Bengal SDMA',
              announcementDate: '05 Sep, 21:30',
              location:
                  'Hugli, Paschim Bardhaman, Purba Bardhaman districts of West Bengal',
              intensity: 'Medium',
              validUntil: '06 Sep, 00:30',
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedButton(
                    onChanges: (value) {
                      setState(() {
                        isalert = !isalert;
                        showtext = "Reporting...";
                      });
                    },
                    onPress: () async {
                      int ans = await ReportDisaster(context);
                      if (ans == 1) {
                        setState(() {
                          showtext = 'Reported';
                        });
                      } else {
                        await Future.delayed(const Duration(seconds: 2));
                        setState(() {
                          isalert = !isalert;
                          showtext = 'Report Disaster';
                        });
                      }
                    },
                    height: 44,
                    width: MediaQuery.of(context).size.width / 2.2,
                    text: showtext,
                    isSelected: isalert,
                    selectedBackgroundColor: Colors.green,
                    isReverse: true,
                    animationDuration: const Duration(seconds: 2),
                    selectedTextColor: Colors.white,
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    textStyle: GoogleFonts.poppins(
                        color: Colors.red,
                        letterSpacing: 1.3,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700),
                    backgroundColor: Colors.black,
                    borderColor: Colors.white,
                    borderRadius: 50,
                    borderWidth: 2,
                  ),
                  AnimatedButton(
                    onPress: () {
                      _callEmergency();
                    },
                    height: 44,
                    width: MediaQuery.of(context).size.width / 2.2,
                    text: 'Emergency Call',
                    selectedBackgroundColor: Colors.green,
                    isReverse: true,
                    animationDuration: const Duration(seconds: 2),
                    selectedTextColor: Colors.white,
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    textStyle: GoogleFonts.poppins(
                        color: Colors.red,
                        letterSpacing: 1.3,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700),
                    backgroundColor: Colors.black,
                    borderColor: Colors.white,
                    borderRadius: 50,
                    borderWidth: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const SearchAndFilterScreen()
          ],
        ),
      ),
    );
  }
}

class AlertContainer extends StatelessWidget {
  final String alertName;
  final String issuingAuthority;
  final String announcementDate;
  final String location;
  final String intensity;
  final String validUntil;

  const AlertContainer({
    super.key,
    required this.alertName,
    required this.issuingAuthority,
    required this.announcementDate,
    required this.location,
    required this.intensity,
    required this.validUntil,
  });

  Color getIntensityColor(String intensity) {
    switch (intensity.toLowerCase()) {
      case 'low':
        return Colors.brown;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Colors.grey; // Default color for unknown intensity
    }
  }

  @override
  Widget build(BuildContext context) {
    final containerColor = getIntensityColor(intensity);

    // Determine text color based on the container color
    Color? textColor = Theme.of(context)
        .textTheme
        .titleLarge!
        .color; // Default text color for light backgrounds
    if (containerColor == Colors.brown || containerColor == Colors.red) {
      textColor = Colors.white; // White text for dark backgrounds
    }

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.only(
        left: 16.0,
        right: 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              alertName,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: textColor, // Text color for alert name
              ),
            ),
            Text(
              issuingAuthority,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: textColor, // Text color for issuing authority
              ),
            ),
            Text(
              announcementDate,
              style: GoogleFonts.poppins(
                color: textColor, // Text color for announcement date
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              location,
              style: GoogleFonts.poppins(
                color: textColor, // Use textColor for location
              ),
            ),
            Text(
              validUntil,
              style: TextStyle(
                color: textColor, // Use textColor for valid until
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle share button action
                      },
                      icon: const Icon(Icons.share),
                    ),
                    const Text(
                      'Share',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle map button action
                      },
                      icon: const Icon(Icons.map),
                    ),
                    const Text(
                      'Map',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle listen button action
                      },
                      icon: const Icon(Icons.headset),
                    ),
                    const Text(
                      'Listen',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(children: [
                  IconButton(
                    onPressed: () {
                      // Handle translate button action
                    },
                    icon: const Icon(Icons.translate),
                  ),
                  const Text(
                    'Translate',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle dos and donts button action
                      },
                      icon: const Icon(Icons.info_outline_rounded),
                    ),
                    const Text(
                      'Dos & Don\'ts',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
