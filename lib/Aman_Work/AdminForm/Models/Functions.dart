// ignore_for_file: file_names, avoid_print, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:redqteam/Aman_Work/AdminForm/Models/Data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;

double earthRadius = 6371000;
getDistance(double pLat, double pLng) {
  var dLat = vmath.radians(pLat - latitude);
  var dLng = vmath.radians(pLng - longitude);
  var a = sin(dLat / 2) * sin(dLat / 2) +
      cos(vmath.radians(latitude)) *
          cos(vmath.radians(pLat)) *
          sin(dLng / 2) *
          sin(dLng / 2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  var d = earthRadius * c;

  return d / 1000; //d is the distance in meters
}

// On Submitting Data From Form For Agency
Future<int> submitAdminData(BuildContext context) async {
  final isvaild = form.currentState!.validate();
  if (!isvaild) {
    return 0;
  }
  if (selectedState == "Empty" ||
      selectedDistrict == "Empty" ||
      expertise.isEmpty ||
      resources.isEmpty ||
      latitude == -1 ||
      longitude == -1) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          "Please Fill The Form Correctly",
          style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 1.3,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
    return 0;
  }
  form.currentState!.save();
  try {
    final cuser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection("Agency_Total_Data")
        .doc(cuser.uid)
        .set({
      "Agency Name": enteredname,
      "Agency_Email": enteredemail,
      "Agency_Contact_Number": agencycontactnumber,
      "Agency_Head_Contact_Number": agencyheadcontactnumber,
      "Active_Member": activemember,
      "Agency_Longitude": longitude,
      "Agency_Latitude": latitude,
      "Agency_State": selectedState,
      "Agency_District": selectedDistrict,
      "Agency_Expertise": expertise,
      "Agency Resources": resources
    });
    await FirebaseFirestore.instance.collection("users").doc(cuser.uid).update({
      "Agency Name": enteredname,
      "Agency_Longitude": longitude,
      "Agency_Latitude": latitude,
      "Agency_State": selectedState,
      "Agency_Number": agencycontactnumber,
      "Agency_District": selectedDistrict,
    });

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/adminhomepage', (route) => false);
  } on FirebaseAuthException {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          "Authentication Failed",
          style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 1.3,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
  return 1;
}

Future<void> requestLocationPermission() async {
  final permissionStatus = await Geolocator.checkPermission();
  if (permissionStatus == LocationPermission.denied ||
      permissionStatus == LocationPermission.deniedForever) {
    final permissionRequested = await Geolocator.requestPermission();
    if (permissionRequested != LocationPermission.whileInUse &&
        permissionRequested != LocationPermission.always) {
      return;
    }
  }
}

Future<int> getCurrentLocation(BuildContext context) async {
  await requestLocationPermission();
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = position.latitude;
    longitude = position.longitude;

    print('Latitude: $latitude, Longitude: $longitude');
    return 1;
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        "Ensure Location Access",
        style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 16,
            letterSpacing: 1.3,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w700),
      ),
    ));
    return 0;
  }
}

Future<List<Map<String, dynamic>>> fetchEvents() async {
  final DateFormat dateFormat = DateFormat('yyyy/MM/dd');
  final String formattedDate = dateFormat.format(DateTime.now());

  final Map<String, String> queryParams = {
    "active.undefined": formattedDate,
    "category": "disasters",
    "country": "IN",
    "label": "earthquake,avalanche,landslide,fire,flood",
    "place.scope": "",
    "start.undefined": formattedDate,
    "updated.undefined": formattedDate,
    "end.undefined": formattedDate,
    "state": "predicted,active",
  };

  final uri = Uri.parse("https://api.predicthq.com/v1/events/")
      .replace(queryParameters: queryParams);

  final response = await http.get(
    uri,
    headers: {
      "Authorization": "Bearer V7hdBHYn2zojnF747VF9nh_2HW_7p91ZnmRADJ8W",
      "Accept": "application/json",
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data.containsKey("results") && data["results"] is List) {
      return List<Map<String, dynamic>>.from(data["results"]);
    } else {
      throw Exception('Invalid data format');
    }
  } else {
    throw Exception('Failed to fetch events');
  }
}

Future<List<Map<String, dynamic>>> fetchSpecificEvents() async {
  final DateFormat dateFormat = DateFormat('yyyy/MM/dd');
  final String formattedDate = dateFormat.format(DateTime.now());

  final Map<String, String> queryParams = {
    "active.undefined": formattedDate,
    "category": "disasters",
    "country": "IN",
    "label": "earthquake,avalanche,landslide,fire,flood",
    "place.scope": "",
    "start.undefined": formattedDate,
    "updated.undefined": formattedDate,
    "end.undefined": formattedDate,
    "state": "predicted,active",
  };

  final uri = Uri.parse("https://api.predicthq.com/v1/events/")
      .replace(queryParameters: queryParams);

  final response = await http.get(
    uri,
    headers: {
      "Authorization": "Bearer V7hdBHYn2zojnF747VF9nh_2HW_7p91ZnmRADJ8W",
      "Accept": "application/json",
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data.containsKey("results") && data["results"] is List) {
      var list = List<Map<String, dynamic>>.from(data["results"]);
      List<Map<String, dynamic>> res = [];
      for (Map<String, dynamic> mp in list) {
        if (getDistance(mp['location'][1], mp['location'][0]) <= 5) {
          res.add(mp);
        }
      }
      return res;
    } else {
      throw Exception('Invalid data format');
    }
  } else {
    throw Exception('Failed to fetch events');
  }
}

Future<int> ReportDisaster(BuildContext context) async {
  int op = await getCurrentLocation(context);
  if (op == 1) {
    try {
      final cuser = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection("Red_Alert")
          .doc(cuser.uid)
          .set({
        "Alert_Type": "",
        "Longitude": longitude,
        "Latitude": latitude,
        "Contact_Number": cuser.phoneNumber,
        "Name": cuser.displayName,
        "Email": cuser.email,
        "Date_Time": DateTime.now(),
        "uid": cuser.uid,
      });
      return 1;
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            "Authentication Failed",
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 1.3,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700),
          ),
        ),
      );
      return 0;
    }
  }
  return 0;
}

String _locationData = '';

Future<void> DangerZoneCall() async {
  final response = await http
      .get(Uri.parse('https://97e3-45-115-104-184.ngrok-free.app/red-alert'));
  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    for (var item in jsonData) {
      double lat = item["Latitude"];
      double long = item["Longitude"];
      final response = await http.get(Uri.parse('https://ipinfo.io/json'));
      if (response.statusCode == 200) {
        _locationData = response.body;
        Map<String, dynamic> data = json.decode(_locationData);
        String loc = data["loc"];
        List<String> locParts = loc.split(",");
        double apilatitude = double.parse(locParts[0]);
        double apilongitude = double.parse(locParts[1]);
        latitude = apilatitude;
        longitude = apilongitude;
        double distance = getDistance(lat, long) / 1000;
        if (distance <= 2) {
          try {
            await fetchUserId();
            final Uri apiUrl = Uri.parse(
                'https://97e3-45-115-104-184.ngrok-free.app/danger-zone');
            final Map<String, dynamic> requestData = {
              'user_id': senduid,
              'email': sendemail,
              'latitude': apilatitude,
              'longitude': apilongitude,
            };
            final response = await http.post(
              apiUrl,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(requestData),
            );

            if (response.statusCode == 200) {
              print('Data sent successfully');
            } else {
              print('Failed to send data to the server');
            }
            break;
          } on FirebaseAuthException {
            print("error is comming");
          }
        } else {
          print("not near");
        }
      } else {
        print('Failed to retrieve location data');
      }
    }
  } else {
    print('Failed to load red alert data');
  }
}

getOfflineLocation() async {
  await requestLocationPermission();
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude = position.latitude;
    longitude = position.longitude;
    print('Latitude: $latitude, Longitude: $longitude');
  } catch (e) {
    print(e);
  }
}

String senduid = "";
String sendemail = "";
Future<void> storeUserId(String userId, String user_email) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_id', userId);
  await prefs.setString('user_email', user_email);
}

Future<void> fetchUserId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  senduid = prefs.getString('user_id') ?? '';
  sendemail = prefs.getString('user_email') ?? '';
}
