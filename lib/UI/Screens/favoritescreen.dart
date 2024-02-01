

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

import '../../app/theme.dart';
import '../../data/cubit/fetch_book_cubit.dart';
import '../../data/cubit/fetch_favorite_book_cubit.dart';
import '../Widgets/booklistitem.dart';
import '../Widgets/shimmerLoadingContainer.dart';

class FavoriteScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _fav();
  }

}


class _fav extends State<FavoriteScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchFavoriteBookCubit>().fetchFavoriteBooks();
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
          BlocConsumer<FetchFavoriteBookCubit,FetchFavoriteBookState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              if (state is FetchFavoriteBookInProgress) {
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

              if (state is FetchFavoriteBookFailure) {
              }
              if (state is  FetchFavoriteBookSuccess) {
                if(state.FavoriteBooks.isNotEmpty) {
                  return SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.FavoriteBooks.length,
                      itemBuilder: (context, index) {
                        return
                          BookListItem(book: state.FavoriteBooks[index])
                        ;
                      },
                    ),
                  );
                }
                else{
                  return
                    Container(
                      width: width,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 350,
                            height: 350,
                            child:  Lottie.asset('assets/lottie/emptyfav.json',repeat: true),
                          ),
                          SizedBox(height: 25,),
                          Text("Your favorite list is empty",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),),
                          SizedBox(height: 60,),

                        ],
                      ),
                    )
                      ;
                }
              }

              return Container();

            },
          ),

        ) ,
      );

    ;
  }

}