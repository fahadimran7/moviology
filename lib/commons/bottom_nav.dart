import 'package:flutter/material.dart';
import 'package:movie_search_app/config/palette.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(
      {Key? key, required this.selectedIndex, required this.changeHandler})
      : super(key: key);

  final int selectedIndex;
  final Function changeHandler;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wifi_off_outlined),
          label: 'Offline',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Palette.kToDark,
      onTap: (index) => widget.changeHandler(index),
    );
  }
}
