import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redqteam/Aman_Work/AdminForm/Models/Data.dart';
import 'package:redqteam/Aman_Work/AdminForm/Models/Functions.dart';

import '../components/loading_error.dart';

class UserConsent extends StatefulWidget {
  const UserConsent({super.key});

  @override
  State<UserConsent> createState() => _UserConsentState();
}

class _UserConsentState extends State<UserConsent> {
  bool trainedByRescueAgency = false;
  bool consentForEmergencyContact = false;
  bool _isSubmitting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 100.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: Text(
              "Finalizing your account...",
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headlineSmall,
              ),
            )),
            Flexible(
                child: Text(
              "Choose whatever applies to you",
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleSmall,
              ),
            )),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Checkbox(
                    value: trainedByRescueAgency,
                    onChanged: (newValue) {
                      setState(() {
                        trainedByRescueAgency = newValue!;
                      });
                    },
                  ),
                  Flexible(
                    child: Text(
                      'I have previously been trained by a rescue agency',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Checkbox(
                    value: consentForEmergencyContact,
                    onChanged: (newValue) {
                      setState(() {
                        consentForEmergencyContact = newValue!;
                      });
                    },
                  ),
                  Flexible(
                    child: Text(
                      'I give my consent to contact me in case of any emergency in my area for relief work.',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: (MediaQuery.of(context).size.width / 2) - 70),
              child: ElevatedButton(
                onPressed: () async {
                  _isSubmitting = true;
                  try {
                    User user = FirebaseAuth.instance.currentUser!;
                    FirebaseFirestore _db = FirebaseFirestore.instance;
                    await getCurrentLocation(context);
                    if (consentForEmergencyContact) {
                      await _db
                          .collection('preTrained_users')
                          .doc(user.uid)
                          .set({
                        "pre_trained": trainedByRescueAgency.toString(),
                        "can_contact": consentForEmergencyContact.toString(),
                        "email": user.email,
                        "uid": user.uid,
                        "latitude": latitude,
                        "longitude": longitude,
                      });
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/userhomepage", (route) => false);
                    }
                    // ignore: use_build_context_synchronously
                  } catch (e) {
                    ErrorDialog.show(context,
                        "Oops! Something went wron. Please try again later");
                  }
                  _isSubmitting = false;
                },
                child: (!_isSubmitting)
                    ? const Text('Continue')
                    : const CircularProgressIndicator(
                        color: Colors.white,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
