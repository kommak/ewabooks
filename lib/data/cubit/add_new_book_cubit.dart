import 'dart:developer';
import 'package:ewabooks/data/repostries/book_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class AddNewBookState {}

class AddNewBookInitial extends AddNewBookState {}

class AddNewBookProgress extends AddNewBookState {}

class AddNewBookSuccess extends AddNewBookState {
  String? isAddNewBook;
  AddNewBookSuccess({this.isAddNewBook});
}

class AddNewBookFailure extends AddNewBookState {
  final String errorMessage;

  AddNewBookFailure(this.errorMessage);
}

class AddNewBookCubit extends Cubit<AddNewBookState> {
  AddNewBookCubit() : super(AddNewBookInitial()) {}
  final BookRepository _bookRepository = BookRepository();

  Future<String> sendAddNewBook({
    required String title,
    required String author,
    required String year,
    required String image,
  }) async {
    try {
      emit(AddNewBookProgress());
      String success =
      await _bookRepository.AddNewBook(
        title: title,
        author: author,
        year: year,
        image: image
      );

      emit(AddNewBookSuccess(isAddNewBook: success));
      return success;
    } catch (e) {
      log("Unable to send AddNewBook");
      emit(AddNewBookFailure(e.toString()));
      return 'no';
    }
  }
}
