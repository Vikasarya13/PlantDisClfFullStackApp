import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_dis_clf_app/Models/plantDisDetail.dart';
import 'package:plant_dis_clf_app/Screens/DetailScreen/cubit/detailStates.dart';
import 'package:plant_dis_clf_app/Screens/DetailScreen/detailRepository.dart';

class DetailCubit extends Cubit<DetailStates>{

  final DetailRepository detailRepository;
  DetailCubit(this.detailRepository):super(InitialDetailState());

  void fetchDetails({required File imageFile}) async {

    try{
      emit(LoadingDetailState());
      PlantDisDetail plantDisDetail = await detailRepository.getDetails(imageFile: imageFile);
      emit(SuccessDetailState(plantDisDetail, imageFile));
    }

    catch(ex){
      emit(ErrorDetailState(ex.toString()));
    }
  }
}