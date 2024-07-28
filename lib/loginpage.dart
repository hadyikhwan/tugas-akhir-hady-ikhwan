import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/homepage.dart';
import 'package:skripsi/homepage_admin.dart';
import 'package:skripsi/signup.dart';
import 'package:skripsi/signup.dart'; // Import the SignUpPage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

Future<bool> login(String email, String password) async {
  try {
    User? user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password))
        .user;
    if (user != null) {
      print("login berhasil");
      return true;
    }
  } on FirebaseAuthException catch (e) {
    print(e.message);
  }
  return false;
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailData = TextEditingController();
  TextEditingController passwordData = TextEditingController();

  void _login() async {
    bool success = await login(emailData.text, passwordData.text);
    if (success) {
      if (emailData.text == "Admin@admin.com") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homepageadmin()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homepage()));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }

  void _signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }

  void _forgotPassword() async {
    print("tes");
    if (emailData.text == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill email form')));
    } else {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailData.text);
      } catch (e) {
        throw Exception(e.toString());
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Check ure email for resetting password')));
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
              SizedBox(width: 50),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/welcome.png", width: 300),
                      SizedBox(height: 30),
                      TextField(
                        controller: emailData,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 125, 154, 225))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 125, 154, 225))),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 125, 154, 225))),
                          hintText: "email",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 125, 154, 225)),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: passwordData,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 125, 154, 225))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 125, 154, 225))),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 125, 154, 225))),
                          hintText: "password",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 125, 154, 225)),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: _forgotPassword,
                            child: Container(
                              child: Text(
                                "forgot password",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 125, 154, 225)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          login(emailData.text, passwordData.text);
                        },
                        child: GestureDetector(
                          onTap: _login,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 125, 154, 225),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10),
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(255, 125, 154, 225))),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8),
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 125, 154, 225),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                image:
                    DecorationImage(image: AssetImage("assets/cokniur.png"))),
          ),
        ],
      ),
    );
  }
}
