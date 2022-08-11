import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/screens/home/home_screen.dart';
import 'package:movie_search_app/screens/login/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search_app/screens/register/register_screen.dart';
import 'package:movie_search_app/state/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'config/palette.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: providers,
    child: const MyApp(),
  ));
}

Future<bool> getUser() async {
  return Future.delayed(const Duration(seconds: 1), (() => true));
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<MovieDataProvider>(create: (_) => MovieDataProvider()),
];

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {
        user = FirebaseAuth.instance.currentUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        home: user == null ? const RegisterScreen() : const HomeScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          "/register": (context) => const RegisterScreen(),
          "/login": (context) => const LoginScreen(),
        },
        title: 'Movie Finder',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
            textTheme: GoogleFonts.nunitoTextTheme(
              Theme.of(context)
                  .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
            ),
            primarySwatch: Palette.kToDark),
      ),
    );
  }
}
