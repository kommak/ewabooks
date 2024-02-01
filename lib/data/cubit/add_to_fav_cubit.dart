import 'dart:developer';
import 'package:ewabooks/data/repostries/book_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class AddToFavoriteState {}

class AddToFavoriteInitial extends AddToFavoriteState {}

class AddToFavoriteProgress extends AddToFavoriteState {}

class AddToFavoriteSuccess extends AddToFavoriteState {
  String? isAddToFavorite;
  AddToFavoriteSuccess({this.isAddToFavorite});
}

class AddToFavoriteFailure extends AddToFavoriteState {
  final String errorMessage;

  AddToFavoriteFailure(this.errorMessage);
}

class AddToFavoriteCubit extends Cubit<AddToFavoriteState> {
  AddToFavoriteCubit() : super(AddToFavoriteInitial()) {}
  final BookRepository _bookRepository = BookRepository();

  Future<String> sendAddToFavorite({
    required String id,
  }) async {
    try {
      emit(AddToFavoriteProgress());
      String success =
      await _bookRepository.AddToFavorite(
        id:id,
      );

      emit(AddToFavoriteSuccess(isAddToFavorite: success));
      return success;
    } catch (e) {
      log("Unable to send AddToFavorite");
      emit(AddToFavoriteFailure(e.toString()));
      return 'no';
    }
  }
}
