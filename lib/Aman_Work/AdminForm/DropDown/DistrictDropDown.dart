// ignore_for_file: file_names, duplicate_ignore
// ignore_for_file: unnecessary_import, file_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/customPaints/arrow_down_painter.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:cool_dropdown/options/result_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redqteam/Aman_Work/AdminForm/Models/Data.dart';

class DistrictDropDown extends StatefulWidget {
  const DistrictDropDown({super.key});

  @override
  _DistrictDropDownState createState() => _DistrictDropDownState();
}

class _DistrictDropDownState extends State<DistrictDropDown> {
  @override
  void initState() {
    for (var state in districtLists[selectedState]!) {
      DistrictDropDownItems.add(
        CoolDropdownItem<String>(
          label: state,
          value: state,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: CoolDropdown<String>(
        controller: DistrictDropDownController,
        dropdownList: DistrictDropDownItems,
        defaultItem: null,
        onChange: (value) {
          setState(() {
            selectedDistrict = value;
          });
          DistrictDropDownController.close();
        },
        resultOptions: ResultOptions(
          openBoxDecoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Color.fromARGB(255, 51, 50, 50))
            ],
            color: const Color.fromARGB(95, 172, 164, 164),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
          ),
          mainAxisAlignment: MainAxisAlignment.center,
          width: MediaQuery.of(context).size.width / 2.2,
          boxDecoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Color.fromARGB(255, 51, 50, 50))
            ],
            color: const Color.fromARGB(95, 172, 164, 164),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
          ),
          icon: const SizedBox(
            width: 10,
            height: 10,
            child: CustomPaint(
              painter: DropdownArrowPainter(color: Colors.white),
            ),
          ),
          render: ResultRender.all,
          placeholder: 'Select District',
          placeholderTextStyle: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 1.3,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
          textStyle: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 1.3,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
        ),
        dropdownOptions: const DropdownOptions(
          color: Colors.black,
          top: 20,
          height: 400,
          gap: DropdownGap.all(5),
          borderSide: BorderSide(width: 1, color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 10),
          align: DropdownAlign.left,
          animationType: DropdownAnimationType.size,
        ),
        dropdownTriangleOptions: const DropdownTriangleOptions(
          width: 20,
          height: 30,
          align: DropdownTriangleAlign.center,
          borderRadius: 3,
          left: 20,
        ),
        dropdownItemOptions: DropdownItemOptions(
          boxDecoration: const BoxDecoration(
            color: Color.fromARGB(95, 172, 164, 164),
          ),
          textStyle: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 1.3,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
          isMarquee: true,
          mainAxisAlignment: MainAxisAlignment.center,
          render: DropdownItemRender.all,
          height: 50,
        ),
      ),
    );
  }
}
