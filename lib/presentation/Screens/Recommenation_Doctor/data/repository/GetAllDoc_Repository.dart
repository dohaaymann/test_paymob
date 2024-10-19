import 'package:test_cubit/presentation/Screens/Recommenation_Doctor/data/Model/GetAllDoc_Model.dart';

import '../../../../../Core/Server/ApiService.dart';

class GetAllDocRepository {
  final ApiService _apiService = ApiService();
  Future<List<Data>>getallDoc() async {
    final response = await _apiService.GetAllDoctor();
    if (response != null && response.statusCode == 200) {
      print("Returning dataaaaaaaaaaaaaaaaaa");
      var x=GetAllDoctor.fromJson(response.data);
      return x.data!;
    } else {
      throw Exception('Failed to load doctors');
    }
  }
}