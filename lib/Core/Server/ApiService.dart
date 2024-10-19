import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cubit/Core/ConstString.dart';
import 'package:test_cubit/presentation/Auth_Module/login/data/Model/Login_request_body.dart';

import '../../../../../Core/APi_Links/Api_Links.dart';
import '../../presentation/Auth_Module/LogOut/data/Model/LogOut_Response.dart';

class ApiService {
  late Dio dio;
  ApiService() {
    try {
      BaseOptions options = BaseOptions(
          headers: {
            "Content-Type": "application/json",  // Example header
            // "Authorization": "Bearer your_api_token",  // If required by the API
          },
          baseUrl: ApiLinks.BaseLink,
          connectTimeout: Duration(seconds: 20),
          receiveTimeout: Duration(seconds: 20),
          receiveDataWhenStatusError: true);
      dio = Dio(options);
    } catch (e) {
      print("$e");
    }
  }
   Future Login(LoginRequestBodyModel loginRequestBody)async{
    try{
      print(loginRequestBody.email.toString());
      print(loginRequestBody.password.toString());
      var response = await dio.post('${ApiLinks.login}', data: {
      "email":loginRequestBody.email,
      'password':loginRequestBody.password
    });
    print(response);
    return response;
   } catch (e) {
  if (e is DioException) {
  if (e.response?.statusCode == 401) {
  print("Unauthorized! Check your credentials.");
  } else {
  print("Error: ${e.response?.statusCode} - ${e.response?.statusMessage}");
  }
  } else {
  print("Unexpected error: $e");
  }
  return null;
  }
}

  Future Logout() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var response = await dio.post('${ApiLinks.logOut}',options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${sharedPreferences.get("Token")}",
        }
      ));
      print(response);
      return response;
    } catch (e) {}
  }
  Future GetDataforHome() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var response = await dio.get('${ApiLinks.HomePage}',options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${sharedPreferences.get("Token")}",
          }
      ));
      print(response.toString());
      return response.data;
    } catch (e) {
      print("$e");
      return [];
    }

  }

  Future GetAllDoctor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var response = await dio.get('${ApiLinks.GetDoctor}',options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${sharedPreferences.get("Token")}",
          }
      ));
      print(response.toString());
      return response;
    } catch (e) {
      print("$e");
      return [];
    }

  }
  Future getallDate() async {
    try {
      var response = await dio.get("character");
      print(response.data['results'].toString());
      return response.data['results'];
    } catch (e) {
      print("$e");
      return [];
    }
  }
}
