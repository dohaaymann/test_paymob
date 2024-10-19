// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:test_cubit/data/repository/characters_repo.dart';
//
// part 'characters_state.dart';
//
// class CharactersCubit extends Cubit<CharactersState> {
//
//   final CharactersRepository charactersRepository;
//   CharactersCubit(this.charactersRepository) : super(CharactersInitial()){
//     getallData();
//   }
//   var mycharacter;
//   Future getallData()async{
//     List<Characters> mycharacters=[];
//
//     print("ddddddddddddddoha");
//     charactersRepository.getallData().then((value){
//       print(value.runtimeType);
//       emit(Charactersloaded(characters: value));
//       mycharacter=value;
//     });
//     return mycharacters;
//   }
//
// }
