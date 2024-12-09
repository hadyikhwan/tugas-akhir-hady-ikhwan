// custom_app_bar.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/admin/dashboard_Admin.dart';
import 'package:skripsi/mahasiswa%20aktif/ecek.dart';
import 'package:skripsi/mahasiswa%20aktif/edit.dart';
import 'package:skripsi/mahasiswa%20aktif/homepage.dart';
import 'package:skripsi/admin/homepage_admin.dart';
import 'package:skripsi/landingpage.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:pdf/pdf.dart' as pw;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class experienceComponents {
  String jobDescription = "";
  String linkDocument = "";
  String nameOfInstitution = "";
  String positionTitle = "";
  String year = "";
}

class achievementComponents {
  String deskripsi = "";
  String linkDocument = "";
  String nameOfCompetition = "";
  String ranking = "";
  String year = "";
}

class experience {
  String? description;
  String? year;
  String? institution;
}

class achievement {
  String? description;
  String? year;
  String? Competition;
}

class header_admin extends StatelessWidget implements PreferredSizeWidget {
  const header_admin({super.key});

  @override
  Size get preferredSize => Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      toolbarHeight: 65,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Image.asset(
            'assets/uinar.png',
            width: 65,
            height: 65,
          ),
          Text(
            'Teknologi Informasi',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => homepageadmin()));
          },
          child: Text('Homepage', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DashboardAdmin()));
          },
          child: Text('Dashboard', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () async {
            //logout
            try {
              await FirebaseAuth.instance.signOut();
            } on FirebaseAuthException catch (e) {
              print(e.message);
            }

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Landingpage()));
          },
          child: Text('Logout', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}




