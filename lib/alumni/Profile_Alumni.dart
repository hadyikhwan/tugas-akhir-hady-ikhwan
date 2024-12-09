import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/alumni/header_alumni.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';

class ProfileAlumni extends StatelessWidget {
  const ProfileAlumni({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  int statusAlumni = 0;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController pekerjaanController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  TextEditingController emailLama = new TextEditingController();
  TextEditingController emailBaru = new TextEditingController();
  TextEditingController passwordLama = new TextEditingController();
  TextEditingController passwordBaru = new TextEditingController();
  TextEditingController emailData = TextEditingController();

  _forgotPassword() async {
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

  bool isFirst = false;
  getNoting()async{

  }
  getData() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      switch (value['statusPekerjaan']) {
        case "lanjut kuliah":
          statusAlumni = 0;
          break;
        case "bekerja":
          statusAlumni = 1;
          break;
        case "tidak bekerja":
          statusAlumni = 2;
          break;
        case "dll":
          statusAlumni = 3;
          break;
      }
    });
    isFirst = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAlumni(),
      body: FutureBuilder(
          future: isFirst ? getNoting() : getData(),
          builder: (context, snapshot) {
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  width: 450, // Ubah sesuai kebutuhan Anda
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          labelText: 'Your Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        children: [
                                          Container(
                                            width: 300,
                                            height: 237,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Ganti Email",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TextField(
                                                    controller: emailLama,
                                                    decoration: InputDecoration(
                                                        hintText: "email lama"),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextField(
                                                    controller: emailBaru,
                                                    decoration: InputDecoration(
                                                        hintText: "email baru"),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        await FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .verifyBeforeUpdateEmail(
                                                                emailBaru.text);
                                                        print("email : " +
                                                            await FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .email
                                                                .toString());

                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          Text("update email"))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      4), // Membuat border kotak
                                ),
                              ),
                              child: Text(
                                'Change',
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 10), // Mengatur warna teks
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: contactNumberController,
                        decoration: InputDecoration(
                          labelText: 'Nomor Handphone',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        children: [
                                          Container(
                                            width: 300,
                                            height: 237,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Ganti Pasword",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TextField(
                                                    controller: emailData,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Pasword Lama"),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        await _forgotPassword();
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          Text("update email"))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      4), // Membuat border kotak
                                ),
                              ),
                              child: Text(
                                'Change',
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 10), // Mengatur warna teks
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              statusAlumni = 0;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(color: Colors.black54)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: statusAlumni == 0
                                              ? Colors.blue
                                              : Colors.grey,
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Lanjut Kuliah")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              statusAlumni = 1;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(color: Colors.black54)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: statusAlumni == 1
                                              ? Colors.blue
                                              : Colors.grey,
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Bekerja")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              statusAlumni = 2;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(color: Colors.black54)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: statusAlumni == 2
                                              ? Colors.blue
                                              : Colors.grey,
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Tidak Bekerja")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              statusAlumni = 3;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(color: Colors.black54)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: statusAlumni == 3
                                              ? Colors.blue
                                              : Colors.grey,
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Dll")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: pekerjaanController,
                        decoration: InputDecoration(
                          labelText: 'Deskripsi Pekerjaan',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await Databaseservice(
                                      userID: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .addStatusPekerjaan(statusAlumni);

                              /// ----------------------------------------
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(200, 40),
                              backgroundColor:
                                  const Color.fromARGB(255, 33, 150, 243),
                            ),
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
