import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cubit/presentation/Auth_Module/LogOut/data/Model/LogOut_Response.dart';

import '../data/repository/logOut_Repository.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  final LogoutRepository _logOutRepository;
  LogOutCubit(this._logOutRepository) : super(LogOutInitial());
  Future LogOut() async {
    emit(LogOutloading());
    final response = await _logOutRepository.logout().then((LogOutResponse)async{
      if (LogOutResponse != null && LogOutResponse.code == 200) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.remove("Token");
        emit(LogOutSuccess());
      } else {
        emit(LogOutFailure("LogOut Failed"));
      }
    },);


  }
}
