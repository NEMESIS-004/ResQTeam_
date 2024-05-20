// ignore_for_file: unused_field, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:redqteam/Aman_Work/AdminForm/DropDown/StateDropDown.dart';
import 'package:redqteam/Aman_Work/AdminForm/Models/Data.dart';
import 'package:redqteam/Aman_Work/AdminForm/Models/Functions.dart';

import '../DropDown/DistrictDropDown.dart';
import '../DropDown/ExpertiseDropDown.dart';
import '../DropDown/ResourcesDropDown.dart';

class AdminForm extends StatefulWidget {
  const AdminForm({super.key});

  @override
  State<AdminForm> createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Admin Form',
          style: GoogleFonts.poppins(
              fontSize: 24,
              letterSpacing: 1.3,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.abc),
                    label: Text(
                      "Agency Name",
                      style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          fontWeight: FontWeight.w600),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      fontWeight: FontWeight.w600),
                  cursorColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.5),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter correct Name";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    enteredname = newValue!;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.mail),
                    label: Text(
                      "Agency Email Address",
                      style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          fontWeight: FontWeight.w600),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      fontWeight: FontWeight.w600),
                  cursorColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.5),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        !value.contains('@')) {
                      return "Please enter correct email address.";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    enteredemail = newValue!;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.phone),
                    label: Text(
                      "Agency Contact Number",
                      style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          fontWeight: FontWeight.w600),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      fontWeight: FontWeight.w600),
                  cursorColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.5),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.length != 10) {
                      return "Please enter Correct Number.";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    agencycontactnumber = newValue!;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.phone),
                    label: Text(
                      "Agency Head Contact Number",
                      style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          fontWeight: FontWeight.w600),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      fontWeight: FontWeight.w600),
                  cursorColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.5),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.length != 10) {
                      return "Please enter correct Number.";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    agencyheadcontactnumber = newValue!;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 16),
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.numbers),
                        label: Text(
                          "Active Members",
                          style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                              fontWeight: FontWeight.w600),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          fontWeight: FontWeight.w600),
                      cursorColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.5),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter correct Number.";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        activemember = newValue!;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: () async {
                        int output = await getCurrentLocation(context);
                        if (output == 1) {
                          setState(() {
                            islocationfetched = true;
                          });
                        } else {
                          islocationfetched = false;
                        }
                      },
                      child: Chip(
                        label: islocationfetched
                            ? Text(
                                "Done",
                                style: GoogleFonts.poppins(
                                    color: Colors.green,
                                    fontSize: 14,
                                    letterSpacing: 1.3,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700),
                              )
                            : Text(
                                "Fetch Location",
                                style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    letterSpacing: 1.3,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700),
                              ),
                        avatar: islocationfetched
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [StateDropDown(), DistrictDropDown()],
              ),
              const SizedBox(height: 16),
              Center(
                  child: ExpertiseDropDown(
                context: context,
              )),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  "Select All Available Resources ",
                  style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.headlineSmall,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                  child: ResourceDropDown(
                context: context,
              )),
              const SizedBox(height: 24),
              Center(
                child: AnimatedButton(
                  onChanges: (value) {
                    setState(() {
                      isselected = !isselected;
                    });
                  },
                  onPress: () async {
                    int output = await submitAdminData(context);

                    if (output == 0) {
                      await Future.delayed(const Duration(seconds: 2));
                      setState(() {
                        isselected = !isselected;
                      });
                    }
                  },
                  isSelected: isselected,
                  height: 44,
                  width: MediaQuery.of(context).size.width / 1.5,
                  text: 'SUBMIT FORM',
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
              ),
              // Center(
              //     child: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: CustomAnimatedButton(
              //     child: const RoundedButtonStyle(
              //       title: "Submit",
              //     ),
              //     onTap: () async {
              //       await submitAdminData(context);
              //     },
              //   ),
              // ))
            ],
          ),
        ),
      ),
    );
  }
}
