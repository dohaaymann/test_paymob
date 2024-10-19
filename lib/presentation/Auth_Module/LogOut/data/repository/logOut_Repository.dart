import '../../../../../Core/Server/ApiService.dart';
import '../Model/LogOut_Response.dart';


// cubit>>repositrory(return Model)>>apiServer
class LogoutRepository {
  final ApiService _apiService = ApiService();
  Future<LogOutResponse> logout() async {
    final response = await _apiService.Logout();
    if (response != null && response.statusCode == 200) {
      return LogOutResponse.fromJson(response.data);
    } else {
      throw Exception('Logout failed');
    }
  }
}