// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';
import 'package:skripsi/homepage.dart';
import 'package:skripsi/loginpage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

String checkString(String data) {
  bool ditemukan = false;
  String hasilFilter = "";
  for (int i = 0; i < data.length; i++) {
    if (data[i] == '@') {
      ditemukan = true;
    }

    if (ditemukan) {
      hasilFilter += data[i];
    }
  }

  return hasilFilter;
}

class _SignupState extends State<Signup> {
  String emailUIN = "@student.ar-raniry.ac.id";
  TextEditingController namaData = new TextEditingController();
  TextEditingController emailData = new TextEditingController();
  TextEditingController passwordData = new TextEditingController();
  bool projectBelumSiap = true;

  Future signUp(String a, String b) async {
    if (!projectBelumSiap) {
      if (namaData.text != "" &&
          emailData.text != "" &&
          passwordData.text != "") {
        if (checkString(a) == emailUIN) {
          try {
            //add new account
            User x = (await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(email: a, password: b))
                .user!;

            //add username
            await Databaseservice(
                    userID: FirebaseAuth.instance.currentUser!.uid)
                .addNamaUser(namaData.text);

            if (x != null) {
              await FirebaseAuth.instance.signOut();
              print("Sign up berhasil");
              return true;
            }
          } on FirebaseAuthException catch (e) {
            print(e.message);
          }
          return false;
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Sorry, Not UIN Account')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Please fill all form')));
      }
    }else {
       try {
            //add new account
            User x = (await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(email: a, password: b))
                .user!;

            //add username
            await Databaseservice(
                    userID: FirebaseAuth.instance.currentUser!.uid)
                .addNamaUser(namaData.text);

            if (x != null) {
              await FirebaseAuth.instance.signOut();
              print("Sign up berhasil");
              return true;
            }
          } on FirebaseAuthException catch (e) {
            print(e.message);
          }
          return false;
        
    }
  }

  void _signUp() async {
    bool success = await signUp(emailData.text, passwordData.text);
    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign Up failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Padding(
                padding: const EdgeInsets.only(left: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/welcome.png",
                      width: 300,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: namaData,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                      255, 125, 154, 225))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                      255, 125, 154, 225))),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                      255, 125, 154, 225))),
                          hintText: "Nama Lengkap",
                          hintStyle: TextStyle(
                              color: const Color.fromARGB(255, 125, 154, 225))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: emailData,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                      255, 125, 154, 225))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                      255, 125, 154, 225))),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                      255, 125, 154, 225))),
                          hintText: "email",
                          hintStyle: TextStyle(
                              color: const Color.fromARGB(255, 125, 154, 225))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordData,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                      255, 125, 154, 225))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                      255, 125, 154, 225))),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                      255, 125, 154, 225))),
                          hintText: "password",
                          hintStyle: TextStyle(
                              color: const Color.fromARGB(255, 125, 154, 225))),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        _signUp();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 125, 154, 225),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 10),
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 2,
                                color:
                                    const Color.fromARGB(255, 125, 154, 225))),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 125, 154, 225),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/cokniur.png"))),
        )
      ],
    ));
  }
}
