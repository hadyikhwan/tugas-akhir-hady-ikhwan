import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skripsi/admin/dashboard_Admin.dart';
import 'package:skripsi/admin/dashboard_alumni.dart';
import 'package:skripsi/admin/dashboard_event.dart';
import 'package:skripsi/admin/dashboard_hasil.dart';
import 'package:skripsi/admin/dashboard_pengajuan.dart';
import 'package:skripsi/admin/header_Admin.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';

class dashboard_pertanyaan extends StatefulWidget {
  const dashboard_pertanyaan({super.key});

  @override
  State<dashboard_pertanyaan> createState() => _dashboard_pertanyaanState();
}

class data {
  String id = "";
  int no = 0;
  String pertanyaan = '';
  String jawabanA = '';
  String jawabanB = '';
  String jawabanC = '';
  String jawabanD = '';
}

class _dashboard_pertanyaanState extends State<dashboard_pertanyaan> {
  List<data> alumniData = [];
  TextEditingController pertanyaan = new TextEditingController();
  TextEditingController jawabanA = new TextEditingController();
  TextEditingController jawabanB = new TextEditingController();
  TextEditingController jawabanC = new TextEditingController();
  TextEditingController jawabanD = new TextEditingController();

  getData() async {
    alumniData.clear();
    await FirebaseFirestore.instance
        .collection("Admin")
        .doc("0")
        .collection("pertanyaan")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            alumniData.add(data());
            alumniData[alumniData.length - 1].no = alumniData.length;
            alumniData[alumniData.length - 1].id = element.id;
            alumniData[alumniData.length - 1].pertanyaan = element['pertanyaan'];
            alumniData[alumniData.length - 1].jawabanA = element['jawabanA'];
            alumniData[alumniData.length - 1].jawabanB = element['jawabanB'];
            alumniData[alumniData.length - 1].jawabanC = element['jawabanC'];
            alumniData[alumniData.length - 1].jawabanD = element['jawabanD'];
          },
        );
      },
    );
  }

  clearEditor() {
    pertanyaan.text = "";
    jawabanA.text = "";
    jawabanB.text = "";
    jawabanC.text = "";
    jawabanD.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return Column(
            children: [
              header_admin(), // Header
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 180, // Lebar sidebar yang diinginkan
                      child: SideMenu(), // Memanggil SideMenu
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Data Pertanyaan',
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    alumniData.add(data());
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SimpleDialog(
                                          children: [
                                            Container(
                                              width: 600,
                                              height: 435,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 25.0, vertical: 5),
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      Text("Pertanyaan Baru", style: TextStyle(fontSize: 20),),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextField(
                                                        controller: pertanyaan,
                                                        keyboardType:
                                                            TextInputType.number,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "Masukkan Pertanyaan",
                                                        ),
                                                        textAlign: TextAlign.left,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextField(
                                                        controller: jawabanA,
                                                        keyboardType:
                                                            TextInputType.number,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "Masukkan Jawaban A",
                                                        ),
                                                        textAlign: TextAlign.left,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextField(
                                                        controller: jawabanB,
                                                        keyboardType:
                                                            TextInputType.number,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "Masukkan Jawaban B",
                                                        ),
                                                        textAlign: TextAlign.left,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextField(
                                                        controller: jawabanC,
                                                        keyboardType:
                                                            TextInputType.number,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "Masukkan Jawaban C",
                                                        ),
                                                        textAlign: TextAlign.left,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextField(
                                                        controller: jawabanD,
                                                        keyboardType:
                                                            TextInputType.number,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "Masukkan Jawaban D",
                                                        ),
                                                        textAlign: TextAlign.left,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          alumniData[
                                                                  alumniData.length -
                                                                      1]
                                                              .no = alumniData.length;
                                                          alumniData[alumniData
                                                                          .length -
                                                                      1]
                                                                  .pertanyaan =
                                                              pertanyaan.text;
                                                          alumniData[alumniData
                                                                          .length -
                                                                      1]
                                                                  .jawabanA =
                                                              jawabanA.text;
                                                          alumniData[alumniData
                                                                          .length -
                                                                      1]
                                                                  .jawabanB =
                                                              jawabanB.text;
                                                          alumniData[alumniData
                                                                          .length -
                                                                      1]
                                                                  .jawabanC =
                                                              jawabanC.text;
                                                          alumniData[alumniData
                                                                          .length -
                                                                      1]
                                                                  .jawabanD =
                                                              jawabanD.text;
                                                          await Databaseservice(
                                                                  userID:
                                                                      "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
                                                              .tambahPertanyaan(
                                                                  jawabanA.text,
                                                                  jawabanB.text,
                                                                  jawabanD.text,
                                                                  jawabanD.text,
                                                                  pertanyaan.text);
                                                        
                                                          clearEditor();
                                                        
                                                          setState(() {});
                                                        
                                                          Navigator.pop(context);
                                                        },
                                                        child: Container(
                                                          width: 100,
                                                          height: 35,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10),
                                                            color: Colors.purpleAccent,
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            "Tambah",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight.w500),
                                                          )),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              115, 155, 39, 176),
                                          width: 2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5),
                                      child: Column(
                                        children: [
                                          Icon(Icons.add_rounded,
                                              color: const Color.fromARGB(
                                                  115, 155, 39, 176)),
                                          Text(
                                            'Tambah Pertanyaan',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 16),
                            Table(
                              border: TableBorder.all(color: Colors.grey),
                              columnWidths: {
                                0: FlexColumnWidth(0.8),
                                1: FlexColumnWidth(4),
                                2: FlexColumnWidth(4),
                                3: FlexColumnWidth(4),
                                4: FlexColumnWidth(4),
                                5: FlexColumnWidth(4),
                                6: FlexColumnWidth(1.5),
                              },
                              children: [
                                TableRow(
                                  decoration:
                                      BoxDecoration(color: Colors.deepPurpleAccent),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('No',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Pertanyaan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Jawaban A',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('jawaban B',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Jawaban C',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Jawaban D',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                                for (int i = 0; i < alumniData.length; i++)
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(alumniData[i].no.toString()),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(alumniData[i].pertanyaan),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(alumniData[i].jawabanA),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(alumniData[i].jawabanB),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(alumniData[i].jawabanC),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(alumniData[i].jawabanD),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: Colors.red),
                                              onPressed: () async{
                                                await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2").hapusPertanyaan(alumniData[i].id);
                                               
                                                setState(() {
                                                  
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class Question {
  final String no;
  final String pernyataan;
  final String jawabanA;
  final String jawabanB;
  final String jawabanC;
  final String jawabanD;

  Question({
    required this.no,
    required this.pernyataan,
    required this.jawabanA,
    required this.jawabanB,
    required this.jawabanC,
    required this.jawabanD,
  });
}

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurpleAccent,
      child: ListView(
        children: [
          DrawerListTile(
            title: "",
            svgSrc: "",
            press: () {},
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/menu_dashboard.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardAdmin()));
            },
          ),
          DrawerListTile(
            title: "Alumni",
            svgSrc: "assets/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardAlumni()));
            },
          ),
          DrawerListTile(
            title: "Pertanyaan",
            svgSrc: "assets/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Grafik",
            svgSrc: "assets/menu_task.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardHasil()));
            },
          ),
          DrawerListTile(
            title: "Event",
            svgSrc: "assets/menu_store.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => dashboard_event()));
            },
          ),
          DrawerListTile(
            title: "Pengajuan",
            svgSrc: "assets/menu_notification.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardPengajuan()));
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(
            Color.fromARGB(255, 255, 255, 255), BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}
