// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:skripsi/ecek.dart';
import 'package:skripsi/edit.dart';
import 'package:skripsi/homepage.dart';
import 'package:skripsi/loginpage.dart';
import 'templateCV.dart';

class headerlog extends StatelessWidget implements PreferredSizeWidget {
  const headerlog({super.key});
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
          SizedBox(width: 10), // Adding space between image and text
          Text(
            'Teknologi Informasi',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => LoginPage()));
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, 
              backgroundColor: Colors.blue, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Rounded corners
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10), // Padding inside the button
            ),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 16, // Text size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
