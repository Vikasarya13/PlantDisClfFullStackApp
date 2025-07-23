
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_dis_clf_app/Screens/DetailScreen/cubit/detailCubit.dart';
import 'package:plant_dis_clf_app/Screens/DetailScreen/detailScreen.dart';
import 'package:plant_dis_clf_app/Screens/HomeScreen/cubit/homeStates.dart';

import '../../constants/customUIComp.dart';
import '../../constants/strings.dart';
import 'cubit/homeCubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: C.background,
      body: BlocBuilder<HomeCubit,HomeState>(
        builder: (BuildContext context, state) {
          if (state is InitialState) {
            return const InitialHome();
          }

          else if (state is FileLoadingState) {
            return const Center(child: CircularProgressIndicator(),);
          }

          else if (state is FileLoadedState) {
            File imageFile = state.imageFile;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(imageFile: imageFile,)));
            });

            return const InitialHome();
          }
          else if (state is ErrorState) {
            return const Center(child: Text("Error Occured"));
          }
          else {
            return const Center(child: Text("Error Occured"));
          }
        }
      ),
    );
  }
}

class InitialHome extends StatelessWidget {
  const InitialHome({super.key});

  void _getFile(BuildContext context, {required ImageSource imageSource}) {
    final cubit = context.read<HomeCubit>();
    cubit.getFile(imageSource: imageSource);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: screenSize.height * 0.06,
            ),
            Text('Plant Disease \n Classification App',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: screenSize.height * 0.015,
            ),
            ImageBox(screenSize: screenSize, imgLoc: 'assets/images/plantImg1.png',),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10, 7.5, 10),
                  child: CustomButton(
                      screenSize: screenSize,
                      onPressed: (){
                        _getFile(context, imageSource: ImageSource.camera);
                      },
                      heading: "Capture",
                      fillColor: C.background,
                      borderColor: C.darkBackground),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(7.5, 10, 10, 10),
                  child: CustomButton(
                      screenSize: screenSize,
                      onPressed: (){
                        _getFile(context, imageSource: ImageSource.gallery);
                      },
                      heading: "Gallery",
                      fillColor: C.darkBackground,
                      borderColor: C.background),
                )
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
