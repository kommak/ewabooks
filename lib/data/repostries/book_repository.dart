


import 'package:ewabooks/data/models/bookmodel.dart';

import '../../main.dart';

class BookRepository {
  Future<List<BookModel>> fetchBooks({String? sorting=''}) async {
    List<Map<String, Object?>>?response;
    if(sorting==''){
     response =await database?.rawQuery('SELECT * FROM books');
    }
    else if(sorting=='title'){
    response =await database?.rawQuery('SELECT * FROM books ORDER BY title COLLATE NOCASE ASC');
    }
    else if(sorting=='year'){
     response =await database?.rawQuery('SELECT * FROM books ORDER BY cast(year as integer) DESC');
    }
    else{
     response =await database?.rawQuery('SELECT * FROM books ORDER BY author COLLATE NOCASE ASC');
    }

    List<BookModel> modelList = response!.map(
      (e) {
        return BookModel.fromJson(e);
      },
    ).toList();

    return modelList;
  }
  Future<List<BookModel>> fetchFavoriteBooks() async {
    List<Map<String, Object?>>?response =await database?.rawQuery('SELECT * FROM books WHERE "isfav"=1');
    List<BookModel> modelList = response!.map(
          (e) {
        return BookModel.fromJson(e);
      },
    ).toList();

    return modelList;
  }

  Future<String> AddToFavorite({String id=''}) async {

    int count = await database!.rawUpdate(
        'UPDATE books SET isfav = ? WHERE id = ?',
        [1, id]);

    return count.toString();
  }
  Future<String> RemoveFromFavorite({String id=''}) async {

    int count = await database!.rawUpdate(
        'UPDATE books SET isfav = ? WHERE id = ?',
        [0, id]);

    return count.toString();
  }
  Future<String> AddNewBook({String title='',String author='',String year='',String image=''}) async {

    int id = await  database!.rawInsert('INSERT INTO books(title, author, year,image,rating,isfav)'
        ' VALUES("$title", "$author","$year","$image", 0,0)');


    return id.toString();
  }


}

