// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';
import 'package:skripsi/mahasiswa%20aktif/ecek.dart';
import 'package:skripsi/mahasiswa%20aktif/homepage.dart';
import 'package:skripsi/loginpage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
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

class _SignUpState extends State<SignUp> {
  String emailUIN = "@student.ar-raniry.ac.id";
  TextEditingController namaData = new TextEditingController();
  TextEditingController emailData = new TextEditingController();
  TextEditingController passwordData = new TextEditingController();
  TextEditingController nimData = new TextEditingController();
  bool projectBelumSiap = false;
  String pesanError = "";

  Future SignupAlumni(String a, String b, String nim, String nama, String email) async {
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
                .addNamaUser(nama, nim, email);

            if (x != null) {
              await FirebaseAuth.instance.signOut();
              print("Sign up berhasil");
              return true;
            }
          } on FirebaseAuthException catch (e) {
            pesanError = e.message.toString();
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
    } else {
      try {
        //add new account
        User x = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(email: a, password: b))
            .user!;

        //add username
        await Databaseservice(userID: FirebaseAuth.instance.currentUser!.uid)
            .addNamaUser(nama, nim, email);

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

  void _SignupAlumni(String namaUser, String Nim, String Email) async {
    bool success = await SignupAlumni(
        emailData.text, passwordData.text, Nim, namaUser, email);
    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(pesanError), duration: Duration(microseconds: 100),));
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
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: nimData,
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
                          hintText: "NIM",
                          hintStyle: TextStyle(
                              color: const Color.fromARGB(255, 125, 154, 225))),
                    ),
                    SizedBox(
                      height: 10,
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
                      height: 10,
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
                      height: 10,
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
                    SizedBox(height: 25),
                    GestureDetector(
                      onTap: () async {
                        _SignupAlumni(
                            namaData.text, nimData.text, emailData.text);
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
