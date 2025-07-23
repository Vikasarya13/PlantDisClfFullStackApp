import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FileFetch {

  Future<File> getImage({required ImageSource imageSource}) async {
    final file = await ImagePicker().pickImage(source: imageSource);
    if (file?.path != null) {
      return File(file!.path);
    } else {
      throw Exception(["File Not Found"]);
    }
  }
}
