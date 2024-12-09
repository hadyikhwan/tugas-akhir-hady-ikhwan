import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';

class editS7 extends StatelessWidget {
  const editS7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controller1 = [];
    List<TextEditingController> controller2 = [];
    List<TextEditingController> controller3 = [];
    List<TextEditingController> controller4 = [];
    List<TextEditingController> controller5 = [];
    List<TextEditingController> controller6 = [];
    List<TextEditingController> controller7 = [];

    List<String> namaMkSems1 = [
      "Pengantar Teknologi Informasi",
      "Matematik Dasar",
    ];
    List<String> namaMkSems2 = [
      "Algoritma dan Pemrograman",
      "Logika Informatika",
      "Pengantar Jaringan Komputer",
      "Sistem Manajemen Basis Data",
    ];
    List<String> namaMkSems3 = [
      "Struktu Data",
      "Matematika Distrik",
      "Jaringan Komputer Lanjut",
      "Manajemen Informasi",
      "Interaksi Manusia dan Komputer",
    ];
    List<String> namaMkSems4 = [
      "Kecerdasan Bisnis",
      "Pemograman Berorientasi Object",
      "Keamanan Jaringan",
      "Perancangan User Experience",

    ];
    List<String> namaMkSems5 = [
      "Big Data",
      "Keamanan Data dan Informasi",
      "Pemograman Web",
      "Konsep Pengembangan Aplikasi Web dan Mobile",
    ];
    List<String> namaMkSems6 = [
      "Kriptografi",
      "Sistem Web dan Mobile",
      "Teknologi Manuskrip",
      "Internet Of Thinks",
      "Audit IT Security",
      "Komputasi Cloud",
      "Sistem Informasi Geografis",
      "Kecerdasan Buatan",
      "Data Mining",
      "Pemograman Mobile",
      "Sistem Operasi Berbasis Mobile",
      "E-Learning",

    ];
    List<String> namaMkSems7 = [
      "Sistem Forensik, Investigasi dan Respon",
      "Teknologi Blockchain",
      "Software Aplikasi Cluster",
      "Machine Learning",
      "ERP Software dan Manajemen",
      "jaringan Syaraf Tiruan",
      "Pemrosesan Bahasa Alami",
      "Konten Digital",
      "Software Sosial",
      "Bisnis Digital",
    ];
    for (int i = 0; i < namaMkSems1.length; i++) {
      controller1.add(TextEditingController());
    }
    for (int i = 0; i < namaMkSems2.length; i++) {
      controller2.add(TextEditingController());
    }
    for (int i = 0; i < namaMkSems3.length; i++) {
      controller3.add(TextEditingController());
    }
    for (int i = 0; i < namaMkSems4.length; i++) {
      controller4.add(TextEditingController());
    }
    for (int i = 0; i < namaMkSems5.length; i++) {
      controller5.add(TextEditingController());
    }
    for (int i = 0; i < namaMkSems6.length; i++) {
      controller6.add(TextEditingController());
    }
    for (int i = 0; i < namaMkSems7.length; i++) {
      controller7.add(TextEditingController());
    }

    getData() async {
      return await FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("nilaiMK")
          .get()
          .then(
        (value) {
          value.docs.forEach(
            (element) {
              switch (element.id.toString()) {
                case "semester1":
                  controller1[0].text = element["Pengantar Teknologi Informasi"];
                   controller1[1].text = element["Matematika Dasar"];
                  break;
                case "semester2":
                  controller2[0].text = element["Algoritma dan Pemrograman"];
                  controller2[1].text = element["Logika Informatika"];
                  controller2[2].text = element["Pengantar Jaringan Komputer"];
                  controller2[3].text = element["Sistem Manajemen Basis Data"];
                  break;
                case "semester3":
                  controller3[0].text = element["Struktu Data"];
                  controller3[1].text = element["Matematika Distrik"];
                  controller3[2].text = element["Jaringan Komputer Lanjut"];
                  controller3[3].text = element["Manajemen Informasi"];
                  controller3[4].text = element["Interaksi Manusia dan Komputer"];
                  break;
                case "semester4":
                  controller4[0].text = element["Kecerdasan Bisnis"];
                  controller4[1].text = element["Pemograman Berorientasi Object"];
                  controller4[2].text = element["Keamanan Jaringan"];
                  controller4[3].text = element["Perancangan User Experience"];
                  
                  break;
                case "semester5":
                  controller5[0].text = element["Big Data"];
                  controller5[1].text = element["Keamanan Data dan Informasi"];
                  controller5[2].text = element["Pemograman Web"];
                  controller5[3].text = element["Konsep Pengembangan Aplikasi Web dan Mobile"];
                break;
                case "semester6":
                  controller6[0].text = element["Kriptografi"];
                  controller6[1].text = element["Sistem Web dan Mobile"];
                  controller6[2].text = element["Teknologi Manuskrip"];
                  controller6[3].text = element["Internet Of Thinks"];
                  controller6[4].text = element["Audit IT Security"];
                  controller6[5].text = element["Komputasi Cloud"];
                  controller6[6].text = element["Sistem Informasi Geografis"];
                  controller6[7].text = element["Kecerdasan Buatan"];
                  controller6[8].text = element["Data Mining"];
                  controller6[9].text = element["Pemograman Mobile"];
                  controller6[10].text = element["Sistem Operasi Berbasis Mobile"];
                  controller6[11].text = element["E-Learning"];
                  break;
                case "semester7":
                  controller7[0].text = element["Sistem Forensik, Investigasi dan Respon"];
                  controller7[1].text = element["Teknologi Blockchain"];
                  controller7[2].text = element["Software Aplikasi Cluster"];
                  controller7[3].text = element["Machine Learning"];
                  controller7[4].text = element["ERP Software dan Manajemen"];
                  controller7[5].text = element["Jaringan Syaraf Tiruan"];
                  controller7[6].text = element["Pemrosesan Bahasa Alami"];
                  controller7[7].text = element["Konten Digital"];
                  controller7[8].text = element["Software Sosial"];
                  controller7[9].text = element["Bisnis Digital"];
                       
                  break;
              }
            },
          );
        },
      );
    }

    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Profile Info',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'With a focus on practical application and real-world relevance, these courses will equip\nyou with the competencies necessary to excel in today\'s dynamic and \ncompetitive environment.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(136, 70, 70, 70),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Container(
                  width: 500,
                  height: 490,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Semester 1',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        for (int i = 0; i < namaMkSems1.length; i++)
                          formField(
                              nama: namaMkSems1[i], controller: controller1[i]),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Semester 2',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        for (int i = 0; i < namaMkSems2.length; i++)
                          formField(
                              nama: namaMkSems2[i], controller: controller2[i]),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Semester 3',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        for (int i = 0; i < namaMkSems3.length; i++)
                          formField(
                              nama: namaMkSems3[i], controller: controller3[i]),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Semester 4',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        for (int i = 0; i < namaMkSems4.length; i++)
                          formField(
                              nama: namaMkSems4[i], controller: controller4[i]),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Semester 5',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        for (int i = 0; i < namaMkSems5.length; i++)
                          formField(
                              nama: namaMkSems5[i], controller: controller5[i]),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Semester 6',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        for (int i = 0; i < namaMkSems6.length; i++)
                          formField(
                              nama: namaMkSems6[i], controller: controller6[i]),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Semester 7',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        for (int i = 0; i < namaMkSems7.length; i++)
                          formField(
                              nama: namaMkSems7[i], controller: controller7[i]),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Databaseservice(
                                    userID: FirebaseAuth.instance.currentUser!.uid)
                                .addNilaiMk(
                                    controller1,
                                    controller2,
                                    controller3,
                                    controller4,
                                    controller5,
                                    controller6,
                                    controller7);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Save data Successful')));
                          },
                          child: Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue, width: 2),
                              ),
                              child: const Center(
                                  child: Text('Save',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue)))),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class formField extends StatelessWidget {
  final String nama;
  final TextEditingController controller;
  const formField({super.key, required this.nama, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 460,
          height: 50,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.blue, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nama,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '1 - 100',
                      hintStyle: TextStyle(fontSize: 12, color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
