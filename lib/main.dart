import 'package:ewabooks/data/cubit/add_new_book_cubit.dart';
import 'package:ewabooks/data/cubit/add_to_fav_cubit.dart';
import 'package:ewabooks/data/cubit/fetch_book_cubit.dart';
import 'package:ewabooks/data/cubit/fetch_favorite_book_cubit.dart';
import 'package:ewabooks/data/cubit/remove_from_fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'app/app_theme.dart';
import 'app/routes.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'data/bloc_observer.dart';


Database? database;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'ewabooks.db');

// open the database
  database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT,author TEXT,year TEXT,image TEXT, rating REAL,isfav INTEGER)');
        db.rawInsert('INSERT INTO books(title, author, year,image,rating,isfav) VALUES("Harry Potter", "Jack Throne","2008","assets/images/harrypotter.jpg", 4.5,0)');
        db.rawInsert('INSERT INTO books(title, author, year,image,rating,isfav) VALUES("Fire Dance", "I Lana C.Myer","2017","assets/images/firedance.jpg", 4.5,0)');
        db.rawInsert('INSERT INTO books(title, author, year,image,rating,isfav) VALUES("Lost", "S.D Rowards","2014","assets/images/lost.webp", 3.5,0)');
        db.rawInsert('INSERT INTO books(title, author, year,image,rating,isfav) VALUES("Memory", "Angelina Alido","2021","assets/images/memory.jpg", 4,0)');
        db.rawInsert('INSERT INTO books(title, author, year,image,rating,isfav) VALUES("Only words", "Shane Ashby","2016","assets/images/onlywords.jpg", 4.5,0)');
        db.rawInsert('INSERT INTO books(title, author, year,image,rating,isfav) VALUES("Soul", "Olivia Wilson","2023","assets/images/soul.jpg", 5,0)');
      });


  runApp(const EntryPoint());
}

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);
  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => FetchBookCubit()),
      BlocProvider(create: (context) => FetchFavoriteBookCubit()),
      BlocProvider(create: (context) => AddToFavoriteCubit()),
      BlocProvider(create: (context) => RemoveFromFavoriteCubit()),
      BlocProvider(create: (context) => AddNewBookCubit()),
    ], child: MyApp());
  }
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      initialRoute: Routes.splash,
      title: "EWA Books",
      debugShowCheckedModeBanner: false,
      theme: appThemeData[AppTheme.light],
      onGenerateRoute: Routes.onGenerateRouted,
      builder: (context, child) {
        return child!;
      },
    );
  }
}
