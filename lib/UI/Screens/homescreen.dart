
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ewabooks/data/cubit/fetch_book_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../app/theme.dart';
import '../Widgets/booklistitem.dart';
import '../Widgets/shimmerLoadingContainer.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _home();
  }

}

class _home extends State<HomeScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchBookCubit>().fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return
      Scaffold(
        body:Container(
          padding: EdgeInsets.only(left: 15,right: 15,top: 18,bottom: 10),
          child:
            BlocConsumer<FetchBookCubit,FetchBookState>(
              listener: (context, state) {

              },
              builder: (context, state) {
                if (state is FetchBookInProgress) {
                  return SizedBox(
                    child: ListView.builder(
                        // padding: const EdgeInsets.symmetric(
                        //   horizontal: 20,
                        //   vertical: 20,
                        // ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CustomShimmer(),
                          );
                        }),
                  );
                }

                if (state is FetchBookFailure) {
                }
                if (state is  FetchBookSuccess) {
                  return SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        return
                          BookListItem(book:state.books[index])
                          ;
                      },
                    ),
                  );
                }

                return Container();

              },
            ),

        ) ,
    );

      ;
  }

}


