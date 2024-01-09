import 'package:flutter/material.dart';
import 'package:project_test/app/home.dart';
import 'package:project_test/auth/login.dart';
import 'package:project_test/auth/signup.dart';
import 'package:project_test/auth/success.dart';
import 'package:project_test/notes/add.dart';
import 'package:project_test/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences sharedPref ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
title: "login",
initialRoute: sharedPref.getString("id") == null ?  "login" : "home",
routes: {
  "home" : (context) => const Home(),
  "login" : (context) => const Login(),
  "signup" : (context) => const SignUp(),
  "success" : (context) => const Success(),
  "addnote" : (context) =>  AddNote(),
  "editnote" : (context) =>  EditNote(),

} ,

    );
  }
}
