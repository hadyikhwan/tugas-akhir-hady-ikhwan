import 'package:flutter/material.dart';
import 'package:skripsi/edit.dart';
import 'package:skripsi/editS2.dart';
import 'package:skripsi/editS3.dart';
import 'package:skripsi/editS4.dart';
import 'package:skripsi/editS5.dart';
import 'package:skripsi/editS6.dart';
import 'package:skripsi/editS7.dart';
import 'package:skripsi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skripsi/landingpage.dart';
import 'package:skripsi/loginpage.dart';
import 'package:skripsi/signup.dart';
import 'package:skripsi/tes.dart';



void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Portfolio Mahasiswa TI UINAR",
      home: LoginPage(),
    );
  }
}
