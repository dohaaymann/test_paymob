import 'package:test_cubit/presentation/Auth_Module/login/data/Model/Login_Response.dart';
import '../../../../../Core/Server/ApiService.dart';
import '../../../../Auth_Module/login/data/Model/Login_request_body.dart';

class LoginRepository {
  final ApiService _apiService;
  LoginRepository(this._apiService);

  Future<LoginResponse> login(String email, String password) async {
    final requestBody = LoginRequestBodyModel(email: email, password: password);
    final response = await _apiService.Login(requestBody);
    if (response != null && response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception('Login failed');
    }
  }
}

