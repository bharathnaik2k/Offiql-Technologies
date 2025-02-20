import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:offiql_techno_assign/widgets/components/api/api_adress.dart';
import 'package:offiql_techno_assign/widgets/components/data_model_class.dart';

class ProviderStateController with ChangeNotifier {
  bool isLoading = true;
  List<DataModel> dataList = [];
  List<DataModel> searchResults = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController suiteController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();

  // this Function get api data. and After store searchResults variable inside
  Future<void> fetchData() async {
    try {
      final response = await get(Uri.parse(getUsersUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        searchResults = data.map((json) => DataModel.fromJson(json)).toList();
        isLoading = false;
        onQueryChanged("");
        notifyListeners();
      } else {
        // 200. if any code other than status code is received then this toast will be shown
        Fluttertoast.showToast(msg: "Api data Not Received");
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      if (e is SocketException) {
        // No internet connection error
        Fluttertoast.showToast(
          msg: "No Internet Connection",
        );
      } else if (e is TimeoutException) {
        // request timeout error
        Fluttertoast.showToast(
          msg: "Request Timed Out",
        );
      } else if (e is FormatException) {
        // Wrong data format error
        Fluttertoast.showToast(
          msg: "Invalid Response Format",
          toastLength: Toast.LENGTH_SHORT,
        );
      } else if (e is HttpException) {
        // API error
        Fluttertoast.showToast(
          msg: "Server Error: ${e.message}",
        );
      } else {
        // unknown error
        Fluttertoast.showToast(
          msg: "Something went wrong: ${e.toString()}",
        );
      }
    }
  }

  // this function store new user localy
  void addNewUser() {
    searchResults.add(
      DataModel.fromJson(
        {
          "id": 1,
          "name": nameController.text,
          "username": usernameController.text,
          "email": emailController.text,
          "address": {
            "street": streetController.text,
            "suite": suiteController.text,
            "city": cityController.text,
            "zipcode": zipcodeController.text,
            "geo": {
              "lat": "",
              "lng": "",
            }
          },
          "phone": numberController.text,
          "website": websiteController.text,
          "company": {
            "name": "",
            "catchPhrase": "",
            "bs": "",
          }
        },
      ),
    );
    onQueryChanged("");
    notifyListeners();
  }

  // search users Function
  void onQueryChanged(String query) {
    dataList = searchResults
        .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
