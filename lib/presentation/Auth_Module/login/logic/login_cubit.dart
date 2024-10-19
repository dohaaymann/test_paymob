import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/Model/Login_request_body.dart';
import '../data/repository/Login_Repo.dart';

part 'login_state.dart';
class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;
  LoginCubit(this._loginRepository) : super(LoginInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
  Future<void> login() async {
    try {
      emit(Loginloading()); // Emit loading state
      final response = await _loginRepository.login(emailController.text, passwordController.text).
         then((LoginResponse)async{
          if(LoginResponse!=null){
          print("/***********${await LoginResponse.data?.token}***********/");
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("Token", '${await LoginResponse.data?.token}');
          print("Successs");
          emit(LoginSuccess());
        }
      },);
      response.when(success: (loginResponse) async {
        print("Donnnnnnnnnnnnnnnnnnnnnnnnne");
       // Emit success state
      }, failure: (error) {
        print("++++++++++++++ERRORR:$error");
      });
    } catch (e) {
      emit(LoginFailure(e.toString())); // Emit failure state with error message
    }
  }
}