import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_search_app/constants/styles.dart';

class EasterEggScreen extends StatefulWidget {
  const EasterEggScreen({Key? key}) : super(key: key);

  @override
  State<EasterEggScreen> createState() => _EasterEggState();
}

class _EasterEggState extends State<EasterEggScreen> {
  final nameController = TextEditingController();
  late FlutterSecureStorage storage;
  String? name = "";

  @override
  void initState() {
    super.initState();
    storage = const FlutterSecureStorage();
    readValue();
  }

  void readValue() async {
    String? value = await storage.read(key: "name");
    setState(() {
      name = value;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Easter Egg"),
          backgroundColor: kcPrimarySwatch[900],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 16, right: 16),
              child: Text(
                "Easter Egg",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 16, left: 16, right: 16, bottom: 10),
              child: Text(
                "Even if you close the app, the value will still be here. It's like magic!",
                style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: const Icon(Icons.egg),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: kcPrimarySwatch[900]!,
                          style: BorderStyle.solid,
                        ),
                      ),
                      errorStyle: TextStyle(color: Colors.red.shade400),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red.shade400, width: 1),
                      ),
                      fillColor: const Color.fromARGB(255, 243, 243, 243),
                      filled: true,
                      labelText: "Enter any value you like",
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await storage.write(
                          key: "name", value: nameController.text);

                      setState(() {
                        name = nameController.text;
                      });

                      nameController.clear();
                    },
                    child: Text(
                      "Save Securely",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: kcPrimarySwatch[900],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Value you've written securely is: $name",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
