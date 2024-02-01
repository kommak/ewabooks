import 'dart:developer';
import 'package:ewabooks/data/repostries/book_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class RemoveFromFavoriteState {}

class RemoveFromFavoriteInitial extends RemoveFromFavoriteState {}

class RemoveFromFavoriteProgress extends RemoveFromFavoriteState {}

class RemoveFromFavoriteSuccess extends RemoveFromFavoriteState {
  String? isRemoveFromFavorite;
  RemoveFromFavoriteSuccess({this.isRemoveFromFavorite});
}

class RemoveFromFavoriteFailure extends RemoveFromFavoriteState {
  final String errorMessage;

  RemoveFromFavoriteFailure(this.errorMessage);
}

class RemoveFromFavoriteCubit extends Cubit<RemoveFromFavoriteState> {
  RemoveFromFavoriteCubit() : super(RemoveFromFavoriteInitial()) {}
  final BookRepository _bookRepository = BookRepository();

  Future<String> sendRemoveFromFavorite({
    required String id,
  }) async {
    try {
      emit(RemoveFromFavoriteProgress());
      String success =
      await _bookRepository.RemoveFromFavorite(
        id:id,
      );

      emit(RemoveFromFavoriteSuccess(isRemoveFromFavorite: success));
      return success;
    } catch (e) {
      log("Unable to send RemoveFromFavorite");
      emit(RemoveFromFavoriteFailure(e.toString()));
      return 'no';
    }
  }
}
