// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:redqteam/Aman_Work/AdminForm/Models/DistrictMapping.dart';

final List<String> statesOfIndia = [
  'Central',
  'AndamanNicobar',
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Delhi',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'JammuKashmir',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Puducherry',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal',
];
final List<String> mainExpertise = [
  "Earthquakes",
  "Hurricanes",
  "Tornadoes",
  "Floods",
  "Tsunamis",
  "Volcanic eruptions",
  "Wildfires",
  "Droughts",
  "Landslides",
  "Avalanche",
  "Search",
  "Fire",
  "Industrial accidents",
  "Nuclear accidents",
  "Chemical spills",
  "Infrastructure failures",
  "Pandemics",
  "Epidemics",
  "Disease outbreaks",
];

Map<String, List<String>> districtLists = {
  'Central': ["Central"],
  'AndamanNicobar': districtsOfAndamanNicobar,
  'Andhra Pradesh': districtsOfAndhraPradesh,
  'Arunachal Pradesh': districtsOfArunachalPradesh,
  'Assam': districtsOfAssam,
  'Bihar': districtsOfBihar,
  'Chhattisgarh': districtsOfChhattisgarh,
  'Delhi': districtsOfDelhi,
  'Goa': districtsOfGoa,
  'Gujarat': districtsOfGujarat,
  'Haryana': districtsOfHaryana,
  'Himachal Pradesh': districtsOfHimachalPradesh,
  'JammuKashmir': districtsOfJammuKashmir,
  'Jharkhand': districtsOfJharkhand,
  'Karnataka': districtsOfKarnataka,
  'Kerala': districtsOfKerala,
  'Madhya Pradesh': districtsOfMadhyaPradesh,
  'Maharashtra': districtsOfMaharashtra,
  'Manipur': districtsOfManipur,
  'Meghalaya': districtsOfMeghalaya,
  'Mizoram': districtsOfMizoram,
  'Nagaland': districtsOfNagaland,
  'Odisha': districtsOfOdisha,
  'Punjab': districtsOfPunjab,
  'Puducherry': districtsOfPuducherry,
  'Rajasthan': districtsOfRajasthan,
  'Sikkim': districtsOfSikkim,
  'Tamil Nadu': districtsOfTamilNadu,
  'Telangana': districtsOfTelangana,
  'Tripura': districtsOfTripura,
  'Uttar Pradesh': districtsOfUttarPradesh,
  'Uttarakhand': districtsOfUttarakhand,
  'West Bengal': districtsOfWestBengal,
  "Empty": ["Select State First"],
};

List<String> rescueEquipment = [
  "Firefighting gear",
  "Ropes and harnesses",
  "Medical supplies",
  "Extrication tools",
  "Communication devices",
  "Water rescue gear",
  "Aerial rescue equipment",
  "Hazmat suits",
  "Command and control tools",
  "Lighting and power gear",
  "Stabilization equipment",
  "Ambulances",
  "Fire trucks",
  "Rescue boats",
  "Helicopters",
  "Specialized vehicles",
  "Off-road vehicles",
  "Transport vehicles",
  "Evacuation buses",
  "All-terrain vehicles (ATVs)",
  "Bicycle units",
];

void AddDistrict() {
  for (var state in districtLists[selectedState]!) {
    DistrictDropDownItems.add(
      CoolDropdownItem<String>(
        label: state,
        value: state,
      ),
    );
  }
}

final ResourceDropDownController = DropdownController();
List<CoolDropdownItem<String>> ResourceDropDownItems = [];

final DistrictDropDownController = DropdownController();
List<CoolDropdownItem<String>> DistrictDropDownItems = [];

final ExpertiseDropDownController = DropdownController();
List<CoolDropdownItem<String>> ExpertiseDropDownItems = [];

final stateDropdownController = DropdownController();
List<CoolDropdownItem<String>> stateDropdownItems = [];

String enteredname = '';
String enteredemail = "";
String agencycontactnumber = "";
String agencyheadcontactnumber = "";
String activemember = "";
double latitude = -1;
double longitude = -1;
String selectedState = "Empty";
String selectedDistrict = "Empty";
List<String> expertise = [];
List<String> resources = [];
bool isselected = false;
bool islocationfetched = false;
final form = GlobalKey<FormState>();
