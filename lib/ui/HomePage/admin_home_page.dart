import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminHomeScreen extends StatelessWidget {
  Future<void> _callEmergency() async {
    final Uri uri = Uri(scheme: 'tel', path: '112');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ResQteam',
          textAlign: TextAlign.start,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add notification button action here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.0),
            // // if there is any active alert in that location
            // Text('Active Alert in Your Area'),
            // // if no active alert
            // Text('No Active Alert in Your Area'),
            // Example of displaying an alert with intensity
            AlertContainer(
              alertName: 'Thunderstorm with Lightning',
              issuingAuthority: 'Issued By West Bengal SDMA',
              announcementDate: '05 Sep, 21:30',
              location:
                  'Hugli, Paschim Bardhaman, Purba Bardhaman districts of West Bengal',
              intensity: 'Medium',
              validUntil: '06 Sep, 00:30',
            ),
            SizedBox(height: 16.0),

            Text(
              'For Admins',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),

            SizedBox(height: 8.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      // help admins analyze response times,
                      // resource utilization, and the overall effectiveness of
                      // their agency's operations.
                      // analysis of incident
                      // -> population effected
                      // -> resource fulfilled or not
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.all(12.0), // Adjust the padding as needed
                    ),
                    child: Text(
                      'Analytics \n\t\t\t\t\t\t&\n Reporting',
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      //
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(12.0),
                    ),
                    child: Text(
                      'Resource Management',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      // ping volunteers for help
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(12.0),
                    ),
                    child: Text(
                      'Ping Volunteers',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.0),

            Text(
              'For Agency Members',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),

            SizedBox(height: 8.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  width:
                      100, // Set the width here to increase the button's width
                  child: ElevatedButton(
                    onPressed: () {
                      // Request additional resources like vehicles, equipment,
                      // or medical supplies as needed
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.all(12.0), // Adjust the padding as needed
                    ),
                    child: Text(
                      'Resource Request',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      // for submitting reports, text desciption, photos and videos
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.all(12.0), // Adjust the padding as needed
                    ),
                    child: Text(
                      'Incident Reporting',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      // real time weather report of incident area
                      // for better planning and evacuation
                      // whether agency team member is available at location for help
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.all(12.0), // Adjust the padding as needed
                    ),
                    child: Text(
                      'Availability',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 50.0,
            ),

            // -------------------------------------------------------------
            // weather ka ek container ayeaga jisme aajka and 7 days ago ka weather forecast hoga
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

  AlertContainer({
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
    Color textColor = Colors.black; // Default text color for light backgrounds
    if (containerColor == Colors.brown || containerColor == Colors.red) {
      textColor = Colors.white; // White text for dark backgrounds
    }

    return Card(
      elevation: 2.0,
      color: Theme.of(context).colorScheme.tertiaryContainer,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              alertName,
              style: TextStyle(
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
              style: TextStyle(
                color: textColor, // Text color for announcement date
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              location,
              style: TextStyle(
                color: textColor, // Use textColor for location
              ),
            ),
            Text(
              validUntil,
              style: TextStyle(
                color: textColor, // Use textColor for valid until
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle share button action
                      },
                      icon: Icon(Icons.share),
                    ),
                    Text(
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
                      icon: Icon(Icons.map),
                    ),
                    Text(
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
                      icon: Icon(Icons.headset),
                    ),
                    Text(
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
                    icon: Icon(Icons.translate),
                  ),
                  Text(
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
                      icon: Icon(Icons.info_outline_rounded),
                    ),
                    Text(
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
