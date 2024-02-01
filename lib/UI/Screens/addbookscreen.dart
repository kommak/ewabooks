
import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ewabooks/UI/Screens/favoritescreen.dart';
import 'package:ewabooks/UI/Screens/homescreen.dart';
import 'package:ewabooks/data/cubit/add_new_book_cubit.dart';
import 'package:ewabooks/data/cubit/fetch_book_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/theme.dart';

class AddBookScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _main();
  }
  static Route<AddBookScreen> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(builder: (_) => AddBookScreen());
  }

}

class _main extends State<AddBookScreen> {

  TextEditingController titlecon=TextEditingController();
  TextEditingController yearcon=TextEditingController();
  TextEditingController authorcon=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
        appBar:  AppBar(
          backgroundColor: primaryColor_,
          centerTitle: true,
          title: Text("Add New book"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body:
            Padding(
              padding: EdgeInsets.only(left: 25,right: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50,),
                    TextFormField(
                      controller: titlecon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter book title';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 15,
                            top: 8,
                            right: 15,
                            bottom: 0
                        ),
                        border: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                        ),
                        hintText: 'Book Title',
                      ),
                    ),
                    SizedBox(height: 25,),
                    TextFormField(
                      controller: authorcon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter book author';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 15,
                            top: 8,
                            right: 15,
                            bottom: 0
                        ),
                        border: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                        ),
                        hintText: 'Book Author',
                      ),
                    ),
                    SizedBox(height: 25,),
                    TextFormField(
                      controller: yearcon,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp("[0-9]"),
                        ),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter publication year';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 15,
                            top: 8,
                            right: 15,
                            bottom: 0
                        ),
                        border: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                        ),
                        hintText: 'Book Publication Year',
                      ),
                    ),
                    SizedBox(height: 25,),

                    InkWell(child:Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200
                      ),
                      clipBehavior: Clip.antiAlias,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text("Upload image (optional)"),
                          Spacer()
                        ],
                      ),
                    ),
                      onTap: (){
                        showOptions();
                      },
                    ),
                    SizedBox(height: 40,),
                    Center(
                      child: InkWell(child:Container(
                        width: 160,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor_,
                          borderRadius: BorderRadius.all(Radius.circular(12))
                        ),
                        child: Center(
                          child: Text("Add Book",style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      onTap: (){
                        if (_formKey.currentState!.validate()) {
                          String im='';
                          if(_image!=null){
                            im=_image!.path;
                          }
                          context.read<AddNewBookCubit>().sendAddNewBook(
                            title: titlecon.text,
                            author: authorcon.text,
                            year: yearcon.text,
                            image: im
                          ).then((value) {
                            context.read<FetchBookCubit>().fetchBooks();
                            Navigator.pop(context);
                          });
                        }
                      },
                      )
                    ),
                  ],
                ),
              ),
            )

    );


  }
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  Future<File> _getImageFileFromAssets(String path) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = "$tempPath/$path";
    var file = File(filePath);
    if (file.existsSync()) {
      return file;
    } else {
      final byteData = await rootBundle.load('assets/$path');
      final buffer = byteData.buffer;
      await file.create(recursive: true);
      return file
          .writeAsBytes(buffer.asUint8List(byteData.offsetInBytes,
          byteData.lengthInBytes));
    }
  }

}