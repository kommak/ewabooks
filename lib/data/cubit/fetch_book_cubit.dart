// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:ewabooks/data/models/bookmodel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../repostries/book_repository.dart';

abstract class FetchBookState {}

class FetchBookInitial extends FetchBookState {}

class FetchBookInProgress extends FetchBookState {}

class FetchBookSuccess extends FetchBookState {
  final int total;
  final int offset;
  final bool isLoadingMore;
  final bool hasError;
  final List<BookModel> books;
  FetchBookSuccess({
    required this.total,
    required this.offset,
    required this.isLoadingMore,
    required this.hasError,
    required this.books,
  });

  FetchBookSuccess copyWith({
    int? total,
    int? offset,
    bool? isLoadingMore,
    bool? hasError,
    List<BookModel>? books,
  }) {
    return FetchBookSuccess(
      total: total ?? this.total,
      offset: offset ?? this.offset,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasError: hasError ?? this.hasError,
      books: books ?? this.books,
    );
  }



  @override
  String toString() {
    return 'FetchBookSuccess(total: $total, offset: $offset, isLoadingMore: $isLoadingMore, hasError: $hasError, books: $books)';
  }
}

class FetchBookFailure extends FetchBookState {
  final String errorMessage;

  FetchBookFailure(this.errorMessage);
}

class FetchBookCubit extends Cubit<FetchBookState> with HydratedMixin {
  FetchBookCubit() : super(FetchBookInitial());

  final BookRepository _BookRepository = BookRepository();

  fetchBooks({bool? forceRefresh,String? sorting=''}) async {
    try {
        emit(FetchBookInProgress());


      List<BookModel> Book =
          await _BookRepository.fetchBooks(sorting: sorting);

      emit(FetchBookSuccess(
          total: Book.length,
          offset: 0,
          hasError: false,
          isLoadingMore: false, books: Book));
    } catch (e) {
      print(e.toString());
      emit(FetchBookFailure(e.toString(

      )));
    }
  }



  @override
  FetchBookState? fromJson(Map<String, dynamic> json) {

    return null;
  }

  @override
  Map<String, dynamic>? toJson(FetchBookState state) {

    return null;
  }
}
