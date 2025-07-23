import 'dart:io';

import 'package:plant_dis_clf_app/Models/plantDisDetail.dart';

abstract class DetailStates {

}

class InitialDetailState extends DetailStates{
  InitialDetailState();
}


class LoadingDetailState extends DetailStates{
  LoadingDetailState();
}

class SuccessDetailState extends DetailStates{
  PlantDisDetail plantDisDetail;
  File imageFile;
  SuccessDetailState(this.plantDisDetail, this.imageFile);
}

class ErrorDetailState extends DetailStates{
  final String err;
  ErrorDetailState(this.err);
}