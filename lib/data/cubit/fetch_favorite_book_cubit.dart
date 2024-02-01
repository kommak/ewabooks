// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/bookmodel.dart';
import '../repostries/book_repository.dart';


abstract class FetchFavoriteBookState {}

class FetchFavoriteBookInitial extends FetchFavoriteBookState {}

class FetchFavoriteBookInProgress extends FetchFavoriteBookState {}

class FetchFavoriteBookSuccess extends FetchFavoriteBookState {
  final int total;
  final int offset;
  final bool isLoadingMore;
  final bool hasError;
  final List<BookModel> FavoriteBooks;
  FetchFavoriteBookSuccess({
    required this.total,
    required this.offset,
    required this.isLoadingMore,
    required this.hasError,
    required this.FavoriteBooks,
  });

  FetchFavoriteBookSuccess copyWith({
    int? total,
    int? offset,
    bool? isLoadingMore,
    bool? hasError,
    List<BookModel>? FavoriteBooks,
  }) {
    return FetchFavoriteBookSuccess(
      total: total ?? this.total,
      offset: offset ?? this.offset,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasError: hasError ?? this.hasError,
      FavoriteBooks: FavoriteBooks ?? this.FavoriteBooks,
    );
  }



  @override
  String toString() {
    return 'FetchFavoriteBookSuccess(total: $total, offset: $offset, isLoadingMore: $isLoadingMore, hasError: $hasError, FavoriteBooks: $FavoriteBooks)';
  }
}

class FetchFavoriteBookFailure extends FetchFavoriteBookState {
  final String errorMessage;

  FetchFavoriteBookFailure(this.errorMessage);
}

class FetchFavoriteBookCubit extends Cubit<FetchFavoriteBookState> with HydratedMixin {
  FetchFavoriteBookCubit() : super(FetchFavoriteBookInitial());

  final BookRepository _FavoriteBookRepository = BookRepository();

  fetchFavoriteBooks({bool? forceRefresh}) async {
    try {
        emit(FetchFavoriteBookInProgress());


      List<BookModel> FavoriteBook =
          await _FavoriteBookRepository.fetchFavoriteBooks();

      emit(FetchFavoriteBookSuccess(
          total: FavoriteBook.length,
          offset: 0,
          hasError: false,
          isLoadingMore: false, FavoriteBooks: FavoriteBook));
    } catch (e) {
      print(e.toString());
      emit(FetchFavoriteBookFailure(e.toString(

      )));
    }
  }



  @override
  FetchFavoriteBookState? fromJson(Map<String, dynamic> json) {

    return null;
  }

  @override
  Map<String, dynamic>? toJson(FetchFavoriteBookState state) {

    return null;
  }
}
