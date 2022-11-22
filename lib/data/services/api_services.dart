import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:zartek_machine/data/model/restuarant_model.dart';

class ApiServices {
  Future<RestuarantModel> fetchingData() async {
    const uri = "https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad";
    try {
      final response = await Dio().get(uri);
      if (response.statusCode == 200) {
        return RestuarantModel.fromJson(response.data[0]);
      }
      throw 'something went wrong';
    } catch (e) {
      throw 'something went wrong';
    }
  }
}
