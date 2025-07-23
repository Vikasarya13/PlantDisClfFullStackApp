import 'dart:convert';
import 'dart:io';

import 'package:plant_dis_clf_app/Models/plantDisDetail.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../constants/strings.dart';

class DetailRepository{

  Future<PlantDisDetail> getDetails({required File imageFile}) async {
    print("high");
    print(imageFile.path);

    try {
      var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.7:8000/upload/'));
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // Field name for the image in the form
          imageFile.path,
        ),
      );

      final response = await request.send();
      final responseStream = await response.stream.bytesToString();
      print(responseStream);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(responseStream) as Map<String, dynamic>;
        final plantDisDetail = PlantDisDetail.fromJson(jsonResponse);
        print(plantDisDetail.predictedClass);
        return plantDisDetail;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (ex) {
      print('Error: $ex');
      throw Exception(ex.toString());
    }
  }

  Future<PlantDisDetail> getDetailsFake({required File imageFile}) async {
    // Simulate network delay

    await Future.delayed(Duration(seconds:5));

    if (false) {
      // random network error
      throw Exception();
    } else {
      // fake successful login
      return PlantDisDetail.fromJson({'predicted_class': 'Tomato Late Blight', 'confidence': 100});
    }
  }
}