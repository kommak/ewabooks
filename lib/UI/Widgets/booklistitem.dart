import 'dart:io';

import 'package:ewabooks/app/theme.dart';
import 'package:ewabooks/data/cubit/add_to_fav_cubit.dart';
import 'package:ewabooks/data/cubit/remove_from_fav_cubit.dart';
import 'package:ewabooks/data/models/bookmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

import '../../data/cubit/fetch_favorite_book_cubit.dart';

class BookListItem extends StatefulWidget{
  BookModel? book;
  BookListItem({this.book});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BookListItem();
  }
}


class _BookListItem extends State<BookListItem>{

  bool fav=false;
  bool anim=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.book!.isfav=='1'){
      fav=true;
    }
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    // TODO: implement build
    return

      Container(
        height: 110,
        width: width-30,
        padding: EdgeInsets.only(left: 12,right: 12,top: 10,bottom: 10),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.grey,width: 0.7),
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Row(
          children: [
            Container(
              height: 90,
              width: 70,
              decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child:widget.book!.image.toString()==""?
              Image.asset(
                "assets/icons/ewaicon.png",
                fit: BoxFit.contain,
                width: 70,
                height: 90,
              ):
              ( widget.book!.image.toString().contains("assets"))?Image.asset(
                widget.book!.image.toString(),
                fit: BoxFit.fill,
                width: 70,
                height: 90,
              ):Image.file(
                File(widget.book!.image.toString()),
                fit: BoxFit.fill,
                width: 70,
                height: 90,
              ),
            ),
            SizedBox(width: 20,),
            Expanded(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4,),
                Text(widget.book!.title.toString(),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 4,),
                Text(widget.book!.author.toString(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4,),
                Text(widget.book!.year.toString(),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10,),
                RatingBarIndicator(
                  rating: widget.book!.rating??0,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 15,
                  direction: Axis.horizontal,
                ),
              ],
            )
            ),
            SizedBox(width: 12,),
            Container(
                width: 40,
                height: 90,
                child:Column(
                  children: [
                    InkWell(child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.grey,width: 0.7),
                      ),
                      child: Center(
                        child: !anim?Icon(
                            !fav?Icons.favorite_border:Icons.favorite,
                          color: !fav?Colors.grey:primaryColor_,
                        ): SizedBox(
                          width: 25,
                          height: 25,
                          child:  Lottie.asset('assets/lottie/newsuc.json',repeat: false),
                        ),
                      ),
                    ),
                    onTap: (){
                      if(!fav){
                        context.read<AddToFavoriteCubit>().sendAddToFavorite(
                          id:widget.book!.id.toString()
                        );
                      }
                      else{
                        context.read<RemoveFromFavoriteCubit>().sendRemoveFromFavorite(
                            id:widget.book!.id.toString()
                        ).then((value) {
                          context.read<FetchFavoriteBookCubit>().fetchFavoriteBooks();
                        });
                      }
                      setState(() {
                        fav=!fav;
                        anim=true;
                      });
                      Future.delayed(Duration(milliseconds:1600 ), () {
                        setState(() {
                          anim=false;
                        });
                      });
                    },
                    )
                  ],
                )

            )
          ],
        ),
      )
    ;
  }

}