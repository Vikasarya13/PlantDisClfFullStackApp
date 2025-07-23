
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_dis_clf_app/Screens/HomeScreen/cubit/homeStates.dart';
import 'package:plant_dis_clf_app/Screens/HomeScreen/fileFetch.dart';

class HomeCubit extends Cubit<HomeState>{

  FileFetch fileFetch;
  HomeCubit(this.fileFetch):super(InitialState());

  void getFile({required ImageSource imageSource}) async{
    try{
      emit(FileLoadingState());
      File imageFile = await fileFetch.getImage(imageSource: imageSource);
      emit(FileLoadedState(imageFile: imageFile));
    }
    catch(ex){
      emit(ErrorState());
    }
  }
}