import 'dart:developer';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../database/dbhelper.dart';
import '../../services/api_service.dart';
import '../../utils/common_colors.dart';

class HomeViewModel with ChangeNotifier {
  final _services = ApiServices();
  List<Map<String, dynamic>> countryInfoList = [];
  bool isApiLoading = false;

  Future<void> getCountryList() async {
    isApiLoading = true;
    List<Map<String, dynamic>>? master =
    await _services.getCountryList(onNoInternet: () {
      showToastMessage(message: "No internet , please try when connected");
    });
    isApiLoading = false;
    if (master != null) {
      countryInfoList = master;
      await DBHelper.instance.clearCountryList();
      for (var element in countryInfoList) {
        insertCountry(element);
      }
    } else {
      showToastMessage(
          message: "oops something went wrong, please try again later",
          color: CommonColors.primaryColor);
    }
    notifyListeners();
  }

  Future<void> insertCountry(Map<String, dynamic> countryDetails) async {
    int countryList = await DBHelper.instance.insertVillage(countryDetails);
    if (countryList > 0) {
      log("list inserted");
    }
    notifyListeners();
  }

  Future<void> getOfflineCountryList() async {
    countryInfoList = await DBHelper.instance.getLocalCountryList();
    log("list added");
    notifyListeners();
  }

  void getDashboardData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      getCountryList();
      showToastMessage(
          message: "you are online,data fetching from the server",
          color: CommonColors.primaryColor);
    } else {
      getOfflineCountryList();
      showToastMessage(
          message: "you are offline,the data fetching locally now",
          color: CommonColors.primaryColor);
    }
  }
}

void showToastMessage({message, color}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: color ?? Colors.black87,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}