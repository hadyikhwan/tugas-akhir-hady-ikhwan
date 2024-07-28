import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network("https://img.okezone.com/content/2023/10/09/206/2897427/7-klan-terkuat-dalam-kisah-naruto-ada-nenek-moyang-para-ninja-O3InKsvpEW.jpg"),
    );
  }
}