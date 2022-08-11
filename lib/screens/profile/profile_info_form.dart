import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_search_app/commons/elevated_button.dart';
import 'package:movie_search_app/commons/text_field.dart';
import 'package:movie_search_app/config/palette.dart';
import 'package:movie_search_app/firebase/firebase_authentication.dart';
import 'package:movie_search_app/screens/login/login_screen.dart';
import 'package:movie_search_app/utils/input_validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;

class ProfileInfoForm extends StatefulWidget {
  const ProfileInfoForm({Key? key}) : super(key: key);

  @override
  State<ProfileInfoForm> createState() => _ProfileInfoForm();
}

class _ProfileInfoForm extends State<ProfileInfoForm> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  late FirebaseAuthentication auth;
  late FirebaseFirestore firestore;
  String? email;
  String? fullName;
  String? profilePhoto;
  bool loading = true;

  late File? _image = null;

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() async {
      auth = FirebaseAuthentication();
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print(fcmToken);
    });

    getData();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController!.dispose();
    emailController!.dispose();
    super.dispose();
  }

  Future<dynamic> getData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User? currentUser = FirebaseAuth.instance.currentUser;

    DocumentSnapshot user = await users.doc(currentUser!.uid).get();

    Map<String, dynamic> data = user.data() as Map<String, dynamic>;

    setState(() {
      email = data["email"];
      fullName = data["fullName"];
      profilePhoto = data["imageUrl"];
      loading = false;
    });
  }

  Future<dynamic> updateData() async {
    loading = true;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User? currentUser = FirebaseAuth.instance.currentUser;

    users.doc(currentUser!.uid).update({
      "fullName": nameController!.text,
      "email": emailController!.text
    }).then((value) {
      currentUser.updateEmail(emailController!.text).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Update Successful!")));
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Update Error!")));
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Update Error!")));
    });

    setState(() {
      email = emailController!.text;
      fullName = nameController!.text;
      loading = false;
    });
  }

  Future<dynamic> uploadFile(File _image) async {
    final storageRef = FirebaseStorage.instance.ref();

    final imageRef = storageRef.child('users/${path.basename(_image.path)}');

    try {
      await imageRef.putFile(_image);
      final downloadUrl = await imageRef.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<void> saveImages(File _image, DocumentReference ref) async {
    String imageURL = await uploadFile(_image);
    ref.update({"imageUrl": imageURL});
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
    }

    try {
      setState(() {
        if (pickedFile != null) {
          _image =
              File(pickedFile.path); // Use if you only need a single picture
        } else {
          print('No image selected.');
        }
      });

      await saveImages(File(pickedFile!.path), users.doc(currentUser!.uid));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Picture Updated!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Picture Update Error!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: fullName);
    emailController = TextEditingController(text: email);

    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Stack(alignment: Alignment.bottomCenter, children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120.0),
                    child: _image != null
                        ? Image.file(
                            _image!,
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: profilePhoto != null
                                ? profilePhoto!
                                : "https://cdn.dribbble.com/users/1338391/screenshots/15264109/media/1febee74f57d7d08520ddf66c1ff4c18.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            fit: BoxFit.cover,
                            width: 180,
                            height: 180,
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      fillColor: Palette.kToDark,
                      child: const Icon(
                        Icons.add_photo_alternate_rounded,
                        color: Colors.white,
                      ),
                      elevation: 8,
                      onPressed: () {
                        getImage(true);
                      },
                      padding: const EdgeInsets.all(15),
                      shape: const CircleBorder(),
                    ),
                    RawMaterialButton(
                      fillColor: Palette.kToDark,
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                      ),
                      elevation: 8,
                      onPressed: () {
                        getImage(false);
                      },
                      padding: const EdgeInsets.all(15),
                      shape: const CircleBorder(),
                    )
                  ],
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Welcome, $fullName",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                autovalidateMode: _autoValidate,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: nameController!,
                      labelText: "Full Name",
                      icon: Icons.person,
                      obscureText: false,
                      autocorrect: true,
                      suggestions: true,
                      validator: InputValidators.validateFullName,
                      enableBorder: false,
                      filled: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: emailController!,
                      labelText: "Email",
                      icon: Icons.email,
                      obscureText: false,
                      autocorrect: true,
                      suggestions: true,
                      validator: InputValidators.validateEmailAddress,
                      enableBorder: false,
                      filled: false,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomElevatedButton(
                        text: "Update Profile",
                        validateCallback: () async {
                          if (_formKey.currentState!.validate()) {
                            await updateData();
                          } else {
                            setState(() {
                              _autoValidate =
                                  AutovalidateMode.onUserInteraction;
                            });
                          }
                        }),
                    TextButton(
                        onPressed: () {
                          auth.logout().then((value) {
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Logout Successful!")),
                              );

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            }
                          });
                        },
                        child: Transform.scale(
                          scale: 1.1,
                          child: Text("Log Out",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Palette.kToDark,
                              )),
                        ))
                  ],
                ),
              ),
            ],
          );
  }
}
