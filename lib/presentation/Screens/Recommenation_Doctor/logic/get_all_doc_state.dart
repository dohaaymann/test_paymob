part of 'get_all_doc_cubit.dart';

@immutable
sealed class GetAllDocState {}

final class GetAllDocInitial extends GetAllDocState {}
class GetAllDocloading extends GetAllDocState {}
class GetAllDocSuccess extends GetAllDocState {
  final List<Data> doctors; // Pass the list of doctors in success state
  GetAllDocSuccess({required this.doctors});
}class GetAllDocFailure extends GetAllDocState {
  final String error;
  GetAllDocFailure(this.error);
}

