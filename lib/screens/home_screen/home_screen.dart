import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/shared/bottom_nav.dart';
import 'package:movie_search_app/screens/favorite_movies/favorites_screen.dart';
import 'package:movie_search_app/screens/featured_movies/featured_screen.dart';
import 'package:movie_search_app/screens/offline_movies/offline_movies.dart';
import 'package:movie_search_app/screens/user_profile/profile_screen.dart';
import 'package:movie_search_app/screens/search_movies/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.username}) : super(key: key);

  final String? username;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Widget> _pages = <Widget>[
    FeaturedScreen(),
    SearchScreen(),
    FavoritesScreen(),
    OfflineMoviesScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;
  Map? arg;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.notification?.body ?? "")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.username ?? "Guest User",
              style: const TextStyle(fontWeight: FontWeight.bold))),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        changeHandler: _onItemTapped,
      ),
    );
  }
}
