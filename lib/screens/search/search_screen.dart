import 'package:flutter/material.dart';
import 'package:movie_search_app/config/palette.dart';
import 'package:movie_search_app/screens/search/search_results_screen.dart';
import 'package:movie_search_app/utils/input_validators.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate,
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Palette.kToDark)),
                  errorStyle: TextStyle(color: Colors.red.shade400),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.red.shade400, width: 1)),
                  fillColor: const Color.fromARGB(255, 243, 243, 243),
                  filled: true,
                  labelText: "Search Movies, TV Shows"),
              validator: (value) {
                return InputValidators.validateSearch(value);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Popular Genres",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 200, 221, 255),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text(
                        "Action",
                        style: TextStyle(
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  const SizedBox(
                    width: 6,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 246, 194, 255),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text(
                        "Fiction",
                        style: TextStyle(
                            color: Colors.purple.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  const SizedBox(
                    width: 6,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 250, 204),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text(
                        "Comedy",
                        style: TextStyle(
                            color: Colors.yellow.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  const SizedBox(
                    width: 6,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 195, 255, 196),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text(
                        "Adventure",
                        style: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Search successful!")),
                    );

                    var searchString = searchController.text;

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchResultsScreen(title: searchString)));

                    _formKey.currentState?.reset();
                  } else {
                    setState(() =>
                        _autoValidate = AutovalidateMode.onUserInteraction);
                  }
                },
                child: Text(
                  'Go'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
