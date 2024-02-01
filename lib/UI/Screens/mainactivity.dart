
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ewabooks/UI/Screens/favoritescreen.dart';
import 'package:ewabooks/UI/Screens/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../data/cubit/fetch_book_cubit.dart';

class MainAcivityScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _main();
  }
  static Route<MainAcivityScreen> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(builder: (_) => MainAcivityScreen());
  }

}

class _main extends State<MainAcivityScreen> with TickerProviderStateMixin{

  int _bottomNavIndex=0;

  // late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.home,
    Icons.favorite,

  ];
  List <Widget> children=[
    HomeScreen(),
    FavoriteScreen(),
  ];
  @override
  void initState() {
    super.initState();

    _borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );


    Future.delayed(
      Duration(microseconds: 200),
          () => _borderRadiusAnimationController.forward(),
    );
  }

  List<String> dropDown = <String>["Default", "Alphabet", "By Speakers", "In Countries", "On Internet"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
        appBar:  AppBar(
          backgroundColor: primaryColor_,
          centerTitle: true,
          title: Text(_bottomNavIndex==0?"EWA Books":"Favorites"),
          actions: [
            if(_bottomNavIndex==0)
              // Container(
              //   child: DropdownButton<String>(
              //     underline: Container(),
              //     icon: Icon(Icons.sort,color: Colors.white),
              //     items: dropDown.map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(), onChanged: (String? value) {
              //
              //   },
              //   ),
              // )
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  customButton: const Icon(
                    Icons.sort,
                    size: 28,
                    color: Colors.white,
                  ),
                  items: [
                    ...MenuItems.firstItems.map(
                          (item) => DropdownMenuItem<MenuItem>(
                        value: item,
                        child: MenuItems.buildItem(item),
                      ),
                    ),

                  ],
                  onChanged: (value) {
                    MenuItems.onChanged(context, value! as MenuItem);
                  },
                  dropdownStyleData: DropdownStyleData(
                    width: 160,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: primaryColor_,
                    ),
                    offset: const Offset(0, 8),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    customHeights: [
                      ...List<double>.filled(MenuItems.firstItems.length, 48),
                    ],
                    padding: const EdgeInsets.only(left: 16, right: 16),
                  ),
                ),
              ),
            SizedBox(width: 15,)
          ],
        ),
        body: children[_bottomNavIndex],
        //destination screen
    floatingActionButton: FloatingActionButton(onPressed: () {
      Navigator.of(context).pushNamed(
        Routes.add,
      );
    },
      child: Center(
        child: Icon(Icons.add,color: Colors.white,),
      ),
      splashColor: primaryColor_,
      backgroundColor: Colors.black,


    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: AnimatedBottomNavigationBar.builder(
    itemCount: iconList.length,
    tabBuilder: (int index, bool isActive) {
    return Icon(
    iconList[index],
    size: 28,
    color: isActive ? primaryColor_ : Colors.black ,
    );
    },
    activeIndex: _bottomNavIndex,
    gapLocation: GapLocation.center,
    notchSmoothness: NotchSmoothness.verySmoothEdge,
    leftCornerRadius: 32,
    rightCornerRadius: 32,
    onTap: (index) => setState(() => _bottomNavIndex = index),
      splashColor:primaryColor_,
      notchAndCornersAnimation: borderRadiusAnimation,
      splashSpeedInMilliseconds: 500,
      hideAnimationController: _hideBottomBarAnimationController,
      shadow: BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 12,
        spreadRadius: 0.5,
        color: Colors.grey,
      ),
    ),
    );

  }

}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [title, author, year];

  static const title = MenuItem(text: 'By Title', icon: Icons.title);
  static const author = MenuItem(text: 'By Author', icon: Icons.person);
  static const year = MenuItem(text: 'By Year', icon: Icons.date_range);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.title:
        context.read<FetchBookCubit>().fetchBooks(sorting: 'title');
        break;
      case MenuItems.author:
        context.read<FetchBookCubit>().fetchBooks(sorting: 'author');
        break;
      case MenuItems.year:
        context.read<FetchBookCubit>().fetchBooks(sorting: 'year');
        break;

    }
  }
}