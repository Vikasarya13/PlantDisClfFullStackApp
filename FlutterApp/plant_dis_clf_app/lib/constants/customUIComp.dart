import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_dis_clf_app/constants/strings.dart';

import 'glassMorph.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({
    super.key,
    required this.screenSize,
    required this.imgLoc,
  });

  final Size screenSize;
  final String imgLoc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: screenSize.height * 0.5,
          width: screenSize.width * 0.8,
          child: Center(
            child: GlassMorphism(
                start: 0.04,
                end: 0.25,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
                  child: SizedBox(
                    height: screenSize.height * 0.40,
                    width: screenSize.width * 0.45,
                  ),
                )),
          ),
        ),
        Center(
          child: Image.asset(
            imgLoc,
            fit: BoxFit.cover,
            height: screenSize.height * 0.6,
            width: screenSize.width * 0.55,
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.screenSize,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final Size screenSize;
  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: C.darkBackground, width: 1.5),
        borderRadius: BorderRadius.circular(50.0),
      ),
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.08,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 17.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search for Plant Disease..',
                  hintStyle: TextStyle(color: C.darkBackground),
                ),
                style: TextStyle(color: C.darkBackground),
                cursorColor: C.darkBackground,
                onChanged: (value) {},
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: C.darkBackground,
              ),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.screenSize,
    required this.onPressed,
    required this.heading,
    required this.fillColor,
    required this.borderColor,
  });

  final Size screenSize;
  final void Function() onPressed;
  final String heading;
  final Color borderColor;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: fillColor,
          border: Border.all(color: C.darkBackground, width: 2.5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.09,
        child: Center(
            child: Text(
              heading,
              style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold, color: borderColor),
            )),
      ),
    );
  }
}