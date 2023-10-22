import 'dart:convert';
import 'dart:developer';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<Map<String, dynamic>>?> getCountryList(
      {Function? onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    final List<Map<String, dynamic>> countryList = [];
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final http.Response response = await http.get(Uri.parse(
            "https://raw.githubusercontent.com/mwgg/Airports/master/airports.json"));
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          data!.forEach((key, value) {
            countryList.add(value);
          });
        }
      } catch (err) {
        log("Error: $err");
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
    return countryList;
  }
}