import 'package:flutter/widgets.dart';
import 'package:zartek_machine/data/model/restuarant_model.dart';
import 'package:zartek_machine/data/services/api_services.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    getData();
  }
  bool isLoading = true;
  String error = '';
  late RestuarantModel restuarantModel;

  void getData() async {
    error = '';
    try {
      restuarantModel = await ApiServices().fetchingData();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
