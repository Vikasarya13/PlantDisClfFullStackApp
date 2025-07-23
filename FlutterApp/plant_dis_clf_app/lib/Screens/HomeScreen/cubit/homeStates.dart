
import 'dart:io';

abstract class HomeState {

}

class InitialState extends HomeState{
  InitialState();
}


class FileLoadingState extends HomeState{
  FileLoadingState();
}

class FileLoadedState extends HomeState{
  File imageFile;
  FileLoadedState({required this.imageFile});
}

class ErrorState extends HomeState{
  ErrorState();
}