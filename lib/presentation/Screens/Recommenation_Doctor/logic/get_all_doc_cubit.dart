import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_cubit/presentation/Screens/Recommenation_Doctor/data/Model/GetAllDoc_Model.dart';
import 'package:test_cubit/presentation/Screens/Recommenation_Doctor/data/repository/GetAllDoc_Repository.dart';

part 'get_all_doc_state.dart';

class GetAllDocCubit extends Cubit<GetAllDocState> {
  GetAllDocCubit() : super(GetAllDocInitial());
  GetAllDocRepository getAllDocRepository = GetAllDocRepository();
   List<GetAllDoctor> xx=[];
  Future getAllDoc()async{
    emit(GetAllDocloading());
    try {
      final response = await getAllDocRepository.getallDoc();

      // Assuming response.data is of type List<Data>, directly assign it
      final List<Data>? doctors = response;

      // Emit success state with doctors list if data is not null
      if (doctors != null) {
        emit(GetAllDocSuccess(doctors: doctors));
      } else {
        emit(GetAllDocFailure( "No doctors found"));
      }

    } catch (error) {
      // Handle error and emit error state
      emit(GetAllDocFailure(error.toString()));
    }
  }
}
