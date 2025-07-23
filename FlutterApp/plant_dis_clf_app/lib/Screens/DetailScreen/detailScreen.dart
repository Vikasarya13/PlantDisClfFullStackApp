import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_dis_clf_app/Models/plantDisDetail.dart';
import 'package:plant_dis_clf_app/Screens/DetailScreen/cubit/detailCubit.dart';
import 'package:plant_dis_clf_app/Screens/DetailScreen/cubit/detailStates.dart';
import 'package:plant_dis_clf_app/constants/app_theme.dart';
import 'package:plant_dis_clf_app/constants/plantDisData.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/customUIComp.dart';
import '../../constants/strings.dart';

class DetailScreen extends StatefulWidget {
  final File imageFile;

  DetailScreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void _predict(BuildContext context) {
    final cubit = context.read<DetailCubit>();
    if (widget.imageFile != null) {
      print("Hurray");
      cubit.fetchDetails(imageFile: widget.imageFile);
    }
  }

  @override
  void initState() {
    super.initState();
    _predict(context); // Call _predict during initialization if needed.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: C.background,
        body: BlocBuilder<DetailCubit, DetailStates>(
          builder: (context, state) {
            if (state is LoadingDetailState || state is InitialDetailState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            else if (state is SuccessDetailState) {
              return DiseaseDetail(plantDisDetail: state.plantDisDetail, imageFile: state.imageFile,);
            }

            else if (state is ErrorDetailState) {
              return Center(
                child: Text(state.err.toString()),
              );
            } else {
              return const Center(
                child: Text("Fuck"),
              );
            }
          },
        ));
  }
}

class DiseaseDetail extends StatelessWidget {
  DiseaseDetail({super.key, required this.plantDisDetail, required this.imageFile});
  PlantDisDetail plantDisDetail;
  File imageFile;

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Map<String, dynamic> plantData =
    getClassDetails(plantDisDetail.predictedClass.toString());

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: screenSize.height * 0.06,
          ),
          Text('Plant Disease \n Classification Result',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          Container(
            width: screenSize.width*0.65,
            height: screenSize.height*0.4,
            decoration: BoxDecoration(
              image: DecorationImage(image: FileImage(imageFile!),fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.01,
          ),
          Text('Predicted Disease: ${plantDisDetail.predictedClass}',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: screenSize.height * 0.01,
          ),
          Text('Prediction Confidence: ${plantDisDetail.confidence}%',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: screenSize.height * 0.018,
          ),
          Text('Description:',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('${plantData['disease_description']}',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                )),
          ),
          SizedBox(
            height: screenSize.height * 0.01,
          ),
          Text('Symptoms:',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('${plantData['symptoms']}',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                )),
          ),
          SizedBox(
            height: screenSize.height * 0.01,
          ),
          Text('Treatment Methods:',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('${plantData['treatment_methods']}',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                )),
          ),
          SizedBox(
            height: screenSize.height * 0.01,
          ),
          Center(
            child: CustomButton(
              screenSize: screenSize,
              onPressed: (){
                _launchUrl(plantData['google_search_link']);
              },
              heading: 'Search On Google', fillColor: C.background, borderColor: C.darkBackground,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.01,
          ),
        ],
      ),
    );
  }
}
