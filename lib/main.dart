import 'package:flutter/material.dart';
import 'package:skripsi/admin/dashboard_Admin.dart';
import 'package:skripsi/admin/dashboard_alumni.dart';
import 'package:skripsi/admin/dashboard_hasil.dart';
import 'package:skripsi/admin/dashboard_pertanyaan.dart';
import 'package:skripsi/admin/ecek_admin.dart';
import 'package:skripsi/alumni/Profile_Alumni.dart';
import 'package:skripsi/ecek_guest.dart';
import 'package:skripsi/mahasiswa%20aktif/edit.dart';
import 'package:skripsi/mahasiswa%20aktif/editS2.dart';
import 'package:skripsi/mahasiswa%20aktif/editS3.dart';
import 'package:skripsi/mahasiswa%20aktif/editS4.dart';
import 'package:skripsi/mahasiswa%20aktif/editS5.dart';
import 'package:skripsi/mahasiswa%20aktif/editS6.dart';
import 'package:skripsi/mahasiswa%20aktif/editS7.dart';
import 'package:skripsi/alumni/event.dart';
import 'package:skripsi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skripsi/alumni/grafik_alumni.dart';
import 'package:skripsi/admin/header_Admin.dart';
import 'package:skripsi/alumni/header_alumni.dart';
import 'package:skripsi/admin/homepage_admin.dart';
import 'package:skripsi/alumni/homepage_alumni.dart';
import 'package:skripsi/alumni/kuesioner.dart';
import 'package:skripsi/landingpage.dart';
import 'package:skripsi/loginpage.dart';
import 'package:skripsi/mahasiswa%20aktif/homepage.dart';
import 'package:skripsi/pilihanlogin.dart';
import 'package:skripsi/signup.dart';
import 'package:skripsi/alumni/homepage_alumni.dart';



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
      debugShowCheckedModeBanner: false,
      home: Landingpage(),
    );
  }
}
